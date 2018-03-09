//
//  WaveLayer.m
//  005-一个复杂动画的实现_OC
//
//  Created by 马遥 on 2018/1/23.
//  Copyright © 2018年 马遥. All rights reserved.
//

#import "WaveLayer.h"

@interface WaveLayer () <CAAnimationDelegate>
@property (nonatomic, strong) UIBezierPath *wavePathPre;
@property (nonatomic, strong) UIBezierPath *wavePathStart;
@property (nonatomic, strong) UIBezierPath *wavePathLow;
@property (nonatomic, strong) UIBezierPath *wavePathMid;
@property (nonatomic, strong) UIBezierPath *wavePathHigh;
@property (nonatomic, strong) UIBezierPath *wavePathEnd;
@property (nonatomic, strong) UIBezierPath *wavePathFill;
@end

@implementation WaveLayer

- (instancetype)init {
    self = [super init];
    if (self) {
        self.path = self.wavePathPre.CGPath;
        self.fillColor = [UIColor colorWithRed:64/255.0 green:224/255.0 blue:176/255.0 alpha:1].CGColor;
    }
    return self;
}

- (void)startAnimation {
    [self addAnimation:[self waveAnimation] forKey:nil];
}

#pragma mark - Animation

- (CAAnimationGroup *)waveAnimation {
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation1.fromValue = (__bridge id _Nullable)(self.wavePathPre.CGPath);
    animation1.toValue = (__bridge id _Nullable)(self.wavePathStart.CGPath);
    animation1.duration = 0.18;
    animation1.beginTime = 0;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation2.fromValue = (__bridge id _Nullable)(self.wavePathStart.CGPath);
    animation2.toValue = (__bridge id _Nullable)(self.wavePathLow.CGPath);
    animation2.duration = 0.18;
    animation2.beginTime = animation1.beginTime + animation1.duration;
    
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation3.fromValue = (__bridge id _Nullable)(self.wavePathLow.CGPath);
    animation3.toValue = (__bridge id _Nullable)(self.wavePathMid.CGPath);
    animation3.duration = 0.18;
    animation3.beginTime = animation2.beginTime + animation2.duration;
    
    CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation4.fromValue = (__bridge id _Nullable)(self.wavePathMid.CGPath);
    animation4.toValue = (__bridge id _Nullable)(self.wavePathHigh.CGPath);
    animation4.duration = 0.18;
    animation4.beginTime = animation3.beginTime + animation3.duration;
    
    CABasicAnimation *animation5 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation5.fromValue = (__bridge id _Nullable)(self.wavePathHigh.CGPath);
    animation5.toValue = (__bridge id _Nullable)(self.wavePathEnd.CGPath);
    animation5.duration = 0.18;
    animation5.beginTime = animation4.beginTime + animation4.duration;
    
    CABasicAnimation *animation6 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation6.fromValue = (__bridge id _Nullable)(self.wavePathEnd.CGPath);
    animation6.toValue = (__bridge id _Nullable)(self.wavePathFill.CGPath);
    animation6.duration = 0.3;
    animation6.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation6.beginTime = animation5.beginTime + animation5.duration;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[animation1, animation2, animation3, animation4, animation5, animation6];
    animationGroup.duration = animation6.beginTime + animation6.duration;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    animationGroup.delegate = self;
    
    return animationGroup;
}

#pragma mark - UIBezierPath

- (UIBezierPath *)wavePathPre {
    if (!_wavePathPre) {
        CGRect bounds = [UIScreen mainScreen].bounds;
        CGFloat width = (0.866 * (90/2.0+15) + 5/2.0) * 2;
        // 左下角
        CGPoint lowerLeftPoint = CGPointMake(bounds.size.width/2 - 0.866 * (90/2.0+15) - 5/2.0, bounds.size.height/2 + 90/2.0/2.0 + 15/2 + 5/2.0);
        
        _wavePathPre = [UIBezierPath bezierPath];
        [_wavePathPre moveToPoint:lowerLeftPoint];
        [_wavePathPre addLineToPoint:CGPointMake(lowerLeftPoint.x, lowerLeftPoint.y-1)];
        [_wavePathPre addLineToPoint:CGPointMake(lowerLeftPoint.x + width, lowerLeftPoint.y-1)];
        [_wavePathPre addLineToPoint:CGPointMake(lowerLeftPoint.x + width, lowerLeftPoint.y)];
        [_wavePathPre closePath];
    }
    return _wavePathPre;
}

- (UIBezierPath *)wavePathStart {
    if (!_wavePathStart) {
        CGRect bounds = [UIScreen mainScreen].bounds;
        CGFloat width = (0.866 * (90/2.0+15) + 5/2.0) * 2;
        // 左下角
        CGPoint lowerLeftPoint = CGPointMake(bounds.size.width/2 - 0.866 * (90/2.0+15) - 5/2.0, bounds.size.height/2 + 90/2.0/2.0 + 15/2 + 5/2.0);
        
        _wavePathStart = [UIBezierPath bezierPath];
        [_wavePathStart moveToPoint:lowerLeftPoint];
        [_wavePathStart addLineToPoint:CGPointMake(lowerLeftPoint.x, lowerLeftPoint.y - width * 0.2)];
        [_wavePathStart addCurveToPoint:CGPointMake(lowerLeftPoint.x + width, lowerLeftPoint.y- width * 0.2) controlPoint1:CGPointMake(lowerLeftPoint.x + width * 0.3, lowerLeftPoint.y - width * 0.3) controlPoint2:CGPointMake(lowerLeftPoint.x + width * 0.4, lowerLeftPoint.y - width * 0.1)];
        [_wavePathStart addLineToPoint:CGPointMake(lowerLeftPoint.x + width, lowerLeftPoint.y)];
        [_wavePathStart closePath];
    }
    return _wavePathStart;
}

- (UIBezierPath *)wavePathLow {
    if (!_wavePathLow) {
        CGRect bounds = [UIScreen mainScreen].bounds;
        CGFloat width = (0.866 * (90/2.0+15) + 5/2.0) * 2;
        // 左下角
        CGPoint lowerLeftPoint = CGPointMake(bounds.size.width/2 - 0.866 * (90/2.0+15) - 5/2.0, bounds.size.height/2 + 90/2.0/2.0 + 15/2 + 5/2.0);
        
        _wavePathLow = [UIBezierPath bezierPath];
        [_wavePathLow moveToPoint:lowerLeftPoint];
        [_wavePathLow addLineToPoint:CGPointMake(lowerLeftPoint.x, lowerLeftPoint.y - width * 0.4)];
        [_wavePathLow addCurveToPoint:CGPointMake(lowerLeftPoint.x + width, lowerLeftPoint.y- width * 0.4) controlPoint1:CGPointMake(lowerLeftPoint.x + width * 0.3, lowerLeftPoint.y - width * 0.35) controlPoint2:CGPointMake(lowerLeftPoint.x + width * 0.4, lowerLeftPoint.y - width * 0.5)];
        [_wavePathLow addLineToPoint:CGPointMake(lowerLeftPoint.x + width, lowerLeftPoint.y)];
        [_wavePathLow closePath];
    }
    return _wavePathLow;
}

- (UIBezierPath *)wavePathMid {
    if (!_wavePathMid) {
        CGRect bounds = [UIScreen mainScreen].bounds;
        CGFloat width = (0.866 * (90/2.0+15) + 5/2.0) * 2;
        // 左下角
        CGPoint lowerLeftPoint = CGPointMake(bounds.size.width/2 - 0.866 * (90/2.0+15) - 5/2.0, bounds.size.height/2 + 90/2.0/2.0 + 15/2 + 5/2.0);
        
        _wavePathMid = [UIBezierPath bezierPath];
        [_wavePathMid moveToPoint:lowerLeftPoint];
        [_wavePathMid addLineToPoint:CGPointMake(lowerLeftPoint.x, lowerLeftPoint.y - width * 0.6)];
        [_wavePathMid addCurveToPoint:CGPointMake(lowerLeftPoint.x + width, lowerLeftPoint.y- width * 0.6) controlPoint1:CGPointMake(lowerLeftPoint.x + width * 0.3, lowerLeftPoint.y - width * 0.7) controlPoint2:CGPointMake(lowerLeftPoint.x + width * 0.4, lowerLeftPoint.y - width * 0.6)];
        [_wavePathMid addLineToPoint:CGPointMake(lowerLeftPoint.x + width, lowerLeftPoint.y)];
        [_wavePathMid closePath];
    }
    return _wavePathMid;
}

- (UIBezierPath *)wavePathHigh {
    if (!_wavePathHigh) {
        CGRect bounds = [UIScreen mainScreen].bounds;
        CGFloat width = (0.866 * (90/2.0+15) + 5/2.0) * 2;
        // 左下角
        CGPoint lowerLeftPoint = CGPointMake(bounds.size.width/2 - 0.866 * (90/2.0+15) - 5/2.0, bounds.size.height/2 + 90/2.0/2.0 + 15/2 + 5/2.0);
        
        _wavePathHigh = [UIBezierPath bezierPath];
        [_wavePathHigh moveToPoint:lowerLeftPoint];
        [_wavePathHigh addLineToPoint:CGPointMake(lowerLeftPoint.x, lowerLeftPoint.y - width * 0.8)];
        [_wavePathHigh addCurveToPoint:CGPointMake(lowerLeftPoint.x + width, lowerLeftPoint.y- width * 0.8) controlPoint1:CGPointMake(lowerLeftPoint.x + width * 0.3, lowerLeftPoint.y - width * 0.75) controlPoint2:CGPointMake(lowerLeftPoint.x + width * 0.4, lowerLeftPoint.y - width * 0.9)];
        [_wavePathHigh addLineToPoint:CGPointMake(lowerLeftPoint.x + width, lowerLeftPoint.y)];
        [_wavePathHigh closePath];
    }
    return _wavePathHigh;
}

- (UIBezierPath *)wavePathEnd {
    if (!_wavePathEnd) {
        CGRect bounds = [UIScreen mainScreen].bounds;
        CGFloat width = (0.866 * (90/2.0+15) + 5/2.0) * 2;
        // 左下角
        CGPoint lowerLeftPoint = CGPointMake(bounds.size.width/2 - 0.866 * (90/2.0+15) - 5/2.0, bounds.size.height/2 + 90/2.0/2.0 + 15/2 + 5/2.0);
        
        _wavePathEnd = [UIBezierPath bezierPath];
        [_wavePathEnd moveToPoint:lowerLeftPoint];
        [_wavePathEnd addLineToPoint:CGPointMake(lowerLeftPoint.x, lowerLeftPoint.y - width)];
        [_wavePathEnd addLineToPoint:CGPointMake(lowerLeftPoint.x + width, lowerLeftPoint.y- width)];
        [_wavePathEnd addLineToPoint:CGPointMake(lowerLeftPoint.x + width, lowerLeftPoint.y)];
        [_wavePathEnd closePath];
    }
    return _wavePathEnd;
}

- (UIBezierPath *)wavePathFill {
    if (!_wavePathFill) {
        CGRect bounds = [UIScreen mainScreen].bounds;
        _wavePathFill = [UIBezierPath bezierPath];
        [_wavePathFill moveToPoint:CGPointMake(0, bounds.size.height)];
        [_wavePathFill addLineToPoint:CGPointMake(0, 0)];
        [_wavePathFill addLineToPoint:CGPointMake(bounds.size.width, 0)];
        [_wavePathFill addLineToPoint:CGPointMake(bounds.size.width, bounds.size.height)];
        [_wavePathFill closePath];
    }
    return _wavePathFill;
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([self.animationDelegate respondsToSelector:@selector(waveLayerAnimationDidCompleted:)]) {
        [self.animationDelegate waveLayerAnimationDidCompleted:flag];
    }
}


@end
