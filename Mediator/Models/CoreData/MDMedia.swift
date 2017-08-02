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

public class MDMedia: Object, MDModelProtocol {
    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var fileName = ""
    @objc dynamic var thumbName = ""
    @objc dynamic var audioName: String? = nil
    @objc dynamic var importDate = Date()
    @objc dynamic var type: Int = 0
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    override public static func indexedProperties() -> [String] {
        return ["importDate"]
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
