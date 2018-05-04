//
//  MERSlidePresentationManager.m
//  MERPresentation
//
//  Created by 马遥 on 2017/11/21.
//  Copyright © 2017年 boxfish. All rights reserved.
//

#import "MERSlidePresentationManager.h"
#import "MERSlidePresentationController.h"
#import "MERSlidePresentationAnimator.h"

@interface MERSlidePresentationManager ()

@end

@implementation MERSlidePresentationManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _direction = MERSlidePresentationDirectionBottom;
        CGRect screenBounds = [UIScreen mainScreen].bounds;
        _viewSize = CGSizeMake(screenBounds.size.width, screenBounds.size.height);
        _hideWhenClickBlankArea = YES;
    }
    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    MERSlidePresentationController *controller = [[MERSlidePresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting direction:self.direction viewSize:self.viewSize];
    controller.dismissBlock = self.dismissBlock;
    controller.hideWhenClickBlankArea = self.hideWhenClickBlankArea;
    return controller;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return [[MERSlidePresentationAnimator alloc] initWithDirection:self.direction isPresentation:YES];;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[MERSlidePresentationAnimator alloc] initWithDirection:self.direction isPresentation:NO];;
}

@end
