//
//  BFEDailyTaskImageView.m
//  boxfish-english
//
//  Created by 马遥 on 2018/1/25.
//  Copyright © 2018年 boxfish. All rights reserved.
//

#define COLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#import "BFEDailyTaskImageView.h"

@interface BFEDailyTaskImageView ()
@property (nonatomic, assign) BFEDailyTaskType type;
@property (nonatomic, strong) CALayer *imageLayer;
@property (nonatomic, strong) CAShapeLayer *diffuseLayer;
@end

@implementation BFEDailyTaskImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _type = BFEDailyTaskTypeStudy;
        [self configureView];
    }
    return self;
}

- (instancetype)initWithDailyTaskType:(BFEDailyTaskType)type {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _type = type;
        [self configureView];
    }
    return self;
}

- (void)configureView {
    [self createImageLayer];
    [self createDiffuseLayer];
}

- (void)createImageLayer {
    self.imageLayer = [CALayer layer];
    self.imageLayer.frame = self.layer.bounds;
    [self.layer addSublayer:self.imageLayer];
    self.imageLayer.contents = (__bridge id _Nullable)([self contentImage].CGImage);
}

- (void)createDiffuseLayer {
    self.diffuseLayer = [CAShapeLayer layer];
    self.diffuseLayer.fillColor = [UIColor clearColor].CGColor;
    self.diffuseLayer.strokeColor = COLOR(255, 61, 50).CGColor;
    self.diffuseLayer.lineWidth = 1;
    self.diffuseLayer.path = [self diffuseBeginPath].CGPath;
    [self.layer insertSublayer:self.diffuseLayer atIndex:0];

}

- (void)startAnimation {
    [self.imageLayer addAnimation:[self expandAnimation] forKey:nil];
    [self.diffuseLayer addAnimation:[self diffuseAnimation] forKey:nil];
}

#pragma mark - ShapeLayer 的 path

- (UIBezierPath *)diffuseBeginPath {
    CGFloat frameWidth = self.frame.size.width;
    CGFloat smallWidth = self.frame.size.width * 0.6;
    CGRect ovalRect = CGRectMake(frameWidth/2 - smallWidth/2,
                                 frameWidth/2 - smallWidth/2,
                                 smallWidth,
                                 smallWidth);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
    return path;
}

- (UIBezierPath *)diffuseEndPath {
    CGFloat frameWidth = self.frame.size.width;
    CGFloat smallWidth = self.frame.size.width * 1.5;
    CGRect ovalRect = CGRectMake(frameWidth/2 - smallWidth/2,
                                 frameWidth/2 - smallWidth/2,
                                 smallWidth,
                                 smallWidth);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
    return path;
}

#pragma mark - Layer 层的动画

- (CAAnimationGroup *)expandAnimation {
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation1.fromValue = @1;
    animation1.toValue = @1.07;
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation1.duration = 0.1;
    animation1.beginTime = 0;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation2.fromValue = @1.07;
    animation2.toValue = @1;
    animation2.duration = 0.5;
    animation2.beginTime = animation1.duration + animation1.beginTime;
    
    CABasicAnimation *animationEnd = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animationEnd.fromValue = @1;
    animationEnd.toValue = @1;
    animationEnd.duration = 1;
    animationEnd.beginTime = animation2.duration + animation2.beginTime;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[animation1, animation2, animationEnd];
    animationGroup.duration = animationEnd.beginTime + animationEnd.duration;
    animationGroup.repeatCount = CGFLOAT_MAX;
    return animationGroup;
}

- (CAAnimationGroup *)diffuseAnimation {
    CABasicAnimation *animation0 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation0.fromValue = @1;
    animation0.fromValue = @1;
    animation0.duration = 0.07;
    animation0.beginTime = 0;
    
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation1.fromValue = (__bridge id _Nullable)([self diffuseBeginPath].CGPath);
    animation1.toValue = (__bridge id _Nullable)([self diffuseEndPath].CGPath);
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation1.duration = 0.9;
    animation1.beginTime = animation0.duration + animation0.beginTime;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation2.fromValue = @1;
    animation2.toValue = @0;
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation2.duration = 0.7;
    animation2.beginTime = animation1.beginTime;
    animation2.fillMode = kCAFillModeForwards;
    animation2.removedOnCompletion = NO;
    
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation3.fromValue = @1;
    animation3.fromValue = @1;
    animation3.duration = 0.83;
    animation3.beginTime = animation2.duration + animation2.beginTime;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[animation1, animation2, animation3];
    animationGroup.duration = animation3.duration + animation3.beginTime;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animationGroup.repeatCount = CGFLOAT_MAX;
    return animationGroup;
}

#pragma mark - Setter & Getter

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    if (self.imageLayer) {
        self.imageLayer.frame = self.layer.bounds;
    }
}

- (UIImage *)contentImage {
    if (self.type == BFEDailyTaskTypeStudy) {
        return [UIImage imageNamed:@"daily_task_study_task"];
    } else if (self.type == BFEDailyTaskTypeCourse) {
        return [UIImage imageNamed:@"daily_task_course_task"];
    }
    return [UIImage new];
}

@end
