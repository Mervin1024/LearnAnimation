//
//  MERSheetPresentationManager.h
//  MERPresentation
//
//  Created by 马遥 on 2017/11/23.
//  Copyright © 2017年 boxfish. All rights reserved.
//

#import "MERSlidePresentationManager.h"
/**
 *  用来实现以 ActionSheet 形式呈现 ViewController 所做的管理类（自定义弹出框）
 *  使用时需要：
 *  初始化 MERSheetPresentationManager 对象，赋值 effectiveViewSize（最小有效视图Size）
 *  注：此属性不同于父类的 viewSize，以 ActionSheet 最下方按钮的 bottom 为底，计算最小有效视图。这么做的原因是 iPhone X 屏幕下弹出 ActionSheet 的底部间距不一样
 *
 *
 *  设置 UIViewController.modalPresentationStyle = UIModalPresentationCustom;
 *  设置 UIViewController.transitioningDelegate = MERSheetPresentationManager 对象;
 */


@interface MERSheetPresentationManager : MERSlidePresentationManager
@property (nonatomic, assign) CGSize effectiveViewSize;
@property (nonatomic, assign) BOOL hideWhenClickBlankArea; // default is YES
@end
