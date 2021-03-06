//
//  MDMedia.swift
//  Mediator
//
//  Created by VuVince on 7/15/17.
//Copyright © 2017 VuVince. All rights reserved.
//

import Foundation
import RealmSwift
import AVFoundation

class MDMedia: Object, MDModelProtocol {
    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var fileName = ""
    @objc dynamic var thumbName = ""
    @objc dynamic var audioName: String? = nil
    @objc dynamic var importDate = Date()
    @objc dynamic var type: Int = 0
    
    lazy var thumbImage = UIImage(contentsOfFile: getThumbURL().path)
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["importDate"]
    }
    
    func clone() -> MDMedia {
        let media = MDMedia()
        media.id = UUID().uuidString
        media.title = title
        media.fileName = fileName
        media.thumbName = thumbName
        media.audioName = audioName
        media.type = type
        return media
    }
    
    func deleteAndCleanFiles() {
        do {
            try FileManager.default.removeItem(at: getVideoURL())
            try FileManager.default.removeItem(at: getThumbURL())
            if let audioURL = getAudioURL() {
                try FileManager.default.removeItem(at: audioURL)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
//MARK: Players
extension MDMedia {
    
    func getVideoPlayer() -> AVPlayer {
        let playItem = AVPlayerItem(url: getVideoURL())
        return AVPlayer(playerItem: playItem)
    }
    
    func getAudioPlayer() -> AVAudioPlayer? {
        if let url = getAudioURL() {
            return try! AVAudioPlayer(contentsOf: url)
        }
        return nil
    }
}

//MARK: Thumbnail and URLs
extension MDMedia {
    func generatePaths(from _videoURL: URL, audioURL: URL?) {
        id = UUID().uuidString
        let videoExtension = _videoURL.pathComponents.last?.components(separatedBy: ".").last
        fileName = id.appending(".\(videoExtension!)")
        thumbName = id.appending(".png")
        if let audioExtension = audioURL?.pathComponents.last?.components(separatedBy: ".").last {
            audioName = id.appending(".\(audioExtension)")
        }
    }
    
    func getVideoURL() -> URL {
        return MDMedia.getFolerURL().appendingPathComponent(fileName, isDirectory: true)
    }
    
    func getThumbURL() -> URL {
        return MDMedia.getFolerURL().appendingPathComponent(thumbName, isDirectory: true)
    }
    
    func getAudioURL() -> URL? {
        if let audioFileName = audioName {
            return MDMedia.getFolerURL().appendingPathComponent(audioFileName, isDirectory: true)
        }
        return nil
    }
    
    class func getFolderName() -> String {
        return "media"
    }
    
    class func getFolerURL() -> URL {
        return FileManager.getDocumentsDirectory().appendingPathComponent(MDMedia.getFolderName(), isDirectory: true)
    }
}
