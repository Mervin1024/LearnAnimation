//
//  MERRegisterGuidePresentationAnimator.m
//  006-简单的转场动画
//
//  Created by 马遥 on 2018/4/20.
//  Copyright © 2018年 马遥. All rights reserved.
//

#import "MERRegisterGuidePresentationAnimator.h"

static NSTimeInterval TransitionDuration = 1.6;

@implementation MERRegisterGuidePresentationAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return TransitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    toVC.view.transform = CGAffineTransformTranslate(toVC.view.transform, 0, [UIScreen mainScreen].bounds.size.height);
    
    UIView *superView = toVC.view.superview;
    [superView bringSubviewToFront:toVC.view];
    
    [UIView animateWithDuration:TransitionDuration delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        toVC.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    
}

@end
