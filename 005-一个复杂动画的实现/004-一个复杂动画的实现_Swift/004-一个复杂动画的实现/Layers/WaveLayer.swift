//
//  waveLayer.swift
//  004-一个复杂动画的实现
//
//  Created by 马遥 on 2018/1/24.
//  Copyright © 2018年 马遥. All rights reserved.
//

import UIKit

protocol WaveLayerDelegate {
    func waveLayerAnimationDidCompleted(finished: Bool)
}

class WaveLayer: CAShapeLayer {

    public var waveDelegate: WaveLayerDelegate?
    
    private let width: CGFloat = (0.866 * 60 + 2.5) * 2
    private let lowerLeftPoint = CGPoint.init(x: Screen_Width / 2 - (0.866 * 60 + 2.5),
                                              y: Screen_Height / 2 + 45 / 2.0 + 10)
    private let kAnimationDuration: CFTimeInterval = 0.18
    
    private lazy var wavePathPre: UIBezierPath = {
        let layer = UIBezierPath()
        layer.move(to: lowerLeftPoint)
        layer.addLine(to: CGPoint.init(x: lowerLeftPoint.x,
                                       y: lowerLeftPoint.y - 1))
        layer.addLine(to: CGPoint.init(x: lowerLeftPoint.x + width,
                                       y: lowerLeftPoint.y - 1))
        layer.addLine(to: CGPoint.init(x: lowerLeftPoint.x + width,
                                       y: lowerLeftPoint.y))
        layer.close()
        return layer
    }()
    
    private lazy var wavePathStart: UIBezierPath = {
        let layer = UIBezierPath()
        layer.move(to: lowerLeftPoint)
        layer.addLine(to: CGPoint.init(x: lowerLeftPoint.x,
                                       y: lowerLeftPoint.y - width * 0.2))
        layer.addCurve(to: CGPoint.init(x: lowerLeftPoint.x + width,
                                        y: lowerLeftPoint.y - width * 0.2),
                       controlPoint1: CGPoint.init(x: lowerLeftPoint.x + width * 0.3,
                                                   y: lowerLeftPoint.y - width * 0.3),
                       controlPoint2: CGPoint.init(x: lowerLeftPoint.x + width * 0.7,
                                                   y: lowerLeftPoint.y - width * 0.1))
        layer.addLine(to: CGPoint.init(x: lowerLeftPoint.x + width,
                                       y: lowerLeftPoint.y))
        layer.close()
        return layer
    }()

    private lazy var wavePathLow: UIBezierPath = {
        let layer = UIBezierPath()
        layer.move(to: lowerLeftPoint)
        layer.addLine(to: CGPoint.init(x: lowerLeftPoint.x,
                                       y: lowerLeftPoint.y - width * 0.4))
        layer.addCurve(to: CGPoint.init(x: lowerLeftPoint.x + width,
                                        y: lowerLeftPoint.y - width * 0.4),
                       controlPoint1: CGPoint.init(x: lowerLeftPoint.x + width * 0.3,
                                                   y: lowerLeftPoint.y - width * 0.35),
                       controlPoint2: CGPoint.init(x: lowerLeftPoint.x + width * 0.7,
                                                   y: lowerLeftPoint.y - width * 0.5))
        layer.addLine(to: CGPoint.init(x: lowerLeftPoint.x + width,
                                       y: lowerLeftPoint.y))
        layer.close()
        return layer
    }()

    private lazy var wavePathMid: UIBezierPath = {
        let layer = UIBezierPath()
        layer.move(to: lowerLeftPoint)
        layer.addLine(to: CGPoint.init(x: lowerLeftPoint.x,
                                       y: lowerLeftPoint.y - width * 0.6))
        layer.addCurve(to: CGPoint.init(x: lowerLeftPoint.x + width,
                                        y: lowerLeftPoint.y - width * 0.6),
                       controlPoint1: CGPoint.init(x: lowerLeftPoint.x + width * 0.3,
                                                   y: lowerLeftPoint.y - width * 0.78),
                       controlPoint2: CGPoint.init(x: lowerLeftPoint.x + width * 0.7,
                                                   y: lowerLeftPoint.y - width * 0.6))
        layer.addLine(to: CGPoint.init(x: lowerLeftPoint.x + width,
                                       y: lowerLeftPoint.y))
        layer.close()
        return layer
    }()

    private lazy var wavePathHigh: UIBezierPath = {
        let layer = UIBezierPath()
        layer.move(to: lowerLeftPoint)
        layer.addLine(to: CGPoint.init(x: lowerLeftPoint.x,
                                       y: lowerLeftPoint.y - width * 0.8))
        layer.addCurve(to: CGPoint.init(x: lowerLeftPoint.x + width,
                                        y: lowerLeftPoint.y - width * 0.8),
                       controlPoint1: CGPoint.init(x: lowerLeftPoint.x + width * 0.3,
                                                   y: lowerLeftPoint.y - width * 0.8),
                       controlPoint2: CGPoint.init(x: lowerLeftPoint.x + width * 0.7,
                                                   y: lowerLeftPoint.y - width * 0.95))
        layer.addLine(to: CGPoint.init(x: lowerLeftPoint.x + width,
                                       y: lowerLeftPoint.y))
        layer.close()
        return layer
    }()

    private lazy var wavePathEnd: UIBezierPath = {
        let layer = UIBezierPath()
        layer.move(to: lowerLeftPoint)
        layer.addLine(to: CGPoint.init(x: lowerLeftPoint.x,
                                       y: lowerLeftPoint.y - width))
        layer.addLine(to: CGPoint.init(x: lowerLeftPoint.x + width,
                                       y: lowerLeftPoint.y - width))
        layer.addLine(to: CGPoint.init(x: lowerLeftPoint.x + width,
                                       y: lowerLeftPoint.y))
        layer.addLine(to: CGPoint.init(x: lowerLeftPoint.x + width,
                                       y: lowerLeftPoint.y))
        layer.close()
        return layer
    }()
    
    private lazy var wavePathFill: UIBezierPath = {
        let layer = UIBezierPath()
        layer.move(to: CGPoint.init(x: 0,
                                    y: Screen_Height))
        layer.addLine(to: CGPoint.init(x: 0,
                                       y: 0))
        layer.addLine(to: CGPoint.init(x: Screen_Width,
                                       y: 0))
        layer.addLine(to: CGPoint.init(x: Screen_Width,
                                       y: Screen_Height))
        layer.close()
        return layer
    }()

    override init() {
        super.init()
        fillColor = NewGreen.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func startAnimation() {
        self.add(self.waveAnimation(), forKey: nil)
    }
    
    private func waveAnimation() -> CAAnimationGroup {
        let animation1 = CABasicAnimation.init(keyPath: "path")
        animation1.fromValue = wavePathPre.cgPath
        animation1.toValue = wavePathStart.cgPath
        animation1.duration = kAnimationDuration
        animation1.beginTime = 0
        
        let animation2 = CABasicAnimation.init(keyPath: "path")
        animation2.fromValue = wavePathStart.cgPath
        animation2.toValue = wavePathLow.cgPath
        animation2.duration = kAnimationDuration
        animation2.beginTime = animation1.beginTime + animation1.duration
        
        let animation3 = CABasicAnimation.init(keyPath: "path")
        animation3.fromValue = wavePathLow.cgPath
        animation3.toValue = wavePathMid.cgPath
        animation3.duration = kAnimationDuration
        animation3.beginTime = animation2.beginTime + animation2.duration
        
        let animation4 = CABasicAnimation.init(keyPath: "path")
        animation4.fromValue = wavePathMid.cgPath
        animation4.toValue = wavePathHigh.cgPath
        animation4.duration = kAnimationDuration
        animation4.beginTime = animation3.beginTime + animation3.duration
        
        let animation5 = CABasicAnimation.init(keyPath: "path")
        animation5.fromValue = wavePathHigh.cgPath
        animation5.toValue = wavePathEnd.cgPath
        animation5.duration = kAnimationDuration
        animation5.beginTime = animation4.beginTime + animation4.duration
        
        let animationFill = CABasicAnimation.init(keyPath: "path")
        animationFill.fromValue = wavePathEnd.cgPath
        animationFill.toValue = wavePathFill.cgPath
        animationFill.duration = 0.3
        animationFill.beginTime = animation5.beginTime + animation5.duration
        animationFill.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animation1, animation2, animation3, animation4, animation5, animationFill]
        animationGroup.duration = animationFill.beginTime + animationFill.duration
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.isRemovedOnCompletion = false
        animationGroup.delegate = self
        return animationGroup
    }
    
}

extension WaveLayer : CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if waveDelegate != nil {
            waveDelegate!.waveLayerAnimationDidCompleted(finished: flag)
        }
    }
}









