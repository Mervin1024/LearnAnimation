//
//  MERDiffusePresentationAnimator.m
//  MERPresentation
//
//  Created by 马遥 on 2018/2/5.
//  Copyright © 2018年 马遥. All rights reserved.
//

#import "MERDiffusePresentationAnimator.h"
#import "MERRipplesAnimatedView.h"

@interface MERDiffusePresentationAnimator ()
@property (nonatomic, assign) BOOL isPresentation;// 判断当前需要弹出动画还是收回动画
@property (nonatomic, assign) CGPoint startingPoint;
@end

@implementation MERDiffusePresentationAnimator

- (instancetype)initWhenPresentation:(BOOL)isPresentation startingPoint:(CGPoint)startingPoint {
    self = [super init];
    if (self) {
        _isPresentation = isPresentation;
        _startingPoint = startingPoint;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController *pushedVC = self.isPresentation ? toVC : fromVC;
    if (self.isPresentation) {
        [transitionContext.containerView addSubview:toVC.view];
    }
    
    CGRect smallRect = CGRectMake(self.startingPoint.x, self.startingPoint.y, 1, 1);
    CGFloat extremeX = MAX(self.startingPoint.x, CGRectGetWidth(pushedVC.view.bounds)-self.startingPoint.x);
    CGFloat extremeY = MAX(self.startingPoint.y, CGRectGetHeight(pushedVC.view.bounds)-self.startingPoint.y);
    CGPoint extremePoint = CGPointMake(extremeX, extremeY);
    CGFloat radius = sqrtf(extremePoint.x * extremePoint.x + extremePoint.y * extremePoint.y);
    CGRect largeRect = CGRectInset(smallRect, -radius, -radius);
    
    CGRect initialRect = self.isPresentation ? smallRect : largeRect;
    CGRect finalRect = self.isPresentation ? largeRect : smallRect;
    
    
    if (self.isPresentation) {
        MERRipplesAnimatedView *animatedView = [[MERRipplesAnimatedView alloc] initWithFrame:initialRect];
        pushedVC.view.maskView = animatedView;
        if ([self.delegate respondsToSelector:@selector(setAnimatingMaskViewAfterPresented:)]) {
            [self.delegate setAnimatingMaskViewAfterPresented:animatedView];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(getAnimatingMaskViewBeforeDismiss)]) {
            UIView *maskView = [self.delegate getAnimatingMaskViewBeforeDismiss];
            pushedVC.view.maskView = maskView;
        }
    }
    
    UIViewAnimationOptions options = self.isPresentation ? UIViewAnimationOptionCurveEaseInOut : UIViewAnimationOptionCurveEaseInOut;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:options animations:^{
        pushedVC.view.maskView.frame = finalRect;
    } completion:^(BOOL finished) {
        pushedVC.view.maskView = nil;
        [transitionContext completeTransition:finished];
    }];

}


@end
