//
//  AnimationView.swift
//  004-一个复杂动画的实现
//
//  Created by 马遥 on 2018/1/23.
//  Copyright © 2018年 马遥. All rights reserved.
//

import UIKit

class AnimationView: UIView {
    
    public var animationCompleted: ((Bool)->())?
    
    // MARK: Animation Layers
    
    private lazy var transformLayer: CALayer = {
        let layer = CALayer()
        layer.frame = self.layer.frame
        return layer
    }()
    
    private let circleLayer = CircleLayer()
    
    private let triangleLayer = TriangleLayer()
    
    private let redRectangleLayer = RectangleLayer()
    
    private let greenRectangleLayer = RectangleLayer()
    
    private lazy var waveLayer: WaveLayer = {
        let layer = WaveLayer()
        layer.waveDelegate = self
        return layer
    }()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("Animation view deinit!!!")
    }
    
    private func clean() {
        circleLayer.removeFromSuperlayer()
        triangleLayer.removeFromSuperlayer()
        redRectangleLayer.removeFromSuperlayer()
        greenRectangleLayer.removeFromSuperlayer()
        waveLayer.removeFromSuperlayer()
        transformLayer.removeFromSuperlayer()
    }
    
    // MARK: 按照顺序执行动画
    
    public func startAnimation() {
        self.layer.addSublayer(transformLayer)
        self.backgroundColor = UIColor.white
        self.firstAnimation()
    }
    
    private func firstAnimation() {
        transformLayer.addSublayer(circleLayer)
        circleLayer.expandAnimation()   // 椭圆动画
        
        _ = delay(1.2) {
            self.secondAnimation()
        }
    }
    
    private func secondAnimation() {
        transformLayer.addSublayer(triangleLayer)
        triangleLayer.startAppear()     // 三角形动画
        
        _ = delay(0.9) {
            self.thirdAinmation()
        }
    }
    
    private func thirdAinmation() {
        transformLayer.add(transformAnimation, forKey: nil) // 旋转动画
        circleLayer.reduceAnimation()                       // 圆形缩小
        
        _ = delay(0.4) {
            self.fourthAnimation()
        }
    }
    
    private func fourthAnimation() {
        transformLayer.addSublayer(redRectangleLayer)
        redRectangleLayer.startStrokeWithColor(NewPurple)
        
        _ = delay(0.2) {
            self.fifthAnimation()
        }
    }
    
    private func fifthAnimation() {
        transformLayer.addSublayer(greenRectangleLayer)
        greenRectangleLayer.startStrokeWithColor(NewGreen)
        
        _ = delay(0.4) {
            self.sixthAnimation()
        }
    }
    
    private func sixthAnimation() {
        transformLayer.addSublayer(waveLayer)
        waveLayer.startAnimation()
    }
    
}

extension AnimationView {
    private var transformAnimation: CABasicAnimation {
        let animation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        animation.toValue = Double.pi * 2
        animation.duration = 0.45
        return animation
    }
}

extension AnimationView : WaveLayerDelegate {
    func waveLayerAnimationDidCompleted(finished: Bool) {
        if finished {
            self.clean()
            self.backgroundColor = NewGreen
        }
        if animationCompleted != nil {
            animationCompleted!(finished)
        }
    }
}
