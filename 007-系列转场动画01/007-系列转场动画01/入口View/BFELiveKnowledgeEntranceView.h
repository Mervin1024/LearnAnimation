//
//  BFELiveKnowledgeEntranceView.h
//  boxfish-english
//
//  *******************************************
//
//  外教终极强化的入口页面
//  全屏展示时需要隐藏顶部状态栏： [[UIApplication sharedApplication] setStatusBarHidden:YES];
//
//  *******************************************
//
//  Created by 马遥 on 2018/3/6.
//  Copyright © 2018年 boxfish. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFELiveKnowledgeEntranceView;
@protocol BFELiveKnowledgeEntranceViewDelegate <NSObject>

/**
 开始闯关 按钮，点击事件
 
 ps:（用户第一次点击会打开 闯关细则 ，此时不走该代理方法，因此代理方不需要处理首次点击情况）
 */
@optional
- (void)entranceView:(BFELiveKnowledgeEntranceView *)entranceView beginButtonDidPressed:(UIButton *)beginButton;
/**
 关闭 按钮，点击事件
 */
- (void)entranceView:(BFELiveKnowledgeEntranceView *)entranceView closeButtonDidPressed:(UIButton *)closeButton;

/**
 老师辅导 按钮，点击事件
 */
- (void)entranceView:(BFELiveKnowledgeEntranceView *)entranceView tutoringButtonDidPressed:(UIButton *)tutoringButton;
@end

@interface BFELiveKnowledgeEntranceView : UIView

@property (nonatomic, weak) id<BFELiveKnowledgeEntranceViewDelegate> delegate;

@property (nonatomic, readonly, assign) BOOL detailedRulesIsOpen;

@end


@interface BFELiveKnowledgeEntranceView (AppearAnimation)


- (void)show:(BOOL)animated;

@end

@interface BFELiveKnowledgeEntranceView (BeginConfirm)

- (void)hideWhenPresent;

@end
