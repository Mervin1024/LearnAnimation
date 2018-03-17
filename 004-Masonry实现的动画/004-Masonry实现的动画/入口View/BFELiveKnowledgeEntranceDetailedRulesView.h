//
//  BFELiveKnowledgeEntranceDetailedRulesView.h
//  boxfish-english
//
//  Created by 马遥 on 2018/3/7.
//  Copyright © 2018年 boxfish. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFELiveKnowledgeEntranceDetailedRulesView;
@protocol BFELiveKnowledgeDetailedRulesViewDelegate <NSObject>

- (void)detailedRulesView:(BFELiveKnowledgeEntranceDetailedRulesView *)view closeButtonDidPressed:(UIButton *)button;

@end

/**
 包含底部遮罩，因此是一个全屏View，真正的细则框View只是子View : DetailedRulesAnimationView
 默认 hidden 为 YES，调用 show: 和 hide: 方法会改变 hidden 状态.
 */
@interface BFELiveKnowledgeEntranceDetailedRulesView : UIView

@property (nonatomic, weak) id<BFELiveKnowledgeDetailedRulesViewDelegate> delegate;

- (void)show:(BOOL)animated completion:(void(^)(BOOL finished))completion;
- (void)hide:(BOOL)animated completion:(void(^)(BOOL finished))completion;

@end
