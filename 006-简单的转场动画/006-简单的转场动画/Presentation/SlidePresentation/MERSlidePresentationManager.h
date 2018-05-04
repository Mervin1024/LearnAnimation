//
//  MERSlidePresentationManager.h
//  MERPresentation
//
//  Created by 马遥 on 2017/11/21.
//  Copyright © 2017年 boxfish. All rights reserved.
//

#import "MERPresentationManager.h"

/**
 *  用来实现以 屏幕边缘滑入 形式呈现 ViewController 所做的管理类（自定义弹出框）
 *  使用时需要：
 *  初始化 MERSlidePresentationManager 对象，赋值 viewSize（屏幕边缘开始计算，弹出有效视图大小），direction（弹出方向，默认 bottom）
 *  设置 UIViewController.modalPresentationStyle = UIModalPresentationCustom;
 *  设置 UIViewController.transitioningDelegate = MERSlidePresentationManager 对象;
 */
@interface MERSlidePresentationManager : MERPresentationManager

@property (nonatomic, assign) CGSize viewSize;
@property (nonatomic, assign) MERSlidePresentationDirection direction; // default is bottom
@property (nonatomic, assign) BOOL hideWhenClickBlankArea; // default is YES
@property (nonatomic, copy) PresentationAfterDismiss dismissBlock;

@end
