//
//  CircleLayer.m
//  005-一个复杂动画的实现_OC
//
//  Created by 马遥 on 2018/1/23.
//  Copyright © 2018年 马遥. All rights reserved.
//

#import "CircleLayer.h"

@interface CircleLayer ()<CAAnimationDelegate>
@property (nonatomic, strong) UIBezierPath *circleSmallPath;
@property (nonatomic, strong) UIBezierPath *circleBigPath;
@property (nonatomic, strong) UIBezierPath *verticalEllipsePath;
@property (nonatomic, strong) UIBezierPath *horizontalEllipsePath;
@end

static CFTimeInterval const KAnimationDuration = 0.3;
static CFTimeInterval const KAnimationBeginTime = 0.0;
static NSString *const KAnimationName = @"AnimationName";
static NSString *const ExpandAnimationName = @"expandAnimation";
static NSString *const WobbleAnimationName = @"wobbleAnimation";
static NSString *const ReduceAnimationName = @"reduceAnimation";


@implementation CircleLayer

- (instancetype)init {
    self = [super init];
    if (self) {
        self.path = self.circleSmallPath.CGPath;
        self.fillColor = [UIColor colorWithRed:218/255.0 green:112/255.0 blue:214/255.0 alpha:1].CGColor;
    }
    return self;
}
// 扩大动画
- (void)startExpand {
    [self expand];
}

- (void)expand {
    [self addAnimation:[self expandAnimation] forKey:ExpandAnimationName];
}

- (void)wobble {
    [self addAnimation:[self wobbleAnimationGroup] forKey:WobbleAnimationName];
}
// 缩小动画
- (void)startReduce {
    [self reduce];
}

- (void)reduce {
    [self addAnimation:[self reduceAnimation] forKey:ReduceAnimationName];
}

#pragma mark - Animations

- (CABasicAnimation *)expandAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id _Nullable)(self.circleSmallPath.CGPath);
    animation.toValue = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    animation.duration = KAnimationDuration;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [animation setValue:ExpandAnimationName forKey:KAnimationName];
    animation.delegate = self;
    return animation;
}

- (CAAnimationGroup *)wobbleAnimationGroup {
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation1.fromValue = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    animation1.toValue = (__bridge id _Nullable)(self.horizontalEllipsePath.CGPath);
    animation1.duration = KAnimationDuration;
    animation1.beginTime = KAnimationBeginTime;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation2.fromValue = (__bridge id _Nullable)(self.horizontalEllipsePath.CGPath);
    animation2.toValue = (__bridge id _Nullable)(self.verticalEllipsePath.CGPath);
    animation2.duration = KAnimationDuration;
    animation2.beginTime = animation1.duration + animation1.beginTime;

    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation3.fromValue = (__bridge id _Nullable)(self.verticalEllipsePath.CGPath);
    animation3.toValue = (__bridge id _Nullable)(self.horizontalEllipsePath.CGPath);
    animation3.duration = KAnimationDuration;
    animation3.beginTime = animation2.duration + animation2.beginTime;

    CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation4.fromValue = (__bridge id _Nullable)(self.horizontalEllipsePath.CGPath);
    animation4.toValue = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    animation4.duration = KAnimationDuration;
    animation4.beginTime = animation3.duration + animation3.beginTime;

    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[animation1, animation2, animation3, animation4];
    animationGroup.duration = animation4.duration + animation4.beginTime;
    animationGroup.repeatCount = 2;
    animationGroup.delegate = self;
    [animationGroup setValue:WobbleAnimationName forKey:KAnimationName];
    
    return animationGroup;
}

- (CABasicAnimation *)reduceAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.toValue = (__bridge id _Nullable)(self.circleSmallPath.CGPath);
    animation.duration = KAnimationDuration;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    [animation setValue:ReduceAnimationName forKey:KAnimationName];
    return animation;
}

#pragma mark - UIBezierPath

- (UIBezierPath *)circleSmallPath {
    if (!_circleSmallPath) {
        CGRect bounds = [UIScreen mainScreen].bounds;
        CGFloat width = 0;
        _circleSmallPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(bounds.size.width/2-width/2, bounds.size.height/2-width/2, width, width)];;
    }
    return _circleSmallPath;
}

- (UIBezierPath *)circleBigPath {
    if (!_circleBigPath) {
        CGRect bounds = [UIScreen mainScreen].bounds;
        CGFloat width = 95;
        _circleBigPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(bounds.size.width/2-width/2, bounds.size.height/2-width/2, width, width)];
    }
    return _circleBigPath;
}

- (UIBezierPath *)verticalEllipsePath {
    if (!_verticalEllipsePath) {
        CGRect bounds = [UIScreen mainScreen].bounds;
        CGFloat width = 90;
        CGFloat height = 100;
        _verticalEllipsePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(bounds.size.width/2-width/2, bounds.size.height/2-height/2, width, height)];
    }
    return _verticalEllipsePath;
}

- (UIBezierPath *)horizontalEllipsePath {
    if (!_horizontalEllipsePath) {
        CGRect bounds = [UIScreen mainScreen].bounds;
        CGFloat width = 100;
        CGFloat height = 90;
        _horizontalEllipsePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(bounds.size.width/2-width/2, bounds.size.height/2-height/2, width, height)];
    }
    return _horizontalEllipsePath;
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim {
//    NSLog(@"动画开始");
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        NSString *animationName = [anim valueForKey:KAnimationName];
        if ([animationName isEqualToString:ExpandAnimationName]) {
            [self wobble];
        }
    }
}

@end
