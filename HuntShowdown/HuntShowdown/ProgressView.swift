//
//  ProgressView.swift
//  HuntShowdown
//
//  Created by Guxiaojie on 2018/7/14.
//  Copyright © 2018 SageGu. All rights reserved.
//

import UIKit

class ProgressView: UIView, CAAnimationDelegate {
    
    let shapeLayer = CAShapeLayer()
    
    var displayLink: CADisplayLink?
    
    var startValue: Double = 20
    let endValue: Double = 0
    var animationDuration: Double = 5
    var animationStartDate = Date()

    var basicAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
    let countingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = UIColor.outlineStrokeColor
        label.tag = 100
        return label
    }()
    
    typealias AnimationEnd = () -> Void
    
    var animationEnd: AnimationEnd?
    ///*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let radius: CGFloat = min(rect.width, rect.height)/2
        let center: CGPoint = CGPoint(x: rect.width/2, y: rect.height/2)
        let trackLayer = CAShapeLayer()
        let trackPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi, clockwise: true)
        self.layer.addSublayer(trackLayer)
        trackLayer.path = trackPath.cgPath
        trackLayer.strokeColor = UIColor.clear.cgColor//UIColor.trackStrokeColor.cgColor
        trackLayer.lineWidth = 10;
        trackLayer.lineCap = kCALineCapRound
        trackLayer.fillColor = UIColor.clear.cgColor
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        self.layer.addSublayer(shapeLayer)
        shapeLayer.strokeColor = UIColor.outlineStrokeColor.cgColor
        shapeLayer.lineWidth = 10;
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 0
        

        if self.viewWithTag(100) ==  nil {
            self.addSubview(countingLabel)
        }
        countingLabel.frame = rect
    }
    //*/

    @objc func handleUpdate() {
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        
        if elapsedTime > animationDuration {
            countingLabel.text = "\(Int(endValue + 1))"
            displayLink?.invalidate()
            displayLink = nil
            
            if let animationEnd = animationEnd {
                animationEnd()
            }
        } else {
            let percentage = elapsedTime / animationDuration
            let value = startValue + percentage * (endValue - startValue)
            countingLabel.text = "\(Int(value + 1))"
        }
    }
    
    func animate(_ duration: Double) {
        startValue = duration
        animationDuration = duration
        
        basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = Double(animationDuration + 2)
       // basicAnimation.fillMode = kCAFillModeForwards
       // basicAnimation.isRemovedOnCompletion = false

        shapeLayer.add(basicAnimation, forKey: "urSoBasic")

        animationStartDate = Date()
        displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink?.add(to: .main, forMode: .defaultRunLoopMode)

        countingLabel.alpha = 1
    }
    
    func stop() {
        displayLink?.invalidate()
        displayLink = nil
        countingLabel.text = ""
        countingLabel.alpha = 0
        
        self.shapeLayer.removeAllAnimations()
    }
    
}
