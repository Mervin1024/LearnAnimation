//
//  MERRegisterGuidePresentationController.m
//  006-简单的转场动画
//
//  Created by 马遥 on 2018/4/20.
//  Copyright © 2018年 马遥. All rights reserved.
//

#import "MERRegisterGuidePresentationController.h"

@implementation MERRegisterGuidePresentationController

- (void)presentationTransitionWillBegin {
    id <UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentedViewController.transitionCoordinator;
    if (transitionCoordinator) {
        [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            
        } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            
        }];
    } else {
        
    }
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    if (!completed) {
        
    }
}

- (void)dismissalTransitionWillBegin {
    id <UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentedViewController.transitionCoordinator;
    if (transitionCoordinator) {
        [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            
        } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            
        }];
    } else {
        
    }
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
        
    }
}

- (CGRect)frameOfPresentedViewInContainerView {
    return [UIScreen mainScreen].bounds;
}

@end
