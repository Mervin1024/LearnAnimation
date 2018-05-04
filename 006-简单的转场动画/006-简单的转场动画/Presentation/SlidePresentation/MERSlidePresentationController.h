//
//  MERSlidePresentationController.h
//  MERPresentation
//
//  Created by 马遥 on 2017/11/20.
//  Copyright © 2017年 boxfish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MERPresentationHeader.h"

@interface MERSlidePresentationController : UIPresentationController

@property (nonatomic, assign) CGSize viewSize;
@property (nonatomic, assign) MERSlidePresentationDirection direction;
@property (nonatomic, assign) BOOL hideWhenClickBlankArea; // default is YES
@property (nonatomic, copy) PresentationAfterDismiss dismissBlock;

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController direction:(MERSlidePresentationDirection)direction viewSize:(CGSize)viewSize;

@end
