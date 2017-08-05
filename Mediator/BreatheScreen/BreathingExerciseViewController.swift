//
//  BreathingExerciseViewController.swift
//  Mediator
//
//  Created by VuVince on 8/4/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

class BreathingExerciseViewController: MDBaseViewController {
    let inhale = BreathFragment(range: 0.0..<0.4, state: .inhale)
    let hold = BreathFragment(range: 0.4..<0.6, state: .hold)
    let exhale = BreathFragment(range: 0.6..<1.0, state: .exhale)
    var breathView: UIBreathingView!

    @IBOutlet weak var btnPlay: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        breathView.animate(true)
        updateBtnPlaye(play: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews() {
        view.backgroundColor = UIColor.cyan.withAlphaComponent(0.6)
        setupBreathView()
    }
    
    func setupBreathView() {
        breathView = UIBreathingView(frame: CGRect.zero, duration: 12.0, breathFragments: [inhale, hold, exhale], labelRatio: 0.8, labelColor: UIColor.blue)
        breathView.delegate = self
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
    
    @IBAction func btnPlayClicked(_ sender: Any) {
        breathView.animate(!btnPlay.isSelected)
        updateBtnPlaye(play: !btnPlay.isSelected)
    }
    
    func updateBtnPlaye(play: Bool) {
        btnPlay.isSelected = play
        btnPlay.setTitle(play ? "Pause" : "Play", for: .normal)
    }
    
}

extension BreathingExerciseViewController: UIBreathingViewDelegate {
    func didChange(fragment: BreathFragment) {
        print(fragment.getTitle())
    }
    
}
