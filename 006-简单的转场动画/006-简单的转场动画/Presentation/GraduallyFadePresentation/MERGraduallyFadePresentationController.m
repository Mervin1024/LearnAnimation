//
//  MERGraduallyFadePresentationController.m
//  MERPresentation
//
//  Created by 马遥 on 2017/11/29.
//  Copyright © 2017年 boxfish. All rights reserved.
//

#import "MERGraduallyFadePresentationController.h"

@implementation MERGraduallyFadePresentationController

#pragma mark - Override

- (void)presentationTransitionWillBegin {
    id <UIViewControllerTransitionCoordinator> coordinator = self.presentedViewController.transitionCoordinator;
    if (coordinator) {
        [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
//            self.dimmingView.alpha = 1;
        } completion:nil];
    } else {
//        self.dimmingView.alpha = 1;
    }
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    if (!completed) {
//        [self.dimmingView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin {
    id <UIViewControllerTransitionCoordinator> coordinator = self.presentedViewController.transitionCoordinator;
    if (coordinator) {
        [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
//            self.dimmingView.alpha = 0;
        } completion:nil];
    } else {
//        self.dimmingView.alpha = 0;
    }
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
        if (self.dismissBlock) {
            self.dismissBlock();
        }
    }
}

- (CGRect)frameOfPresentedViewInContainerView {
    CGRect frame = self.containerView.bounds;
    return frame;
}


@end
