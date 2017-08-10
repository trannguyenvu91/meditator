//
//  MDBreatheViewModel.swift
//  Mediator
//
//  Created by VuVince on 8/10/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

struct MDBreatheModel {
    var fragments: [BreathFragment]!
    var duration: Double!
}

class MDBreatheViewModel: NSObject {
    let breathPlayer = MDBreathePlayer()
    var breatheModel: MDBreatheModel!
    
    override init() {
        super.init()
        let inhale = BreathFragment(range: 0.0..<0.4, state: .inhale)
        let hold = BreathFragment(range: 0.4..<0.6, state: .hold)
        let exhale = BreathFragment(range: 0.6..<1.0, state: .exhale)
        breatheModel = MDBreatheModel(fragments: [inhale, hold, exhale], duration: 12)
    }
    
    func playAudio(for toState: BreathState) {
        do {
            try breathPlayer.playAudio(for: toState)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func resumePlaying() {
        breathPlayer.play()
    }
    
    func pausePlaying() {
        breathPlayer.pause()
    }
    
}
