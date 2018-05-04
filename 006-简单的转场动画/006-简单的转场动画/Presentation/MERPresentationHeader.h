//
//  MERPresentationHeader.h
//  MERPresentation
//
//  Created by 马遥 on 2017/11/29.
//  Copyright © 2017年 boxfish. All rights reserved.
//

#ifndef MERPresentationHeader_h
#define MERPresentationHeader_h

#define MERColorWithAlpha(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define MERIsiPhoneX ([UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height == 812 ? YES : NO)
#define MERDeviceIsPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/**
 *  页面消失后的回调
 */
typedef void(^PresentationAfterDismiss)(void);

/**
 *  侧滑方向
 *
- MERSlidePresentationDirectionLeft:    由左侧滑入
- MERSlidePresentationDirectionTop:     由顶部滑入
- MERSlidePresentationDirectionRight:   由右侧滑入
- MERSlidePresentationDirectionBottom:  由底部滑入， 默认以此模式， 类似于 ActionSheet
 */
typedef NS_ENUM(NSUInteger, MERSlidePresentationDirection) {
    MERSlidePresentationDirectionLeft,
    MERSlidePresentationDirectionTop,
    MERSlidePresentationDirectionRight,
    MERSlidePresentationDirectionBottom
};

#endif /* MERPresentationHeader_h */
