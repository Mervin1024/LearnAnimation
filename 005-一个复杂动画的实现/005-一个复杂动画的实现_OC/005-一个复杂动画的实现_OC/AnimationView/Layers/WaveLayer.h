//
//  WaveLayer.h
//  005-一个复杂动画的实现_OC
//
//  Created by 马遥 on 2018/1/23.
//  Copyright © 2018年 马遥. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@protocol WaveLayerDelegate <NSObject>

- (void)waveLayerAnimationDidCompleted:(BOOL)finished;

@end

@interface WaveLayer : CAShapeLayer

@property (nonatomic, weak) id <WaveLayerDelegate> animationDelegate;

- (void)startAnimation;

@end
