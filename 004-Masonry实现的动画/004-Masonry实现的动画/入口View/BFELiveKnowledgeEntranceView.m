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

typedef NS_ENUM(NSUInteger, EntranceViewConstraintsState) {
    EntranceViewConstraintsStateWillAppear,
    EntranceViewConstraintsStateDidAppear,
    EntranceViewConstraintsStateDidDisappear,
};


static NSString *const FirstTimePressedBeginButton = @"BFELiveKnowledgeEntrancePressedBeginButton";

@interface BFELiveKnowledgeEntranceView () <BFELiveKnowledgeDetailedRulesViewDelegate>

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIVisualEffectView *effectView;

@property (nonatomic, strong) UIImageView *titleImageView_1;
@property (nonatomic, strong) UIImageView *titleImageView_2;

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
    
    [self show:NO];
}

#pragma mark - - 背景

- (void)createBackgroundImageView {
    self.backgroundImageView = [[UIImageView alloc] init];
    [self addSubview:self.backgroundImageView];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundImageView.clipsToBounds = YES;
    self.backgroundImageView.image = [UIImage imageNamed:@"courseDefault"];

}

- (void)createBlurView {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    self.effectView.frame = self.frame;
    self.effectView.backgroundColor = ColorWithAlpha(0, 0, 0, 0.2);
    [self addSubview:self.effectView];
}

#pragma mark - - 顶部控件

- (void)createCloseButton {
    self.closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.closeButton setImage:[UIImage imageNamed:@"liveKnowledgeEntranceCloseButton"] forState:UIControlStateNormal];
    self.closeButton.backgroundColor = [UIColor clearColor];
    [self.closeButton addTarget:self action:@selector(closeButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeButton];
}

- (void)createTitleImageView {
    self.titleImageView_2 = [[UIImageView alloc] init];
    self.titleImageView_2.image = [UIImage imageNamed:@"liveKnowledgeEntranceTitleImage_2"];
    [self addSubview:self.titleImageView_2];

    self.titleImageView_1 = [[UIImageView alloc] init];
    self.titleImageView_1.image = [UIImage imageNamed:@"liveKnowledgeEntranceTitleImage_1"];
    [self addSubview:self.titleImageView_1];
    
    
}

#pragma mark - - 两个头像框以及光效

- (void)createLight {
    self.lightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BFELiveKnowledgeEntranceLight"]];
    [self addSubview:self.lightImageView];
    
}

- (void)createUserAvatar {
    // 用户名称
    NSString *avaterName = @"比利王";
    
    self.userAvatarView = [[BFELiveKnowledgeEntranceStudentAvatarView alloc] initWithStudentName:avaterName breakBarrierSurplusCount:0];
    [self addSubview:self.userAvatarView];
    
    UIImage *avatar = [UIImage imageNamed:@"78310a55b319ebc4acda9dc68126cffc1f1716ca"];
    self.userAvatarView.avatarImageView.image = avatar;
}

- (void)createTeacherAvatar {
    self.teacherAvatarView = [[BFELiveKnowledgeEntranceTeacherAvatarView alloc] initWithTeacherName:@"Van漾"];
    [self addSubview:self.teacherAvatarView];
}

- (void)createLightning {
    self.lightningImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BFELiveKnowledgeEntranceLightning"]];
    [self addSubview:self.lightningImageView];

}

#pragma mark - - 隐藏的细则页面

- (void)createDetailedRulesView {
    self.detailedRulesView = [[BFELiveKnowledgeEntranceDetailedRulesView alloc] init];
    self.detailedRulesView.delegate = self;
    [self addSubview:self.detailedRulesView];
}

#pragma mark - - 底部三个按钮

- (void)createDetailedRulesButton {
    self.detailedRulesButton = [BFEUICreator createButtonWithTitle:@"旁观者语录" titleColor:GRAYCOLOR(255) font:PingFang_S(12) target:self action:@selector(detailedRulesButtonDidPressed:)];
    [self addSubview:self.detailedRulesButton];
}

- (void)createTutoringButton {
    self.tutoringButton = [BFEUICreator createButtonWithTitle:@"我要参与" titleColor:COLOR(255, 224, 93) font:PingFang_S(14) target:self action:@selector(tutoringButtonDidPressed:)];
    [self addSubview:self.tutoringButton];
    self.tutoringButton.layer.shadowColor = GRAYCOLOR(0).CGColor;
    self.tutoringButton.layer.shadowOffset = CGSizeZero;
    self.tutoringButton.layer.shadowRadius = 4;
    self.tutoringButton.layer.shadowOpacity = 0.3f;
}

- (void)createBeginButton {
    self.beginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.beginButton setBackgroundImage:[UIImage imageNamed:@"BFELiveKnowledgeEntranceBeginButton"] forState:UIControlStateNormal];
    [self.beginButton addTarget:self action:@selector(beginButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.beginButton setTitle:@"开始♂摔跤" forState:UIControlStateNormal];
    self.beginButton.titleLabel.font = PingFang_S(23);
    [self.beginButton setTitleColor:COLOR(143, 75, 10) forState:UIControlStateNormal];
    self.beginButton.tintColor = [UIColor clearColor];
    self.beginButton.titleEdgeInsets = UIEdgeInsetsMake(-3, 0, 3, 0);
    [self addSubview:self.beginButton];
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

#pragma mark - 显现动画

@implementation BFELiveKnowledgeEntranceView (AppearAnimation)

- (void)show:(BOOL)animated {
    if (animated) {
        [self updateConstraintsWhenAnimationWillBegin];
        [self layoutIfNeeded];
        self.closeButton.enabled = NO;
        [self startAppearAnimationCompleted:^(BOOL finished) {
            self.closeButton.enabled = YES;
        }];
    } else {
        [self updateConstraintsWhenAnimationDidEnd];
        self.closeButton.enabled = YES;
    }
}


/**
 初始化动画开始前的控件位置（控件在屏幕外等等）
 */
- (void)updateConstraintsWhenAnimationWillBegin {
    [self.backgroundImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self.effectView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self.closeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(StatusBarIncrease + 18.4);
        make.right.mas_equalTo(self).offset(-12.6);
        make.width.height.mas_equalTo(17);
    }];
    [self.titleImageView_1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_top).offset(-45);
        make.left.mas_equalTo(self).offset(26);
        make.height.mas_equalTo(self.titleImageView_1.mas_width).multipliedBy(136.0/363.0);
    }];
    [self.titleImageView_2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.titleImageView_1);
        make.top.mas_equalTo(self.titleImageView_1).offset(15);
        make.width.mas_equalTo(254*(166/266.0));
        make.height.mas_equalTo(41*(25/35.0));
    }];
    [self.lightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
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
    self.lightImageView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    self.lightImageView.alpha = 0;
    [self.userAvatarView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(200);
        make.right.mas_equalTo(self.mas_left).offset(-71);
        make.top.mas_equalTo(self).offset(249);
    }];
    [self.userAvatarView hideHalo];
    [self.teacherAvatarView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(200);
        make.left.mas_equalTo(self.mas_right).offset(71);
        make.top.mas_equalTo(self.userAvatarView).offset(91);
    }];
    [self.teacherAvatarView hideHalo];
    [self.lightningImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.lightImageView).offset(4);
        make.centerY.mas_equalTo(self.lightImageView).offset(10);
        make.height.mas_equalTo(134);
        make.width.mas_equalTo(self.lightningImageView.mas_height).multipliedBy(98/134.0);
    }];
    self.lightningImageView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    self.lightningImageView.alpha = 0;
    [self.detailedRulesButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-14);
        make.size.mas_equalTo(self.detailedRulesButton.bounds.size);
    }];
    self.detailedRulesButton.alpha = 0;
    [self.tutoringButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-10);
        make.bottom.mas_equalTo(self.detailedRulesButton).offset(2);
        make.size.mas_equalTo(self.tutoringButton.bounds.size);
    }];
    self.tutoringButton.alpha = 0;
    [self.beginButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self.detailedRulesButton).offset(-29);
        make.width.mas_equalTo(184);
        make.height.mas_equalTo(70);
    }];
    self.beginButton.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.beginButton.alpha = 0;

}
/**
 执行动画--用动画形式逐个改变控件位置
 */
- (void)startAppearAnimationCompleted:(void(^)(BOOL finished))completed {
    NSTimeInterval initWiatingTime = 0.8;
    
    [UIView animateWithDuration:0.25 delay:initWiatingTime usingSpringWithDamping:0.7 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.titleImageView_1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(45);
            make.left.mas_equalTo(self).offset(26);
            make.height.mas_equalTo(self.titleImageView_1.mas_width).multipliedBy(136.0/363.0);
        }];
        [self layoutIfNeeded];
    } completion:nil];
    [UIView animateWithDuration:0.1 delay:initWiatingTime+0.1 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.titleImageView_2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.titleImageView_1);
            make.top.mas_equalTo(self.titleImageView_1).offset(15);
            make.width.mas_equalTo(254);
            make.height.mas_equalTo(41);
        }];
        [self layoutIfNeeded];
    } completion:nil];
    [UIView animateWithDuration:0.25 delay:initWiatingTime+0.45 usingSpringWithDamping:0.85 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.userAvatarView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(200);
            make.left.mas_equalTo(self).offset(-10);
            make.top.mas_equalTo(self).offset(249);
        }];
        [self.teacherAvatarView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(200);
            make.right.mas_equalTo(self).offset(16);
            make.top.mas_equalTo(self.userAvatarView).offset(91);
        }];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.userAvatarView showHalo:YES];
        [self.teacherAvatarView showHalo:YES];
    }];
    [UIView animateWithDuration:0.25 delay:initWiatingTime+1.1 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.lightningImageView.transform = CGAffineTransformIdentity;
        self.lightningImageView.alpha = 1;
    } completion:nil];
    [UIView animateWithDuration:0.1 delay:initWiatingTime+1.5 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.lightImageView.alpha = 1;
        self.tutoringButton.alpha = 1;
        self.detailedRulesButton.alpha = 1;
        self.beginButton.alpha = 1;
    } completion:nil];
    [UIView animateWithDuration:0.25 delay:initWiatingTime+1.5 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.beginButton.transform = CGAffineTransformIdentity;
    } completion:nil];
    [UIView animateWithDuration:1.6 delay:initWiatingTime+1.5 usingSpringWithDamping:0.5 initialSpringVelocity:1.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.lightImageView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        NSLog(@"动画结束");
        if (completed) {
            completed(finished);
        }
    }];
}
/**
 不采用动画时使用，直接显示为最终位置
 */
- (void)updateConstraintsWhenAnimationDidEnd {
    
    [self.backgroundImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self.effectView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self.closeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(StatusBarIncrease + 18.4);
        make.right.mas_equalTo(self).offset(-12.6);
        make.width.height.mas_equalTo(17);
    }];
    [self.titleImageView_1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(45);
        make.left.mas_equalTo(self).offset(26);
        make.height.mas_equalTo(self.titleImageView_1.mas_width).multipliedBy(136.0/363.0);
    }];
    [self.titleImageView_2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.titleImageView_1);
        make.top.mas_equalTo(self.titleImageView_1).offset(15);
        make.width.mas_equalTo(254);
        make.height.mas_equalTo(41);
    }];
    [self.lightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
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
    [self.userAvatarView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(200);
        make.left.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self).offset(249);
    }];
    [self.userAvatarView showHalo:NO];
    [self.teacherAvatarView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(200);
        make.right.mas_equalTo(self).offset(16);
        make.top.mas_equalTo(self.userAvatarView).offset(91);
    }];
    [self.teacherAvatarView showHalo:NO];
    [self.lightningImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.lightImageView).offset(4);
        make.centerY.mas_equalTo(self.lightImageView).offset(10);
        make.height.mas_equalTo(134);
        make.width.mas_equalTo(self.lightningImageView.mas_height).multipliedBy(98/134.0);
    }];
    [self.detailedRulesButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-14);
        make.size.mas_equalTo(self.detailedRulesButton.bounds.size);
    }];
    [self.tutoringButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-10);
        make.bottom.mas_equalTo(self.detailedRulesButton).offset(2);
        make.size.mas_equalTo(self.tutoringButton.bounds.size);
    }];
    [self.beginButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self.detailedRulesButton).offset(-29);
        make.width.mas_equalTo(184);
        make.height.mas_equalTo(70);
    }];
}

@end

#pragma mark - 显现动画

@implementation BFELiveKnowledgeEntranceView (BeginConfirm)

- (void)hideWhenPresent {
    
}

@end
