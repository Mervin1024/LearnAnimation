//
//  RectangleLayer.swift
//  004-一个复杂动画的实现
//
//  Created by 马遥 on 2018/1/24.
//  Copyright © 2018年 马遥. All rights reserved.
//

import UIKit

class RectangleLayer: CAShapeLayer {

    private lazy var rectangleFullPath: UIBezierPath = {
        let width: CGFloat = (0.866 * 60 + 2.5) * 2
        let lowerLeftPoint = CGPoint.init(x: Screen_Width / 2 - width / 2,
                                          y: Screen_Height / 2 + 45 / 2.0 + 10)
        let topLeftPoint = CGPoint.init(x: lowerLeftPoint.x,
                                        y: lowerLeftPoint.y - width)
        let topRightPoint = CGPoint.init(x: lowerLeftPoint.x + width,
                                         y: topLeftPoint.y)
        let lowerRightPoint = CGPoint.init(x: topRightPoint.x,
                                           y: lowerLeftPoint.y)
        
        let layer = UIBezierPath()
        layer.move(to: lowerLeftPoint)
        layer.addLine(to: topLeftPoint)
        layer.addLine(to: topRightPoint)
        layer.addLine(to: lowerRightPoint)
        layer.close()
        return layer
    }()
    
    override init() {
        super.init()
        fillColor = UIColor.clear.cgColor
        path = rectangleFullPath.cgPath
        lineWidth = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func startStrokeWithColor(_ color: UIColor) {
        strokeColor = color.cgColor
        let animation = CABasicAnimation.init(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.4
        self.add(animation, forKey: nil)
    }
    
}
