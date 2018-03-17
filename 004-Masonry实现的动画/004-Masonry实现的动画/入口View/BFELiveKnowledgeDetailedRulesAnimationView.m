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
    self.titleLabel = [BFEUICreator createLabel:@"经典语录" color:GRAYCOLOR(255) font:[UIFont systemFontOfSize:16]];
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
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"1. 山有木兮木有枝，心悦君兮君不知 \n" attributes:@{NSFontAttributeName:PingFang_R(contentLabelFontSize)}];
    [attrStr appendAttributedString:str1];
    NSAttributedString *str_space = [[NSAttributedString alloc] initWithString:@" \n" attributes:@{NSFontAttributeName:PingFang_R(6.5)}];
    [attrStr appendAttributedString:str_space];
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"2. 人生若只如初见，何事秋风悲画扇。\n" attributes:@{NSFontAttributeName:PingFang_R(contentLabelFontSize)}];
    [attrStr appendAttributedString:str2];
    [attrStr appendAttributedString:str_space];
    NSAttributedString *str3 = [[NSAttributedString alloc] initWithString:@"3. 十年生死两茫茫，不思量，自难忘。\n" attributes:@{NSFontAttributeName:PingFang_R(contentLabelFontSize)}];
    [attrStr appendAttributedString:str3];
    [attrStr appendAttributedString:str_space];
    NSAttributedString *str4 = [[NSAttributedString alloc] initWithString:@"4. 曾经沧海难为水，除却巫山不是云。\n" attributes:@{NSFontAttributeName:PingFang_R(contentLabelFontSize)}];
    [attrStr appendAttributedString:str4];
    [attrStr appendAttributedString:str_space];
    NSAttributedString *str5 = [[NSAttributedString alloc] initWithString:@"5. 玲珑骰子安红豆，入骨相思知不知。\n" attributes:@{NSFontAttributeName:PingFang_R(contentLabelFontSize)}];
    [attrStr appendAttributedString:str5];
    [attrStr appendAttributedString:str_space];
    NSAttributedString *str6 = [[NSAttributedString alloc] initWithString:@"6. 只愿君心似我心，定不负相思意。\n" attributes:@{NSFontAttributeName:PingFang_R(contentLabelFontSize)}];
    [attrStr appendAttributedString:str6];
    [attrStr appendAttributedString:str_space];
    NSAttributedString *str7 = [[NSAttributedString alloc] initWithString:@"7. 平生不会相思，才会相思，便害相思。\n" attributes:@{NSFontAttributeName:PingFang_R(contentLabelFontSize)}];
    [attrStr appendAttributedString:str7];

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
