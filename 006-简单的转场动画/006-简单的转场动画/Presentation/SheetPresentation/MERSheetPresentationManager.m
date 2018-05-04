//
//  MERSheetPresentationManager.m
//  MERPresentation
//
//  Created by 马遥 on 2017/11/23.
//  Copyright © 2017年 boxfish. All rights reserved.
//

#import "MERSheetPresentationManager.h"

@implementation MERSheetPresentationManager
@dynamic hideWhenClickBlankArea;

- (void)setEffectiveViewSize:(CGSize)effectiveViewSize {
    _effectiveViewSize = effectiveViewSize;
    [self setViewSize:effectiveViewSize];
}

- (MERSlidePresentationDirection)direction {
    return MERSlidePresentationDirectionBottom;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if (aSelector == @selector(animationControllerForPresentedController:presentingController:sourceController:)) {
        return NO;
    } else if (aSelector == @selector(animationControllerForDismissedController:)) {
        return NO;
    }
    return [super respondsToSelector:aSelector];
}

@end
