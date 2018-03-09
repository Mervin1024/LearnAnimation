//
//  TriangleLayer.m
//  005-一个复杂动画的实现_OC
//
//  Created by 马遥 on 2018/1/23.
//  Copyright © 2018年 马遥. All rights reserved.
//

#import "TriangleLayer.h"

@interface TriangleLayer ()
@property (nonatomic, strong) UIBezierPath *triangSmallPath;
@property (nonatomic, strong) UIBezierPath *triangLeftPath;
@property (nonatomic, strong) UIBezierPath *triangRightPath;
@property (nonatomic, strong) UIBezierPath *triangTopPath;

@end

static CGFloat const radius = (90.f-7)/2.f;
static CGFloat const interval = 0.134 * radius;
static CGFloat const padding = 15;

@implementation TriangleLayer

- (instancetype)init {
    self = [super init];
    if (self) {
        self.fillColor = [UIColor colorWithRed:218/255.0 green:112/255.0 blue:214/255.0 alpha:1].CGColor;
        self.strokeColor = self.fillColor;
        self.lineWidth = 7;
        self.lineCap = kCALineCapRound;
        self.lineJoin = kCALineJoinRound;
        self.path = self.triangSmallPath.CGPath;
    }
    return self;
}

- (void)startAppear {
    [self addAnimation:[self triangleAnimation] forKey:nil];
}

#pragma mark - Animations

- (CAAnimationGroup *)triangleAnimation {
    
    CABasicAnimation *leftAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    leftAnimation.fromValue = (__bridge id _Nullable)(self.triangSmallPath.CGPath);
    leftAnimation.toValue = (__bridge id _Nullable)(self.triangLeftPath.CGPath);
    leftAnimation.duration = 0.3;
    leftAnimation.beginTime = 0.0;
    
    CABasicAnimation *rightAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    rightAnimation.fromValue = (__bridge id _Nullable)(self.triangLeftPath.CGPath);
    rightAnimation.toValue = (__bridge id _Nullable)(self.triangRightPath.CGPath);
    rightAnimation.duration = 0.25;
    rightAnimation.beginTime = leftAnimation.beginTime + leftAnimation.duration;
    
    CABasicAnimation *topAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    topAnimation.fromValue = (__bridge id _Nullable)(self.triangRightPath.CGPath);
    topAnimation.toValue = (__bridge id _Nullable)(self.triangTopPath.CGPath);
    topAnimation.duration = 0.2;
    topAnimation.beginTime = rightAnimation.beginTime + rightAnimation.duration;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[leftAnimation, rightAnimation, topAnimation];
    animationGroup.duration = topAnimation.beginTime + topAnimation.duration;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    
    return animationGroup;
}

#pragma mark - UIBezierPath

- (UIBezierPath *)triangSmallPath {
    if (!_triangSmallPath) {
        CGRect bounds = [UIScreen mainScreen].bounds;
        // 上顶点
        CGPoint topPoint = CGPointMake(bounds.size.width/2, bounds.size.height/2-radius);
        // 左顶点
        CGPoint leftPoint = CGPointMake(bounds.size.width/2 - radius + interval, bounds.size.height/2 + radius/2);
        // 右顶点
        CGPoint rightPoint = CGPointMake(bounds.size.width/2 + radius - interval, bounds.size.height/2 + radius/2);
        
        _triangSmallPath = [UIBezierPath bezierPath];
        
        [_triangSmallPath moveToPoint:topPoint];
        [_triangSmallPath addLineToPoint:leftPoint];
        [_triangSmallPath addLineToPoint:rightPoint];
        
        [_triangSmallPath closePath];
        
    }
    return _triangSmallPath;
}

- (UIBezierPath *)triangLeftPath {
    if (!_triangLeftPath) {
        CGRect bounds = [UIScreen mainScreen].bounds;
        
        _triangLeftPath = [UIBezierPath bezierPath];
        // 上顶点
        CGPoint topPoint = CGPointMake(bounds.size.width/2, bounds.size.height/2-radius);
        // 左顶点
        CGPoint leftPoint = CGPointMake(bounds.size.width/2 - radius + interval - padding * 0.866, bounds.size.height/2 + radius/2 + padding/2);
        // 右顶点
        CGPoint rightPoint = CGPointMake(bounds.size.width/2 + radius - interval, bounds.size.height/2 + radius/2);
        
        [_triangLeftPath moveToPoint:topPoint];
        [_triangLeftPath addLineToPoint:leftPoint];
        [_triangLeftPath addLineToPoint:rightPoint];
        
        [_triangLeftPath closePath];

    }
    return _triangLeftPath;
}

- (UIBezierPath *)triangRightPath {
    if (!_triangRightPath) {
        CGRect bounds = [UIScreen mainScreen].bounds;
        // 上顶点
        CGPoint topPoint = CGPointMake(bounds.size.width/2, bounds.size.height/2-radius);
        // 左顶点
        CGPoint leftPoint = CGPointMake(bounds.size.width/2 - radius + interval - padding * 0.866, bounds.size.height/2 + radius/2 + padding/2);
        // 右顶点
        CGPoint rightPoint = CGPointMake(bounds.size.width/2 + radius - interval + padding * 0.866, bounds.size.height/2 + radius/2 + padding/2);
        
        _triangRightPath = [UIBezierPath bezierPath];

        [_triangRightPath moveToPoint:topPoint];
        [_triangRightPath addLineToPoint:leftPoint];
        [_triangRightPath addLineToPoint:rightPoint];

        [_triangRightPath closePath];

    }
    return _triangRightPath;
}

- (UIBezierPath *)triangTopPath {
    if (!_triangTopPath) {
        CGRect bounds = [UIScreen mainScreen].bounds;
        // 上顶点
        CGPoint topPoint = CGPointMake(bounds.size.width/2, bounds.size.height/2-radius - padding);
        // 左顶点
        CGPoint leftPoint = CGPointMake(bounds.size.width/2 - radius + interval - padding * 0.866, bounds.size.height/2 + radius/2 + padding/2);
        // 右顶点
        CGPoint rightPoint = CGPointMake(bounds.size.width/2 + radius - interval + padding * 0.866, bounds.size.height/2 + radius/2 + padding/2);
        
        _triangTopPath = [UIBezierPath bezierPath];
        
        [_triangTopPath moveToPoint:topPoint];
        [_triangTopPath addLineToPoint:leftPoint];
        [_triangTopPath addLineToPoint:rightPoint];
        
        [_triangTopPath closePath];
        
    }
    return _triangTopPath;
}

@end
