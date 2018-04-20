//
//  MERRegisterGuidePresentationManager.m
//  006-简单的转场动画
//
//  Created by 马遥 on 2018/4/20.
//  Copyright © 2018年 马遥. All rights reserved.
//

#import "MERRegisterGuidePresentationManager.h"
#import "MERRegisterGuidePresentationController.h"
#import "MERRegisterGuidePresentationAnimator.h"

@implementation MERRegisterGuidePresentationManager

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    MERRegisterGuidePresentationController *controller = [[MERRegisterGuidePresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    return controller;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    MERRegisterGuidePresentationAnimator *animator = [[MERRegisterGuidePresentationAnimator alloc] init];
    return animator;
}

@end
