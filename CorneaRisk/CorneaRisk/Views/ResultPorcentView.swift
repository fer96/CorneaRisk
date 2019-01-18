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
    let imssThirdColor = UIColor(red: CGFloat(0.388), green: CGFloat(0.604), blue: CGFloat(0.404), alpha: CGFloat(1))
    let redColor = UIColor(red: CGFloat(0.6), green: CGFloat(0.192), blue: CGFloat(0.161), alpha: CGFloat(1))
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    */
    override func draw(_ rect: CGRect) {
        let contextGreen = UIGraphicsGetCurrentContext()
        contextGreen?.setLineWidth(frame.width)
        contextGreen?.setStrokeColor(imssThirdColor.cgColor)
        contextGreen?.move(to: CGPoint(x: 0, y: 0))
        contextGreen?.addLine(to: CGPoint(x: frame.width * (CGFloat(ResultPorcentView.resultPorcent) * CGFloat(0.01)), y: CGFloat(0)))
        contextGreen?.strokePath()
        
        let contextRed = UIGraphicsGetCurrentContext()
        contextRed?.setLineWidth(frame.width)
        contextRed?.setStrokeColor(redColor.cgColor)
        contextRed?.move(to: CGPoint(x: frame.width * (CGFloat(ResultPorcentView.resultPorcent) * CGFloat(0.01)), y: 0))
        contextRed?.addLine(to: CGPoint(x: CGFloat(frame.width), y: CGFloat(0)))
        contextRed?.strokePath()
    }
    

}