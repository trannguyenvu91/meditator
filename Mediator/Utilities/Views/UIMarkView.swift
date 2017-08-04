//
//  UIMarkView.swift
//  Mediator
//
//  Created by VuVince on 8/4/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

class UIMarkView: UIView {
    private var color: UIColor = UIColor.white
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(arcRadius radius: Double, stand: Double, color: UIColor) {
        let rect = CGRect(x: 0, y: 0, width: radius * 2.0, height: stand + radius)
        super.init(frame: rect)
        self.color = color
        backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        //draw open rectangle
        let bezier = UIBezierPath()
        let standY = rect.height - rect.width / 2.0
        bezier.move(to: CGPoint(x: 0, y: standY))
        bezier.addLine(to: CGPoint.zero)
        bezier.addLine(to: CGPoint(x: rect.width, y: 0))
        bezier.addLine(to: CGPoint(x: rect.width, y: standY))
        //draw arc
        bezier.addArc(withCenter: CGPoint(x: rect.midX, y: standY),
                      radius: rect.width / 2.0,
                      startAngle: 0,
                      endAngle: .pi,
                      clockwise: true)
        bezier.close()
        color.setFill()
        bezier.fill()
    }

}
