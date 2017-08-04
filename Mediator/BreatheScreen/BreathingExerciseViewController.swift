//
//  BreathingExerciseViewController.swift
//  Mediator
//
//  Created by VuVince on 8/4/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

class BreathingExerciseViewController: UIViewController {
    
    let breathView = UIBreathingView(frame: CGRect.zero,
                                     duration: 15,
                                     inhaleFragments: [0.0..<0.4],
                                     exhaleFragments: [0.6..<1.0],
                                     holdingFraments: [0.4..<0.6],
                                     labelRatio: 0.75,
                                     inhaleColor: UIColor.green,
                                     exhaleColor: UIColor.brown,
                                     holdingColor: UIColor.gray,
                                     labelColor: UIColor.blue)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBreathView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupBreathView() {
        view.addSubview(breathView)
        breathView.snp.makeConstraints { (make) in
            make.center.equalTo(view.snp.center)
            make.width.equalTo(breathView.snp.height)
            make.width.equalTo(view.snp.width).multipliedBy(0.6)
        }
    }

    @IBAction func btnDoneClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
