//
//  MDMediaImporter.swift
//  Mediator
//
//  Created by VuVince on 7/9/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

class MDMediaImporter: NSObject {
    static let sharedInstance = MDMediaImporter()
    weak var fromViewController: UIViewController?
    
    @discardableResult class func presentImagePickerVC(fromVC: UIViewController,
                                    animated flag: Bool,
                                    completion: (() -> Swift.Void)? = nil) -> UIImagePickerController {
        self.sharedInstance.fromViewController = fromVC
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.delegate = self.sharedInstance
        picker.sourceType = .photoLibrary
        fromVC.present(picker, animated: flag, completion: completion)
        return picker
    }
}

extension MDMediaImporter: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        fromViewController?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
    }
}
