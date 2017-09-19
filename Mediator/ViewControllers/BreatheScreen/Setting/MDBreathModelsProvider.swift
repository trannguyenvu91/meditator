//
//  MDBreathModelsProvider.swift
//  Mediator
//
//  Created by VuVince on 9/18/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

class MDBreathModelsProvider: NSObject, MDListProviderProtocol {
    
    var reloadNotification: (() -> Void)?
    var updatesNotification: (([IndexPath], [IndexPath], [IndexPath]) -> Void)?
    var data:[MDBreatheModel] {
        let inhale1 = BreathFragment(range: 0.0..<0.4, state: .inhale)
        let hold1 = BreathFragment(range: 0.4..<0.6, state: .hold)
        let exhale1 = BreathFragment(range: 0.6..<1.0, state: .exhale)
        let breatheModel1 = MDBreatheModel(fragments: [inhale1, hold1, exhale1], duration: 12)
        
        let inhale2 = BreathFragment(range: 0.0..<0.5, state: .inhale)
        let exhale2 = BreathFragment(range: 0.5..<1.0, state: .exhale)
        let breatheModel2 = MDBreatheModel(fragments: [inhale2, exhale2], duration: 12)
        
        let inhale3 = BreathFragment(range: 0.0..<0.35, state: .inhale)
        let hold3 = BreathFragment(range: 0.35..<0.5, state: .hold)
        let exhale3 = BreathFragment(range: 0.5..<0.85, state: .exhale)
        let hold31 = BreathFragment(range: 0.85..<1.0, state: .hold)
        let breatheModel3 = MDBreatheModel(fragments: [inhale3, hold3, exhale3, hold31], duration: 12)
        
        let inhale4 = BreathFragment(range: 0.0..<0.25, state: .inhale)
        let hold4 = BreathFragment(range: 0.25..<0.5, state: .hold)
        let exhale4 = BreathFragment(range: 0.5..<0.75, state: .exhale)
        let hold41 = BreathFragment(range: 0.75..<1.0, state: .hold)
        let breatheModel4 = MDBreatheModel(fragments: [inhale4, hold4, exhale4, hold41], duration: 12)
        
        return [breatheModel1, breatheModel2, breatheModel3, breatheModel4]
    }
    
    func model(at indexPath: IndexPath) -> MDModelProtocol? {
        return data[indexPath.row]
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems(in section: Int) -> Int {
        return data.count
    }
    
}
