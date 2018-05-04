//
//  MERPresentationInteractive.m
//  MERPresentation
//
//  Created by 马遥 on 2018/2/6.
//  Copyright © 2018年 马遥. All rights reserved.
//

#import "MERPresentationInteractive.h"

@interface MERPresentationInteractive ()
@property (nonatomic, weak) UIViewController *dismissedVC;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *panGesture;
@end

@implementation MERPresentationInteractive

- (instancetype)init {
    self = [super init];
    if (self) {
        _isInteracting = NO;
    }
    return self;
}

- (void)setDismissGestureRecognizerToViewController:(UIViewController *)viewController {
    _dismissedVC = viewController;
    UIViewController *vc = viewController;
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navi = (UINavigationController *)viewController;
        vc = navi.topViewController;
    }
    if (!_panGesture) {
        _panGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        _panGesture.edges = UIRectEdgeLeft;
    }
    if (![[vc.view gestureRecognizers] containsObject:_panGesture]) {
        [vc.view addGestureRecognizer:_panGesture];
    }
}

- (void)handlePan:(UIScreenEdgePanGestureRecognizer*)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        _isInteracting = YES;
        [_dismissedVC dismissViewControllerAnimated:YES completion:nil];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        if (!_isInteracting) {
            return;
        }
        CGFloat progress = [recognizer translationInView:[UIApplication sharedApplication].keyWindow].x / (_dismissedVC.view.bounds.size.width * 1.0);
        progress = MIN(1.0, MAX(0.0, progress));
        
        [self updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        if (!_isInteracting) {
            return;
        }
        
        CGFloat progress = [recognizer translationInView:[UIApplication sharedApplication].keyWindow].x / ([UIApplication sharedApplication].keyWindow.bounds.size.width * 1.0);
        progress = MIN(1.0, MAX(0.0, progress));
        
//        if (@available(iOS 11.0,*)) {
//            self.completionSpeed = 1 - progress;
//            [self finishInteractiveTransition];
//        } else {
            CGPoint velocity = [recognizer velocityInView:[UIApplication sharedApplication].keyWindow];
            if ((progress > 0.25 && velocity.x > 0) || progress > 0.5) {
                NSLog(@"Pop完成");
                self.completionSpeed = 1;
                [self finishInteractiveTransition];
            } else {
                NSLog(@"Pop取消");
                [self updateInteractiveTransition:0.f];
                [self cancelInteractiveTransition];
            }
//        }
        _isInteracting = NO;
    }
}
@end
