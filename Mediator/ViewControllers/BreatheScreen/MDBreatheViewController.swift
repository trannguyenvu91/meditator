//
//  MDBreatheViewController.swift
//  Mediator
//
//  Created by VuVince on 8/4/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

class MDBreatheViewController: MDBaseViewController {
    let viewModel = MDBreatheViewModel()
    var breathView: UIBreathingView!
    
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !viewModel.isPlaying {
            updateExercise(play: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews() {
        setupBreathView()
        setBlurBackground()
    }
    
    func setupBreathView() {
        breathView = UIBreathingView(frame: CGRect.zero,
                                     duration: viewModel.breatheModel.duration,
                                     breathFragments: viewModel.breatheModel.fragments,
                                     labelRatio: 0.8, labelColor: UIColor.blue)
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
        updateExercise(play: !btnPlay.isSelected)
    }
    
    func updateExercise(play: Bool) {
        btnPlay.setTitle(play ? "Pause" : "Play", for: .normal)
        btnPlay.isSelected = play
        breathView.animate(play)
        if play {
            viewModel.resumePlaying()
        } else {
            viewModel.pausePlaying()
        }
    }
    
}

extension MDBreatheViewController: UIBreathingViewDelegate {
    func didChange(fragment: BreathFragment) {
        print(fragment.state.getTitle())
        viewModel.playAudio(for: fragment.state)
    }
    
    func didUpdate(totalTime: Double) {
        viewModel.totalDuration = totalTime
        timeLabel.text = viewModel.getTotalDurationString()
    }
    
}
