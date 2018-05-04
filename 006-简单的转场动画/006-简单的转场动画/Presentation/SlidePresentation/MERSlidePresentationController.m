//
//  MERSlidePresentationController.m
//  MERPresentation
//
//  Created by 马遥 on 2017/11/20.
//  Copyright © 2017年 boxfish. All rights reserved.
//

#import "MERSlidePresentationController.h"
#import "MERPresentationHeader.h"

@interface MERSlidePresentationController ()
@property (nonatomic, strong) UIView *dimmingView;
@end

@implementation MERSlidePresentationController

#pragma mark - Properties

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController direction:(MERSlidePresentationDirection)direction viewSize:(CGSize)viewSize {
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        _viewSize = viewSize;
        _direction = direction;
        _hideWhenClickBlankArea = YES;
        [self setupDimmingView];
    }
    return self;
}

- (void)setupDimmingView {
    _dimmingView = [[UIView alloc] init];
    _dimmingView.backgroundColor = MERColorWithAlpha(0, 0, 0, 0.4);
    _dimmingView.alpha = 0;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [_dimmingView addGestureRecognizer:tap];
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    if (!self.hideWhenClickBlankArea) {
        return;
    }
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Override

- (void)presentationTransitionWillBegin {
    [self.containerView insertSubview:self.dimmingView atIndex:0];
    self.dimmingView.frame = self.containerView.bounds;
    id <UIViewControllerTransitionCoordinator> coordinator = self.presentedViewController.transitionCoordinator;
    if (coordinator) {
        [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            self.dimmingView.alpha = 1;
        } completion:nil];
    } else {
        self.dimmingView.alpha = 1;
    }
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    if (!completed) {
        [self.dimmingView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin {
    id <UIViewControllerTransitionCoordinator> coordinator = self.presentedViewController.transitionCoordinator;
    if (coordinator) {
        [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            self.dimmingView.alpha = 0;
        } completion:nil];
    } else {
        self.dimmingView.alpha = 0;
    }
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
        [self.dimmingView removeFromSuperview];
        if (self.dismissBlock) {
            self.dismissBlock();
        }
    }
}

- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
    return self.viewSize;
}

- (CGRect)frameOfPresentedViewInContainerView {
    CGRect frame = CGRectZero;
    frame.size = [self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:self.containerView.bounds.size];
    switch (self.direction) {
        case MERSlidePresentationDirectionRight: {
            frame.origin.x = CGRectGetWidth(self.containerView.frame) - frame.size.width;
            frame.origin.y = (CGRectGetHeight(self.containerView.frame) - frame.size.height) / 2.f;
        }
            break;
            
        case MERSlidePresentationDirectionBottom: {
            CGFloat bottomMargin = MERIsiPhoneX ? 32.f : (MERDeviceIsPad ? 12.f : 10.f) ;
            frame.origin.y = CGRectGetHeight(self.containerView.frame) - frame.size.height - bottomMargin;
            frame.origin.x = (CGRectGetWidth(self.containerView.frame) - frame.size.width) / 2.f;
        }
            break;
            
        case MERSlidePresentationDirectionLeft: {
            frame.origin.x = 0;
            frame.origin.y = (CGRectGetHeight(self.containerView.frame) - frame.size.height) / 2.f;
        }
            break;
            
        case MERSlidePresentationDirectionTop: {
            frame.origin.y = 0;
            frame.origin.x = (CGRectGetWidth(self.containerView.frame) - frame.size.width) / 2.f;
        }
            break;
    }
    return frame;
}

@end
