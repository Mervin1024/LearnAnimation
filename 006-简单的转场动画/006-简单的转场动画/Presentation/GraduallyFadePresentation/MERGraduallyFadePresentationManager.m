//
//  MERGraduallyFadePresentationManager.m
//  MERPresentation
//
//  Created by 马遥 on 2017/11/29.
//  Copyright © 2017年 boxfish. All rights reserved.
//

#import "MERGraduallyFadePresentationManager.h"
#import "MERGraduallyFadePresentationController.h"
#import "MERGraduallyFadePresentationAnimator.h"
#import "MERPresentationInteractive.h"

@implementation MERGraduallyFadePresentationManager {
    MERPresentationInteractive *_interactive;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _interactive = [[MERPresentationInteractive alloc] init];
    }
    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    MERGraduallyFadePresentationController *controller = [[MERGraduallyFadePresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    controller.dismissBlock = self.dismissBlock;
    return controller;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    [_interactive setDismissGestureRecognizerToViewController:presented];
    return [[MERGraduallyFadePresentationAnimator alloc] initWhenPresentation:YES];;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[MERGraduallyFadePresentationAnimator alloc] initWhenPresentation:NO];;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return _interactive.isInteracting ? _interactive : nil;
}


@end
