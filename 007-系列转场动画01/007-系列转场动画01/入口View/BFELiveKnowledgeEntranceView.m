//
//  BFELiveKnowledgeEntranceView.m
//  boxfish-english
//
//  Created by 马遥 on 2018/3/6.
//  Copyright © 2018年 boxfish. All rights reserved.
//

#import "BFELiveKnowledgeEntranceView.h"
#import "Macro.h"
#import "Masonry.h"
#import "BFELiveKnowledgeEntranceAvatarView.h"
#import "BFEUICreator.h"
#import "BFELiveKnowledgeEntranceDetailedRulesView.h"


static NSString *const FirstTimePressedBeginButton = @"BFELiveKnowledgeEntrancePressedBeginButton";

@interface BFELiveKnowledgeEntranceView () <BFELiveKnowledgeDetailedRulesViewDelegate>

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) BFELiveKnowledgeEntranceStudentAvatarView *userAvatarView;
@property (nonatomic, strong) BFELiveKnowledgeEntranceTeacherAvatarView *teacherAvatarView;
@property (nonatomic, strong) UIImageView *lightImageView;
@property (nonatomic, strong) UIImageView *lightningImageView;
@property (nonatomic, strong) BFELiveKnowledgeEntranceDetailedRulesView *detailedRulesView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *beginButton;
@property (nonatomic, strong) UIButton *tutoringButton;
@property (nonatomic, strong) UIButton *detailedRulesButton;

@end

@implementation BFELiveKnowledgeEntranceView

- (void)dealloc {
    NSLog(@"BFELiveKnowledgeEntranceView 已释放");
}

- (instancetype)init {
    CGRect rect = CGRectMake(0, 0, Screen_Width, Screen_Height);
    return [self initWithFrame:rect];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createMainView];
    }
    return self;
}


#pragma mark - 创建 UI

- (void)createMainView {
    // 背景
    [self createBackgroundImageView];
    [self createBlurView];
    // 顶部控件
    [self createCloseButton];
    [self createTitleImageView];
    // 两个头像框以及光效
    [self createLight];
    [self createUserAvatar];
    [self createTeacherAvatar];
    [self createLightning];
    // 隐藏的细则页面
    [self createDetailedRulesView];
    // 底部三个按钮
    [self createDetailedRulesButton];
    [self createTutoringButton];
    [self createBeginButton];
}

#pragma mark - - 背景

- (void)createBackgroundImageView {
    self.backgroundImageView = [[UIImageView alloc] init];
    [self addSubview:self.backgroundImageView];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundImageView.layer.masksToBounds = YES;
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    self.backgroundImageView.image = [UIImage imageNamed:@"courseDefault"];

}

- (void)createBlurView {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.frame = self.frame;
    effectView.backgroundColor = ColorWithAlpha(0, 0, 0, 0.2);
    [self addSubview:effectView];
    [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

#pragma mark - - 顶部控件

- (void)createCloseButton {
    self.closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.closeButton setImage:[UIImage imageNamed:@"liveKnowledgeEntranceCloseButton"] forState:UIControlStateNormal];
    self.closeButton.backgroundColor = [UIColor clearColor];
    [self.closeButton addTarget:self action:@selector(closeButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(StatusBarIncrease + 18.4);
        make.right.mas_equalTo(self).offset(-12.6);
        make.width.height.mas_equalTo(17);
    }];
}

- (void)createTitleImageView {
    UIImageView *imageView_1 = [[UIImageView alloc] init];
    imageView_1.image = [UIImage imageNamed:@"liveKnowledgeEntranceTitleImage_1"];
    [self addSubview:imageView_1];
    
    UIImageView *imageView_2 = [[UIImageView alloc] init];
    imageView_2.image = [UIImage imageNamed:@"liveKnowledgeEntranceTitleImage_2"];
    [self addSubview:imageView_2];
    
    [imageView_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(45);
        make.left.mas_equalTo(self).offset(26);
        make.height.mas_equalTo(imageView_1.mas_width).multipliedBy(136.0/363.0);
    }];
    [imageView_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageView_1);
        make.top.mas_equalTo(imageView_1).offset(15);
        make.width.mas_equalTo(254);
        make.height.mas_equalTo(41);
    }];
}

#pragma mark - - 两个头像框以及光效

- (void)createLight {
    self.lightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BFELiveKnowledgeEntranceLight"]];
    [self addSubview:self.lightImageView];
    [self.lightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)) {
            make.width.mas_equalTo(601.4);
            make.height.mas_equalTo(574.2);
            make.left.mas_equalTo(self).offset(109.7);
        } else {
            make.width.mas_equalTo(self);
            make.height.mas_equalTo(self.lightImageView.mas_width).multipliedBy(360/414.0);
            make.centerX.mas_equalTo(self);
        }
        make.top.mas_equalTo(self).offset(216);
    }];
    
}

- (void)createUserAvatar {
    // 用户名称
    NSString *avaterName = @"霄淼";
    // 剩余点评次数
    
    self.userAvatarView = [[BFELiveKnowledgeEntranceStudentAvatarView alloc] initWithStudentName:avaterName breakBarrierSurplusCount:0];
    [self addSubview:self.userAvatarView];
    [self.userAvatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(200);
        make.left.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self).offset(249);
    }];
    
    UIImage *avatar = [UIImage imageNamed:@"IMG_0903"];
    self.userAvatarView.avatarImageView.image = avatar;
}

- (void)createTeacherAvatar {
    self.teacherAvatarView = [[BFELiveKnowledgeEntranceTeacherAvatarView alloc] initWithTeacherName:@"外教"];
    [self addSubview:self.teacherAvatarView];
    [self.teacherAvatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(200);
        make.right.mas_equalTo(self).offset(16);
        make.top.mas_equalTo(self.userAvatarView).offset(91);
    }];
}

- (void)createLightning {
    self.lightningImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BFELiveKnowledgeEntranceLightning"]];
    [self addSubview:self.lightningImageView];
    [self.lightningImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.lightImageView).offset(4);
        make.centerY.mas_equalTo(self.lightImageView).offset(10);
        make.height.mas_equalTo(134);
        make.width.mas_equalTo(self.lightningImageView.mas_height).multipliedBy(98/134.0);
    }];

}

#pragma mark - - 隐藏的细则页面

- (void)createDetailedRulesView {
    self.detailedRulesView = [[BFELiveKnowledgeEntranceDetailedRulesView alloc] init];
    self.detailedRulesView.delegate = self;
    [self addSubview:self.detailedRulesView];
}

#pragma mark - - 底部三个按钮

- (void)createDetailedRulesButton {
    self.detailedRulesButton = [BFEUICreator createButtonWithTitle:@"闯关细则" titleColor:GRAYCOLOR(255) font:PingFang_S(12) target:self action:@selector(detailedRulesButtonDidPressed:)];
    [self addSubview:self.detailedRulesButton];
    [self.detailedRulesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-14);
        make.size.mas_equalTo(self.detailedRulesButton.bounds.size);
    }];
}

- (void)createTutoringButton {
    self.tutoringButton = [BFEUICreator createButtonWithTitle:@"老师辅导" titleColor:COLOR(255, 224, 93) font:PingFang_S(14) target:self action:@selector(tutoringButtonDidPressed:)];
    [self addSubview:self.tutoringButton];
    [self.tutoringButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-10);
        make.bottom.mas_equalTo(self.detailedRulesButton).offset(2);
        make.size.mas_equalTo(self.tutoringButton.bounds.size);
    }];
    self.tutoringButton.layer.shadowColor = GRAYCOLOR(0).CGColor;
    self.tutoringButton.layer.shadowOffset = CGSizeZero;
    self.tutoringButton.layer.shadowRadius = 4;
    self.tutoringButton.layer.shadowOpacity = 0.3f;
}

- (void)createBeginButton {
    self.beginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.beginButton setBackgroundImage:[UIImage imageNamed:@"BFELiveKnowledgeEntranceBeginButton"] forState:UIControlStateNormal];
    [self.beginButton addTarget:self action:@selector(beginButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.beginButton setTitle:@"开始闯关" forState:UIControlStateNormal];
    self.beginButton.titleLabel.font = PingFang_S(23);
    [self.beginButton setTitleColor:COLOR(143, 75, 10) forState:UIControlStateNormal];
    self.beginButton.tintColor = [UIColor clearColor];
    self.beginButton.titleEdgeInsets = UIEdgeInsetsMake(-3, 0, 3, 0);
    [self addSubview:self.beginButton];
    [self.beginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self.detailedRulesButton).offset(-29);
        make.width.mas_equalTo(184);
        make.height.mas_equalTo(70);
    }];
}

#pragma mark - 右上角 关闭 按钮

- (void)closeButtonDidPressed:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(entranceView:closeButtonDidPressed:)]) {
        [self.delegate entranceView:self closeButtonDidPressed:button];
    }
    [self removeFromSuperview];
}

#pragma mark - 开始闯关 按钮

- (void)beginButtonDidPressed:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(entranceView:beginButtonDidPressed:)]) {
        [self.delegate entranceView:self beginButtonDidPressed:button];
    }
}

#pragma mark - 老师辅导 按钮

- (void)tutoringButtonDidPressed:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(entranceView:tutoringButtonDidPressed:)]) {
        [self.delegate entranceView:self tutoringButtonDidPressed:button];
    }
}

#pragma mark - 闯关细则 按钮

- (void)detailedRulesButtonDidPressed:(UIButton *)button {
    self.beginButton.enabled = NO;
    [self.detailedRulesView show:YES completion:^(BOOL finished) {
        self.beginButton.enabled = YES;
    }];
    self.detailedRulesButton.hidden = YES;
}

#pragma mark - BFELiveKnowledgeDetailedRulesViewDelegate

- (void)detailedRulesView:(BFELiveKnowledgeEntranceDetailedRulesView *)view closeButtonDidPressed:(UIButton *)button {
    self.beginButton.enabled = NO;
    [self.detailedRulesView hide:YES completion:^(BOOL finished) {
        self.detailedRulesButton.hidden = NO;
        self.beginButton.enabled = YES;
    }];
}

#pragma mark - Override

- (void)removeFromSuperview {
    [super removeFromSuperview];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

#pragma mark - Getter

- (BOOL)detailedRulesIsOpen {
    return self.detailedRulesButton.hidden;
}

@end
