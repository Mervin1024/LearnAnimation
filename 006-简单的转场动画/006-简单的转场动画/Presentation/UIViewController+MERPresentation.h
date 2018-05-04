//
//  UIViewController+MERPresentation.h
//  MERPresentation
//
//  Created by 马遥 on 2017/11/23.
//  Copyright © 2017年 boxfish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MERPresentationHeader.h"

@interface UIViewController (MERPresentation)


/**
 自定义转场的 ViewControllerToPresent 需要声明 View 的有效 Size，默认为屏幕大小
 */
@property (nonatomic, assign) CGSize mer_viewSize;

/**
 *  以 ActionSheet 的样式 present 出VC的视图
 *
 *  @param viewControllerToPresent 被弹出的试图管理器
 *  @param hideWhenClickBlankArea 是否点击空白处消失，默认为YES
 *  @param flag 是否动画
 *  @param completion 完成回调
 *  @param afterDismiss VC在dismiss后的回调
 */
- (void)presentActionSheetViewController:(UIViewController *)viewControllerToPresent
                  hideWhenClickBlankArea:(BOOL)hideWhenClickBlankArea
                                animated:(BOOL)flag
                              completion:(void (^)(void))completion
                            afterDismiss:(PresentationAfterDismiss)afterDismiss;

- (void)presentActionSheetViewController:(UIViewController *)viewControllerToPresent
                                animated:(BOOL)flag
                              completion:(void (^)(void))completion
                            afterDismiss:(PresentationAfterDismiss)afterDismiss;

- (void)presentActionSheetViewController:(UIViewController *)viewControllerToPresent
                                animated:(BOOL)flag
                              completion:(void (^)(void))completion;

/**
 *  以 屏幕侧边滑入 的样式 present 出VC的视图
 *
 *  @param viewControllerToPresent 被弹出的试图管理器
 *  @param direction 从屏幕哪侧滑入
 *  @param flag 是否动画
 *  @param completion 完成回调
 */

- (void)presentSliderViewController:(UIViewController *)viewControllerToPresent
                          direction:(MERSlidePresentationDirection)direction
                           animated:(BOOL)flag
                         completion:(void (^)(void))completion;

/**
 *  以 渐入渐出 的样式 present 出VC的视图
 *
 *  @param viewControllerToPresent 被弹出的试图管理器
 *  @param flag 是否动画
 *  @param completion 完成回调
 */
- (void)presentFadePatternViewController:(UIViewController *)viewControllerToPresent
                                animated:(BOOL)flag
                              completion:(void (^)(void))completion;

/**
 *  从一个点扩散至全屏的方式 present 出VC的视图
 *
 *  @param viewControllerToPresent 被弹出的试图管理器
 *  @param startPoint 动画扩散点坐标
 *  @param flag 是否动画
 *  @param completion 完成回调
 */
- (void)presentDiffuseViewController:(UIViewController *)viewControllerToPresent
                          startPoint:(CGPoint)startPoint
                            animated:(BOOL)flag
                          completion:(void (^)(void))completion;

@end

