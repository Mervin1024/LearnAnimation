//
//  CircleLayer.swift
//  004-一个复杂动画的实现
//
//  Created by 马遥 on 2018/1/23.
//  Copyright © 2018年 马遥. All rights reserved.
//

import UIKit

class CircleLayer: CAShapeLayer {

    private let kAnimationDuration: CFTimeInterval = 0.3
    private let kAnimationBeginTime: CFTimeInterval = 0.0
    private let ExpandAnimationName = "expandAnimation"
    private let WobbleAnimationName = "wobbleAnimation"
    private let ReduceAnimationName = "reduceAnimation"

    
    private var circleSmallPath: UIBezierPath {
        let width : CGFloat = 0.0
        return UIBezierPath.init(ovalIn: CGRect.init(x: Screen_Width/2-width/2, y: Screen_Height/2 - width/2, width: width, height: width))
    }
    
    private var circleBigPath: UIBezierPath {
        let width : CGFloat = 95.0
        return UIBezierPath.init(ovalIn: CGRect.init(x: Screen_Width/2-width/2, y: Screen_Height/2 - width/2, width: width, height: width))
    }
    
    private var verticalEllipsePath: UIBezierPath {
        return UIBezierPath.init(ovalIn: CGRect.init(x: Screen_Width/2-100/2, y: Screen_Height/2-90/2, width: 100, height: 90))
    }
    
    private var horizontalEllipsePath: UIBezierPath {
        return UIBezierPath.init(ovalIn: CGRect.init(x: Screen_Width/2-90/2, y: Screen_Height/2-100/2, width: 90, height: 100))
    }
    
    
    override init() {
        super.init()
        fillColor = NewPurple.cgColor
        path = circleSmallPath.cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func expandAnimation() {
        let expandAnimation: CABasicAnimation = CABasicAnimation.init(keyPath: "path")
        expandAnimation.fromValue = circleSmallPath.cgPath
        expandAnimation.toValue = circleBigPath.cgPath
        expandAnimation.duration = kAnimationDuration
        expandAnimation.fillMode = kCAFillModeForwards
        expandAnimation.isRemovedOnCompletion = false
        expandAnimation.delegate = self
        expandAnimation.setValue(ExpandAnimationName, forKey: KAnimationName)
        self.add(expandAnimation, forKey: nil)
    }
    
    private func wobbleAnimation() {
        let wobbleAnimation1 = CABasicAnimation.init(keyPath: "path")
        wobbleAnimation1.fromValue = circleBigPath.cgPath
        wobbleAnimation1.toValue = horizontalEllipsePath.cgPath
        wobbleAnimation1.duration = kAnimationDuration
        wobbleAnimation1.beginTime = kAnimationBeginTime
        
        let wobbleAnimation2 = CABasicAnimation.init(keyPath: "path")
        wobbleAnimation2.fromValue = horizontalEllipsePath.cgPath
        wobbleAnimation2.toValue = verticalEllipsePath.cgPath
        wobbleAnimation2.duration = kAnimationDuration
        wobbleAnimation2.beginTime = wobbleAnimation1.beginTime + wobbleAnimation1.duration
        
        let wobbleAnimation3 = CABasicAnimation.init(keyPath: "path")
        wobbleAnimation3.fromValue = verticalEllipsePath.cgPath
        wobbleAnimation3.toValue = horizontalEllipsePath.cgPath
        wobbleAnimation3.duration = kAnimationDuration
        wobbleAnimation3.beginTime = wobbleAnimation2.beginTime + wobbleAnimation2.duration
        
        let wobbleAnimation4 = CABasicAnimation.init(keyPath: "path")
        wobbleAnimation4.fromValue = horizontalEllipsePath.cgPath
        wobbleAnimation4.toValue = circleBigPath.cgPath
        wobbleAnimation4.duration = kAnimationDuration
        wobbleAnimation4.beginTime = wobbleAnimation3.beginTime + wobbleAnimation3.duration
     
        let wobbleAnimationGroup = CAAnimationGroup.init()
        wobbleAnimationGroup.animations = [wobbleAnimation1, wobbleAnimation2, wobbleAnimation3, wobbleAnimation4]
        wobbleAnimationGroup.duration = wobbleAnimation4.beginTime + wobbleAnimation4.duration
        wobbleAnimationGroup.repeatCount = 2
        self.add(wobbleAnimationGroup, forKey: nil)
    }
    
    public func reduceAnimation() {
        let reduceAnimation = CABasicAnimation.init(keyPath: "path")
        reduceAnimation.toValue = circleSmallPath.cgPath
        reduceAnimation.duration = kAnimationDuration
        reduceAnimation.fillMode = kCAFillModeForwards
        reduceAnimation.isRemovedOnCompletion = false
        self.add(reduceAnimation, forKey: nil)
    }
}

extension CircleLayer : CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            let animationName = anim.value(forKey: KAnimationName) as! String
            if animationName == ExpandAnimationName {
                self.wobbleAnimation()
            }
        }
    }
}







