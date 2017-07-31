//
//  MDMediaImporter.swift
//  Mediator
//
//  Created by VuVince on 7/9/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices


class MDMediaImporter: NSObject {
    static let sharedInstance = MDMediaImporter()
    
    @discardableResult class func presentImagePickerVC(fromVC: UIViewController,
                                    animated flag: Bool,
                                    completion: (() -> Swift.Void)? = nil) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self.sharedInstance
        picker.sourceType = .photoLibrary
        picker.mediaTypes = [kUTTypeMovie as String]
        fromVC.present(picker, animated: flag, completion: completion)
        return picker
    }
    
}

//MARK: - Picker Delegates
extension MDMediaImporter: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        do {
            try importMedia(info: info)
        } catch let error {
            print(error.localizedDescription)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - File processing
fileprivate extension MDMediaImporter {
    
    func importMedia(info: [String : Any]) throws {
        let fileURL = info[UIImagePickerControllerMediaURL] as! URL
        
        let video = MDMedia()
        video.generatePaths(from: fileURL, audioURL: nil)
        let videoURL = video.getVideoURL()
        //move items
        do {
            try FileManager.default.moveItem(at: fileURL, to: videoURL)
            try saveThumbnailFrom(videoURL: videoURL, toURL: video.getThumbURL())
            try MDDBManager.defaultManager.write {
                MDDBManager.defaultManager.add(video)
            }
        } catch let error {
            try! FileManager.default.removeItem(at: fileURL)
            try! FileManager.default.removeItem(at: videoURL)
            try! FileManager.default.removeItem(at: video.getThumbURL())
            throw error
        }
    }
    
    func saveThumbnailFrom(videoURL: URL, toURL thumbURL: URL) throws {
        do {
            let thumbnail = try getThumbnailFrom(videoURL: videoURL)
            let data = UIImageJPEGRepresentation(thumbnail, 1)
            try data?.write(to: thumbURL)
        } catch let error {
            throw error
        }
    }
    
    func getThumbnailFrom(videoURL: URL) throws -> UIImage {
        do {
            let asset = AVURLAsset(url: videoURL , options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            return thumbnail
        } catch let error {
            throw error
        }
    }
    
}

//MARK: Import Media Samples
extension MDMediaImporter {
    
    func loadMediaSamples() {
        guard let dataURL = Bundle.main.url(forResource: "video_files", withExtension: "plist"),
        UserDefaults.standard.hasImportedSamples() != true else { return }
        do {
            let data = try Data(contentsOf: dataURL)
            let plist = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as! [String]
            for code in plist {
                try importSample(code: code)
            }
            UserDefaults.standard.didImportSamples(true)
        } catch let error {
            print(error.localizedDescription)
            UserDefaults.standard.didImportSamples(false)
        }
    }
    
    func importSample(code: String) throws {
        guard let infoURL = Bundle.main.url(forResource: "video_info", withExtension: "plist", subdirectory: code) else { return }
        do {
            let data = try Data(contentsOf: infoURL)
            let plist = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as! [String: String]
            if let audioName = plist["audio"],
                let videoName = plist["video"],
                let videoURL = Bundle.main.url(forResource: videoName, withExtension: "mp4", subdirectory: "\(code)/video"),
                let audioURL = Bundle.main.url(forResource: audioName, withExtension: "m4a", subdirectory: "\(code)/ambient")
            {
                let video = MDMedia()
                video.generatePaths(from: videoURL, audioURL: audioURL)
                //move items
                do {
                    try FileManager.default.copyItem(at: videoURL, to: video.getVideoURL())
                    try FileManager.default.copyItem(at: audioURL, to: video.getAudioURL()!)
                    try saveThumbnailFrom(videoURL: video.getVideoURL(), toURL: video.getThumbURL())
                    try MDDBManager.defaultManager.write {
                        MDDBManager.defaultManager.add(video)
                    }
                } catch let error {
                    throw error
                }
            }
        } catch let error {
            throw error
        }
    }
}

