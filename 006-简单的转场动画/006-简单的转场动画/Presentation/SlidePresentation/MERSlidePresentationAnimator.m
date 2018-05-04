//
//  MERSlidePresentationAnimator.m
//  MERPresentation
//
//  Created by 马遥 on 2017/11/21.
//  Copyright © 2017年 boxfish. All rights reserved.
//

#import "MERSlidePresentationAnimator.h"

@interface MERSlidePresentationAnimator ()
@property (nonatomic, assign) BOOL isPresentation;// 判断当前需要弹出动画还是收回动画
@property (nonatomic, assign) MERSlidePresentationDirection direction;
@end

@implementation MERSlidePresentationAnimator

- (instancetype)initWithDirection:(MERSlidePresentationDirection)direction isPresentation:(BOOL)isPresentation {
    self = [super init];
    if (self) {
        _direction = direction;
        _isPresentation = isPresentation;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSString *key = self.isPresentation ? UITransitionContextToViewControllerKey : UITransitionContextFromViewControllerKey;
    UIViewController *controller = [transitionContext viewControllerForKey:key];
    if (self.isPresentation) {
        [transitionContext.containerView addSubview:controller.view];
    }
    
    CGRect presentedFrame = [transitionContext finalFrameForViewController:controller];
    CGRect dismissedFrame = presentedFrame;
    switch (self.direction) {
        case MERSlidePresentationDirectionLeft:
            dismissedFrame.origin.x = -presentedFrame.size.width;
            break;
        case MERSlidePresentationDirectionRight:
            dismissedFrame.origin.x = transitionContext.containerView.bounds.size.width;
            break;
        case MERSlidePresentationDirectionTop:
            dismissedFrame.origin.y = -presentedFrame.size.height;
            break;
        case MERSlidePresentationDirectionBottom:
            dismissedFrame.origin.y = transitionContext.containerView.bounds.size.height;
            break;
    }
    
    CGRect initialFrame = self.isPresentation ? dismissedFrame : presentedFrame;
    CGRect finalFrame = self.isPresentation ? presentedFrame : dismissedFrame;
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    controller.view.frame = initialFrame;
    
    [UIView animateWithDuration:duration delay:0.f usingSpringWithDamping:1.f initialSpringVelocity:5.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        controller.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];

}

@end
