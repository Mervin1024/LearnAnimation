//
//  ViewController.swift
//  004-一个复杂动画的实现
//
//  Created by 马遥 on 2018/1/23.
//  Copyright © 2018年 马遥. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let animationView: AnimationView = AnimationView.init(frame: UIScreen.main.bounds)
    let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(animationView)
        animationView.animationCompleted = { [weak self] finished in
            print("动画已结束 ===  \(finished)")
            self?.animationFinished()
        }
        
        titleLabel.font = UIFont.init(name: "HelveticaNeue-Thin", size: 50)
        titleLabel.text = "Welcome"
        titleLabel.textColor = UIColor.white
        titleLabel.sizeToFit()
        titleLabel.center = CGPoint.init(x: self.view.center.x, y: self.view.center.y - 50)
        self.view.addSubview(titleLabel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        beginAnimation(tap: nil)
    }


    @objc func beginAnimation(tap:UITapGestureRecognizer?) {
        if self.view.gestureRecognizers != nil {
            for obj: UIGestureRecognizer in self.view.gestureRecognizers! {
                self.view.removeGestureRecognizer(obj)
            }
        }
        titleLabel.transform = CGAffineTransform.init(scaleX: 0.25, y: 0.25)
        titleLabel.isHidden = true
        animationView.startAnimation()
    }
    
    func animationFinished() {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.titleLabel.isHidden = false
            self.titleLabel.transform = CGAffineTransform.identity
        }) { _ in
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.beginAnimation(tap:)))
            self.view.addGestureRecognizer(tap)
        }
        
    }
}

