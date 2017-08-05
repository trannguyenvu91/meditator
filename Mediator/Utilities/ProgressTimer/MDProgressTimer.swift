//
//  MDProgressTimer.swift
//  
//
//  Created by VuVince on 8/5/17.
//

import UIKit

protocol MDProgressTimerDelegate: NSObjectProtocol {
    func didUpdate(timer: MDProgressTimer, progress: Double)
}

class MDProgressTimer: NSObject {
    var duration: Double!
    weak var delegate: MDProgressTimerDelegate?
    var totalTime: Double = 0
    private var timer: Timer?
    let timeInterval = 0.05
    var isRunning = false
    
    var progress: Double {
        return totalTime.truncatingRemainder(dividingBy: duration) / duration
    }
    
    init(duration: Double, delegate: MDProgressTimerDelegate?) {
        super.init()
        self.duration = duration
        self.delegate = delegate
    }
    
    func pause() {
        timer?.invalidate()
        isRunning = false
    }
    
    func fire(restart: Bool) {
        if restart {
            totalTime = 0
        }
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        isRunning = true
    }
    
    @objc private func updateCounter() {
        totalTime = totalTime + timeInterval
        delegate?.didUpdate(timer: self, progress: progress)
    }
    
    deinit {
        timer?.invalidate()
    }
}
