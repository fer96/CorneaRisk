//
//  EyeView.swift
//  CorneaRisk
//
//  Created by Fernando De La Rosa on 1/20/19.
//  Copyright © 2019 Fernando De La Rosa. All rights reserved.
//

import UIKit

//@IBDesignable
class EyeView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    */
    override func draw(_ rect: CGRect) {
        // Drawing code
        //MARK: Colors
        //let translucentColor = UIColor(red: CGFloat(0.819), green: CGFloat(0.917), blue: CGFloat(0.839), alpha: CGFloat(0.25))
        let secondColor = UIColor(red: CGFloat(0.231), green: CGFloat(0.373), blue: CGFloat(0.255), alpha: CGFloat(1))
        let thirdColor = UIColor(red: CGFloat(0.388), green: CGFloat(0.604), blue: CGFloat(0.404), alpha: CGFloat(1))
        let blackColor = UIColor(red: CGFloat(0.203), green: CGFloat(0.203), blue: CGFloat(0.203), alpha: CGFloat(1))
        let grayColor = UIColor(red: CGFloat(0.203), green: CGFloat(0.203), blue: CGFloat(0.203), alpha: CGFloat(0.75))
        //let redColor = UIColor(red: CGFloat(0.6), green: CGFloat(0.192), blue: CGFloat(0.161), alpha: CGFloat(1))
        
        //MARK: Auxiliars points
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius: CGFloat = min(bounds.width, bounds.height) / 2
        let startAngle: CGFloat = .pi
        let endAngle: CGFloat = 0
        let shineCenter = CGPoint(x: center.x + (radius * 0.2), y: center.y - (radius * 0.3))
        
        let outCircle = UIGraphicsGetCurrentContext()
        outCircle?.addArc(center: center, radius: radius - (radius * 0.05) , startAngle: startAngle, endAngle: endAngle, clockwise: true)
        outCircle?.addArc(center: center, radius: radius - (radius * 0.05), startAngle: endAngle  , endAngle: startAngle, clockwise: true)
        outCircle?.setStrokeColor(UIColor.black.cgColor)
        outCircle?.setLineWidth(CGFloat(4))
        outCircle?.strokePath()
        
        let inCircleDown = UIGraphicsGetCurrentContext()
        inCircleDown?.addArc(center: center, radius: radius - (radius * 0.085), startAngle: startAngle, endAngle: endAngle, clockwise: true)
        inCircleDown?.setStrokeColor(secondColor.cgColor)
        inCircleDown?.setLineWidth(CGFloat(4))
        inCircleDown?.strokePath()
        let inCircleUP = UIGraphicsGetCurrentContext()
        inCircleUP?.addArc(center: center, radius: radius - (radius * 0.085), startAngle: endAngle  , endAngle: startAngle, clockwise: true)
        inCircleUP?.setStrokeColor(thirdColor.cgColor)
        inCircleUP?.setLineWidth(CGFloat(4))
        inCircleUP?.strokePath()
        
        let irisDown = UIGraphicsGetCurrentContext()
        irisDown?.addArc(center: center, radius: radius - (radius * 0.1), startAngle: startAngle, endAngle: endAngle, clockwise: true)
        irisDown?.setFillColor(thirdColor.cgColor)
        irisDown?.fillPath()
        irisDown?.strokePath()
        let irisUP = UIGraphicsGetCurrentContext()
        irisUP?.addArc(center: center, radius: radius - (radius * 0.1), startAngle: endAngle  , endAngle: startAngle, clockwise: true)
        irisUP?.setFillColor(secondColor.cgColor)
        irisUP?.fillPath()
        irisUP?.strokePath()
        
        let pupilDown = UIGraphicsGetCurrentContext()
        pupilDown?.addArc(center: center, radius: radius - (radius * 0.6), startAngle: startAngle, endAngle: endAngle, clockwise: true)
        pupilDown?.setFillColor(grayColor.cgColor)
        pupilDown?.fillPath()
        pupilDown?.strokePath()
        let pupilUP = UIGraphicsGetCurrentContext()
        pupilUP?.addArc(center: center, radius: radius - (radius * 0.6), startAngle: endAngle  , endAngle: startAngle, clockwise: true)
        pupilUP?.setFillColor(blackColor.cgColor)
        pupilUP?.fillPath()
        pupilUP?.strokePath()
        
        let shine = UIGraphicsGetCurrentContext()
        shine?.addArc(center: shineCenter, radius: radius * 0.125, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        shine?.addArc(center: shineCenter, radius: radius * 0.125, startAngle: endAngle, endAngle: startAngle, clockwise: true)
        shine?.setFillColor(UIColor.white.cgColor)
        shine?.fillPath()
        shine?.strokePath()
        
//        let line = UIGraphicsGetCurrentContext()
//        line?.move(to: CGPoint(x: center.x, y: center.y + radius))
//        line?.addRect(rect)
//        line?.setFillColor(translucentColor.cgColor)
//        line?.fillPath()
//        line?.strokePath()
    }
}
