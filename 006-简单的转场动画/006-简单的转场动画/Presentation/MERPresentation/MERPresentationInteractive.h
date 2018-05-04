//
//  MERPresentationInteractive.h
//  MERPresentation
//
//  Created by 马遥 on 2018/2/6.
//  Copyright © 2018年 马遥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MERPresentationInteractive : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL isInteracting;

- (void)setDismissGestureRecognizerToViewController:(UIViewController *)viewController;

@end
