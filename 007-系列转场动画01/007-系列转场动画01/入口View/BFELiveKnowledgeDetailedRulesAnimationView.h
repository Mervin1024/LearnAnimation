//
//  BFELiveKnowledgeDetailedRulesAnimationView.h
//  boxfish-english
//
//  Created by 马遥 on 2018/3/7.
//  Copyright © 2018年 boxfish. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFELiveKnowledgeDetailedRulesAnimationView;
@protocol BFEDetailedRulesAnimationViewDelegate <NSObject>

- (void)detailedRulesAnimationView:(BFELiveKnowledgeDetailedRulesAnimationView *)view closeButtonDidPressed:(UIButton *)button;

@end

@interface BFELiveKnowledgeDetailedRulesAnimationView : UIView

@property (nonatomic, weak) id<BFEDetailedRulesAnimationViewDelegate> delegate;
/**
 请务必用此方法初始化，一开始确定frame能很容易实现内部的计算，所以只依赖了这个值来实现动画
 */
- (instancetype)initWithFrame:(CGRect)frame;

- (void)show:(BOOL)animated;
- (void)hide:(BOOL)animated;

@end
