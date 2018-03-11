//
//  BFELiveKnowledgeDetailedRulesAnimationView.m
//  boxfish-english
//
//  Created by 马遥 on 2018/3/7.
//  Copyright © 2018年 boxfish. All rights reserved.
//

#import "BFELiveKnowledgeDetailedRulesAnimationView.h"
#import "BFEUICreator.h"
#import "Masonry.h"
#import "Macro.h"

@interface BFELiveKnowledgeDetailedRulesAnimationView () <CAAnimationDelegate>

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIView *labelBackgroundView;
@property (nonatomic, strong) UIView *animationMaskView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, assign) CGRect miniRect;
@property (nonatomic, assign) CGRect largeRect;

@end

@implementation BFELiveKnowledgeDetailedRulesAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createMainView];
        [self initAnimatedFrame];
    }
    return self;
}

#pragma mark - UI

- (void)createMainView {
    self.backgroundColor = [UIColor clearColor];
    // 背景图片
    UIImage *image = [UIImage imageNamed:@"BFELiveKnowledgeDetailedRulesBackgroundImage"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(4, 4, 4, 4) resizingMode:UIImageResizingModeStretch];
    self.backgroundImageView = [[UIImageView alloc] initWithImage:image];
    self.backgroundImageView.frame = self.bounds;
    [self addSubview:self.backgroundImageView];
    // label的底部view
    self.labelBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.labelBackgroundView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.labelBackgroundView];
    // MaskView
    self.animationMaskView = [[UIView alloc] initWithFrame:self.bounds];
    self.animationMaskView.backgroundColor = GRAYCOLOR(255);
    self.labelBackgroundView.maskView = self.animationMaskView;
    // 头部标题
    self.titleLabel = [BFEUICreator createLabel:@"闯关细则" color:GRAYCOLOR(255) font:[UIFont systemFontOfSize:16]];
    [self.labelBackgroundView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.labelBackgroundView);
        make.top.mas_equalTo(self.labelBackgroundView).offset(32);
    }];
    // 内容
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.attributedText = [self contentLabelAttributedString];
    [self.labelBackgroundView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.labelBackgroundView).offset(70);
        make.left.mas_equalTo(self.labelBackgroundView).offset(32);
        make.centerX.mas_equalTo(self.labelBackgroundView);
    }];
    // 关闭按钮
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton setImage:[UIImage imageNamed:@"BFELiveKnowledgeDetailedRulesCloseButton"] forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(closeButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.labelBackgroundView addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.labelBackgroundView).offset(17);
        make.right.mas_equalTo(self.labelBackgroundView).offset(-17);
        make.width.height.mas_equalTo(10);
    }];
    
    [self hide:NO];
}

- (NSMutableAttributedString *)contentLabelAttributedString {
    CGFloat contentLabelFontSize = 14;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] init];
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"1. 实时闯关开启时间：每天18:00-23:00 & 周六日9:00-12:00 \n" attributes:@{NSFontAttributeName:PingFang_R(contentLabelFontSize)}];
    [attrStr appendAttributedString:str1];
    NSAttributedString *str_space = [[NSAttributedString alloc] initWithString:@" \n" attributes:@{NSFontAttributeName:PingFang_R(6.5)}];
    [attrStr appendAttributedString:str_space];
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"2. 开始闯关即开始连线外教进行视频交流。\n" attributes:@{NSFontAttributeName:PingFang_R(contentLabelFontSize)}];
    [attrStr appendAttributedString:str2];
    [attrStr appendAttributedString:str_space];
    NSAttributedString *str3 = [[NSAttributedString alloc] initWithString:@"3. 连线时间低于3分钟则计为3分钟；超过3分钟的部分按实际时长计算，不足1分钟计为1分钟。\n" attributes:@{NSFontAttributeName:PingFang_R(contentLabelFontSize)}];
    [attrStr appendAttributedString:str3];
    [attrStr appendAttributedString:str_space];
    NSAttributedString *str4 = [[NSAttributedString alloc] initWithString:@"4. 国际班学习规划中的“外教学习指导”，可兑换为“知识点外教强化”。1次外教学习指导＝3分钟知识点终极强化。" attributes:@{NSFontAttributeName:PingFang_R(contentLabelFontSize)}];
    [attrStr appendAttributedString:str4];
    [attrStr addAttribute:NSForegroundColorAttributeName value:GRAYCOLOR(255) range:NSMakeRange(0, attrStr.string.length)];
    
    return attrStr;

}

- (void)closeButtonDidPressed:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(detailedRulesAnimationView:closeButtonDidPressed:)]) {
        [self.delegate detailedRulesAnimationView:self closeButtonDidPressed:button];
    }
}

- (void)initAnimatedFrame {
    self.miniRect = CGRectInset(self.bounds, 0, self.bounds.size.height / 2);
    self.largeRect = self.bounds;
}

#pragma mark - Public

- (void)show:(BOOL)animated {
    if (!animated) {
        self.animationMaskView.frame = self.largeRect;
        self.backgroundImageView.frame = self.largeRect;
        return;
    }

    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.backgroundImageView.frame = self.largeRect;
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.animationMaskView.frame = self.largeRect;
    } completion:^(BOOL finished) {
        
    }];

}

- (void)hide:(BOOL)animated {
    if (!animated) {
        self.animationMaskView.frame = self.miniRect;
        self.backgroundImageView.frame = self.miniRect;
        return;
    }
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundImageView.frame = self.miniRect;
    } completion:^(BOOL finished) {
    }];
    [UIView animateWithDuration:0.24 delay:0 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.animationMaskView.frame = self.miniRect;
    } completion:^(BOOL finished) {
    }];
    
}

@end
