//
//RippleAnimationView.m
//boxfish-english
//
//Created by mervin on 2016/11/4.
//Copyright © 2016年 boxfish. All rights reserved.
//

#import "RippleAnimationView.h"

static NSInteger const pulsingCount = 3;
static double const animationDuration = 3;

@interface RippleAnimationView ()
@property (nonatomic, assign) AnimationType animationType;
@end

@implementation RippleAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame animationType:AnimationTypeWithBackground];
}

- (instancetype)initWithFrame:(CGRect)frame animationType:(AnimationType)animationType {
    self = [super initWithFrame:frame];
    
    if (self) {
        _animationType = animationType;
        self.backgroundColor = [UIColor clearColor];
        
        if (animationType == AnimationTypeWithBackground) {
            _multiple = 1.423;
        } else {
            _multiple = 1.523;
        }
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CALayer *animationLayer = [CALayer layer];
    
    for (int i = 0; i < pulsingCount; i++) {
        NSArray *animationArray = [self animationArray];
        CAAnimationGroup *animationGroup = [self animationGroupAnimations:animationArray index:i];
        CALayer *pulsingLayer = [self pulsingLayer:rect animation:animationGroup];
        [animationLayer addSublayer:pulsingLayer];
    }
    
    [self.layer addSublayer:animationLayer];
}

- (NSArray *)animationArray {
    NSArray *animationArray = nil;
    
    if (_animationType == AnimationTypeWithBackground) {
        CABasicAnimation *scaleAnimation = [self scaleAnimation];
        CAKeyframeAnimation *borderColorAnimation = [self borderColorAnimation];
        CAKeyframeAnimation *backgroundColorAnimation = [self backgroundColorAnimation];
        animationArray = @[scaleAnimation, backgroundColorAnimation, borderColorAnimation];
    } else {
        CABasicAnimation *scaleAnimation = [self scaleAnimation];
        CAKeyframeAnimation *blackBorderColorAnimation = [self blackBorderColorAnimation];
        animationArray = @[scaleAnimation, blackBorderColorAnimation];
    }
    
    return animationArray;
}

- (CAAnimationGroup *)animationGroupAnimations:(NSArray *)array index:(int)index {
    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    animationGroup.fillMode = kCAFillModeBackwards;
    animationGroup.beginTime = CACurrentMediaTime() + (double)(index * animationDuration) / (double)pulsingCount;
    animationGroup.duration = animationDuration;
    animationGroup.repeatCount = HUGE;
    animationGroup.timingFunction = defaultCurve;
    animationGroup.animations = array;
    animationGroup.removedOnCompletion = NO;
    return animationGroup;
}

- (CALayer *)pulsingLayer:(CGRect)rect animation:(CAAnimationGroup *)animationGroup {
    CALayer *pulsingLayer = [CALayer layer];
    
    pulsingLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    
    if (_animationType == AnimationTypeWithBackground) {
        pulsingLayer.backgroundColor = ColorWithAlpha(255, 216, 87, 0.5).CGColor;
        pulsingLayer.borderWidth = 0.5;
    } else {
        pulsingLayer.borderWidth = 1.f;
    }
    
    pulsingLayer.borderColor = ColorWithAlpha(255, 216, 87, 0.5).CGColor;
    pulsingLayer.cornerRadius = rect.size.height / 2;
    [pulsingLayer addAnimation:animationGroup forKey:@"plulsing"];
    return pulsingLayer;
}

- (CABasicAnimation *)scaleAnimation {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.fromValue = @1;
    scaleAnimation.toValue = @(_multiple);
    return scaleAnimation;
}

- (CAKeyframeAnimation *)backgroundColorAnimation {
    CAKeyframeAnimation *backgroundColorAnimation = [CAKeyframeAnimation animation];
    
    backgroundColorAnimation.keyPath = @"backgroundColor";
    backgroundColorAnimation.values = @[(__bridge id)ColorWithAlpha(255, 216, 87, 0.5).CGColor,
                                        (__bridge id)ColorWithAlpha(255, 231, 152, 0.5).CGColor,
                                        (__bridge id)ColorWithAlpha(255, 241, 197, 0.5).CGColor,
                                        (__bridge id)ColorWithAlpha(255, 241, 197, 0).CGColor];
    backgroundColorAnimation.keyTimes = @[@0.3,@0.6,@0.9,@1];
    return backgroundColorAnimation;
}

- (CAKeyframeAnimation *)borderColorAnimation {
    CAKeyframeAnimation *borderColorAnimation = [CAKeyframeAnimation animation];
    
    borderColorAnimation.keyPath = @"borderColor";
    borderColorAnimation.values = @[(__bridge id)ColorWithAlpha(255, 216, 87, 0.5).CGColor,
                                    (__bridge id)ColorWithAlpha(255, 231, 152, 0.5).CGColor,
                                    (__bridge id)ColorWithAlpha(255, 241, 197, 0.5).CGColor,
                                    (__bridge id)ColorWithAlpha(255, 241, 197, 0).CGColor];
    borderColorAnimation.keyTimes = @[@0.3,@0.6,@0.9,@1];
    return borderColorAnimation;
}

- (CAKeyframeAnimation *)blackBorderColorAnimation {
    CAKeyframeAnimation *borderColorAnimation = [CAKeyframeAnimation animation];
    
    borderColorAnimation.keyPath = @"borderColor";
    borderColorAnimation.values = @[(__bridge id)ColorWithAlpha(0, 0, 0, 0.4).CGColor,
                                    (__bridge id)ColorWithAlpha(0, 0, 0, 0.4).CGColor,
                                    (__bridge id)ColorWithAlpha(0, 0, 0, 0.1).CGColor,
                                    (__bridge id)ColorWithAlpha(0, 0, 0, 0).CGColor];
    borderColorAnimation.keyTimes = @[@0.3,@0.6,@0.9,@1];
    return borderColorAnimation;
}

@end
