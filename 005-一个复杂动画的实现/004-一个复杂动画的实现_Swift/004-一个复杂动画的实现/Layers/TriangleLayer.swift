//
//  TriangleLayer.swift
//  004-一个复杂动画的实现
//
//  Created by 马遥 on 2018/1/24.
//  Copyright © 2018年 马遥. All rights reserved.
//

import UIKit

class TriangleLayer: CAShapeLayer {
    
    private let radius: CGFloat = (90-7)/2.0
    private let interval: CGFloat = (90-7)/2.0*0.134
    private let padding: CGFloat = 15
    
    // MARK: UIBezierPath
    
    private lazy var triangleSmallPath: UIBezierPath = {
        let top = CGPoint.init(x: Screen_Width / 2,
                               y: Screen_Height / 2 - radius)
        let left = CGPoint.init(x: Screen_Width / 2 - radius + interval,
                                y: Screen_Height / 2 + radius / 2)
        let right = CGPoint.init(x: Screen_Width / 2 + radius - interval,
                                 y: Screen_Height / 2 + radius / 2)
        let path = UIBezierPath.init()
        path.move(to: top)
        path.addLine(to: left)
        path.addLine(to: right)
        path.close()
        return path
    }()
    
    private lazy var triangleLeftPath: UIBezierPath = {
        let top = CGPoint.init(x: Screen_Width / 2,
                               y: Screen_Height / 2 - radius)
        let left = CGPoint.init(x: Screen_Width / 2 - radius + interval - padding * 0.866,
                                y: Screen_Height / 2 + radius / 2 + padding / 2)
        let right = CGPoint.init(x: Screen_Width / 2 + radius - interval,
                                 y: Screen_Height / 2 + radius / 2)
        let path = UIBezierPath.init()
        path.move(to: top)
        path.addLine(to: left)
        path.addLine(to: right)
        path.close()
        return path
    }()
    
    private lazy var triangleRightPath: UIBezierPath = {
        let top = CGPoint.init(x: Screen_Width / 2,
                               y: Screen_Height / 2 - radius)
        let left = CGPoint.init(x: Screen_Width / 2 - radius + interval - padding * 0.866,
                                y: Screen_Height / 2 + radius / 2 + padding / 2)
        let right = CGPoint.init(x: Screen_Width / 2 + radius - interval + padding * 0.866,
                                 y: Screen_Height / 2 + radius / 2 + padding / 2)
        let path = UIBezierPath.init()
        path.move(to: top)
        path.addLine(to: left)
        path.addLine(to: right)
        path.close()
        return path
    }()

    private lazy var triangleTopPath: UIBezierPath = {
        let top = CGPoint.init(x: Screen_Width / 2,
                               y: Screen_Height / 2 - radius - padding)
        let left = CGPoint.init(x: Screen_Width / 2 - radius + interval - padding * 0.866,
                                y: Screen_Height / 2 + radius / 2 + padding / 2)
        let right = CGPoint.init(x: Screen_Width / 2 + radius - interval + padding * 0.866,
                                 y: Screen_Height / 2 + radius / 2 + padding / 2)
        let path = UIBezierPath.init()
        path.move(to: top)
        path.addLine(to: left)
        path.addLine(to: right)
        path.close()
        return path
    }()

    // MARK: Init
    
    override init() {
        super.init()
        path = triangleSmallPath.cgPath
        fillColor = NewPurple.cgColor
        strokeColor = fillColor
        lineWidth = 7
        lineCap = kCALineCapRound
        lineJoin = kCALineJoinRound
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: func
    
    public func startAppear() {
        self.triangleAnimation()
    }
    
    private func triangleAnimation() {
        let animation1 = CABasicAnimation.init(keyPath: "path")
        animation1.fromValue = triangleSmallPath.cgPath
        animation1.toValue = triangleLeftPath.cgPath
        animation1.duration = 0.3
        animation1.beginTime = 0.0
        
        let animation2 = CABasicAnimation.init(keyPath: "path")
        animation2.fromValue = triangleLeftPath.cgPath
        animation2.toValue = triangleRightPath.cgPath
        animation2.duration = 0.25
        animation2.beginTime = animation1.beginTime + animation1.duration
        
        let animation3 = CABasicAnimation.init(keyPath: "path")
        animation3.fromValue = triangleRightPath.cgPath
        animation3.toValue = triangleTopPath.cgPath
        animation3.duration = 0.2
        animation3.beginTime = animation2.beginTime + animation2.duration

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animation1, animation2, animation3]
        animationGroup.duration = animation3.beginTime + animation3.duration
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.isRemovedOnCompletion = false
        self.add(animationGroup, forKey: nil)
    }
    
}
