//
//  MERGraduallyFadePresentationAnimator.m
//  MERPresentation
//
//  Created by 马遥 on 2017/11/29.
//  Copyright © 2017年 boxfish. All rights reserved.
//

#import "MERGraduallyFadePresentationAnimator.h"

@interface MERGraduallyFadePresentationAnimator ()
@property (nonatomic, assign) BOOL isPresentation;// 判断当前需要弹出动画还是收回动画
@end

@implementation MERGraduallyFadePresentationAnimator

- (instancetype)initWhenPresentation:(BOOL)isPresentation {
    self = [super init];
    if (self) {
        _isPresentation = isPresentation;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSString *key = self.isPresentation ? UITransitionContextToViewKey : UITransitionContextFromViewKey;
    UIView *toView = [transitionContext viewForKey:key];
    if (self.isPresentation) {
        [transitionContext.containerView addSubview:toView];
    }
    
    CGPoint outPosition = CGPointMake(toView.bounds.size.width, toView.bounds.size.height * 0.5);
    CGPoint inPosition = CGPointMake(0, toView.bounds.size.height * 0.5);
    CGPoint beginPosition = self.isPresentation ? outPosition : inPosition;
    CGPoint endPosition = self.isPresentation ? inPosition : outPosition;
    
    toView.frame = transitionContext.containerView.bounds;
    toView.layer.anchorPoint = CGPointMake(0, 0.5);
    toView.layer.position = beginPosition;

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    

    CATransform3D beginTransform = CATransform3DIdentity ;
    CATransform3D endTransform = CATransform3DIdentity ;
    
    if (self.isPresentation) {
        CATransform3D identity = CATransform3DIdentity;
        identity.m34 = -1.0 / 500.0;
        beginTransform = CATransform3DRotate(identity, M_PI/3, 0, 1, 0);
    } else {
        endTransform = CATransform3DRotate(CATransform3DIdentity, -M_PI_2, 0, 1, 0);
        endTransform.m34 = -1.0 / 500.0;
    }
    
    toView.layer.transform = beginTransform;
    
    [UIView animateWithDuration:duration animations:^{
        toView.layer.transform = endTransform;
        toView.layer.position = endPosition;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}

@end
