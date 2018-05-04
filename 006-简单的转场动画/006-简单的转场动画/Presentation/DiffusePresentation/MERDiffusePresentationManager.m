//
//  MERDiffusePresentationManager.m
//  MERPresentation
//
//  Created by 马遥 on 2018/2/5.
//  Copyright © 2018年 马遥. All rights reserved.
//

#import "MERDiffusePresentationManager.h"
#import "MERDiffusePresentationController.h"
#import "MERDiffusePresentationAnimator.h"
#import "MERPresentationInteractive.h"

@interface MERDiffusePresentationManager () <MERDiffuseDelegate>
@property (nonatomic, strong) UIView *animatingMaskView;
@end

@implementation MERDiffusePresentationManager {
    CGPoint _startingPoint;
    MERPresentationInteractive *_interactive;
}

- (instancetype)initWithStartingPoint:(CGPoint)startingPoint {
    self = [super init];
    if (self) {
        _startingPoint = startingPoint;
        _interactive = [[MERPresentationInteractive alloc] init];
    }
    return self;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    MERDiffusePresentationController *controller = [[MERDiffusePresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    return controller;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    [_interactive setDismissGestureRecognizerToViewController:presented];
    MERDiffusePresentationAnimator *animator = [[MERDiffusePresentationAnimator alloc] initWhenPresentation:YES startingPoint:_startingPoint];
    animator.delegate = self;
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    MERDiffusePresentationAnimator *animator = [[MERDiffusePresentationAnimator alloc] initWhenPresentation:NO startingPoint:_startingPoint];
    animator.delegate = self;
    return animator;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return _interactive.isInteracting ? _interactive : nil;
}

#pragma mark - MERDiffuseDelegate

- (void)setAnimatingMaskViewAfterPresented:(UIView *)animatingMaskView {
    self.animatingMaskView = animatingMaskView;
}

- (UIView *)getAnimatingMaskViewBeforeDismiss {
    return self.animatingMaskView;
}

@end
