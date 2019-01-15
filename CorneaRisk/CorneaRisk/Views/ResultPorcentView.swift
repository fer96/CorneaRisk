//
//  ResultPorcentView.swift
//  CorneaRisk
//
//  Created by Fernando De La Rosa on 1/14/19.
//  Copyright © 2019 Fernando De La Rosa. All rights reserved.
//

import UIKit

class ResultPorcentView: UIView {
    
    static var resultPorcent: Double = 75.0
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    */
    override func draw(_ rect: CGRect) {
        let contextGreen = UIGraphicsGetCurrentContext()
        contextGreen?.setLineWidth(frame.width)
        contextGreen?.setStrokeColor(UIColor.green.cgColor)
        contextGreen?.move(to: CGPoint(x: 0, y: 0))
        contextGreen?.addLine(to: CGPoint(x: frame.width * (CGFloat(ResultPorcentView.resultPorcent) * CGFloat(0.01)), y: CGFloat(0)))
        contextGreen?.strokePath()
        
        let contextRed = UIGraphicsGetCurrentContext()
        contextRed?.setLineWidth(frame.width)
        contextRed?.setStrokeColor(UIColor.red.cgColor)
        contextRed?.move(to: CGPoint(x: frame.width * (CGFloat(ResultPorcentView.resultPorcent) * CGFloat(0.01)), y: 0))
        contextRed?.addLine(to: CGPoint(x: CGFloat(frame.width), y: CGFloat(0)))
        contextRed?.strokePath()
    }
    

}
