//
//  BFELiveKnowledgeEntranceAvatarView.m
//  boxfish-english
//
//  Created by 马遥 on 2018/3/6.
//  Copyright © 2018年 boxfish. All rights reserved.
//

#import "BFELiveKnowledgeEntranceAvatarView.h"
#import "Masonry.h"
#import "Macro.h"
#import "BFEUICreator.h"

#pragma mark - 带如来佛祖光环的头像框 (基类)

@interface BFELiveKnowledgeEntranceAvatarView ()
@property (nonatomic, strong) UIView *largeHalo;
@property (nonatomic, strong) UIView *miniHalo;
@property (nonatomic, strong) UIImageView *avatarFrameView;
@property (nonatomic, strong) UIImageView *ribbonView;
@end

@implementation BFELiveKnowledgeEntranceAvatarView

- (instancetype)initWithType:(BFEEntranceAvatarViewType)type {
    CGRect frame = CGRectMake(0, 0, 200, 200);
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        [self createMainView];
    }
    return self;
}

- (void)createMainView {

    self.largeHalo = [[UIView alloc] init];
    self.largeHalo.backgroundColor = [UIColor clearColor];
    self.largeHalo.layer.borderColor = ColorWithAlpha(255, 255, 255, 0.15).CGColor;
    self.largeHalo.layer.borderWidth = 4.8;
    self.largeHalo.layer.shadowColor = ColorWithAlpha(0, 0, 0, 0.1).CGColor;
    self.largeHalo.layer.shadowOffset = CGSizeZero;
    self.largeHalo.layer.shadowRadius = 6;
    self.largeHalo.layer.shadowOpacity = 1;
    [self addSubview:self.largeHalo];
    [self.largeHalo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    self.largeHalo.layer.cornerRadius = self.frame.size.width / 2;

    self.miniHalo = [[UIView alloc] init];
    self.miniHalo.backgroundColor = ColorWithAlpha(255, 255, 255, 0.3);
    self.miniHalo.layer.shadowColor = ColorWithAlpha(0, 0, 0, 0.3).CGColor;
    self.miniHalo.layer.shadowOffset = CGSizeZero;
    self.miniHalo.layer.shadowRadius = 8;
    self.miniHalo.layer.shadowOpacity = 1;
    [self addSubview:self.miniHalo];
    [self.miniHalo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.height.mas_equalTo(self).multipliedBy(168/200.0);
    }];
    self.miniHalo.layer.cornerRadius = self.frame.size.width * (168/200.0) / 2;

    self.avatarFrameView = [[UIImageView alloc] init];
    self.avatarFrameView.image = [UIImage imageNamed:[self avatarFrameImageNameFromType:self.type]];
    [self addSubview:self.avatarFrameView];
    [self.avatarFrameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.height.mas_equalTo(self).multipliedBy(146/200.0);
    }];
    
    self.avatarImageView = [[UIImageView alloc] init];
    [self addSubview:self.avatarImageView];
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarImageView.clipsToBounds = YES;
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.height.mas_equalTo(self).multipliedBy(129/200.0);
    }];
    
    self.ribbonView = [[UIImageView alloc] init];
    self.ribbonView.image = [UIImage imageNamed:[self ribbonImageNameFromType:self.type]];
    [self addSubview:self.ribbonView];
    [self.ribbonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(self).multipliedBy(162/200.0);
        make.height.mas_equalTo(self.ribbonView.mas_width).multipliedBy(48/162.0);
        make.bottom.mas_equalTo(self).offset(-9);
    }];
}

// 根据类型选择头像框图案
- (NSString *)avatarFrameImageNameFromType:(BFEEntranceAvatarViewType)type {
    NSString *imageName;
    if (type == BFEEntranceAvatarViewTypeStudent) {
        imageName = @"liveKnowledgeEntranceStudentAvatarFrame";
    } else if (type == BFEEntranceAvatarViewTypeTeacher) {
        imageName = @"liveKnowledgeEntranceTeacherAvatarFrame";
    }
    return imageName;
}
// 根据类型选择缎带图案
- (NSString *)ribbonImageNameFromType:(BFEEntranceAvatarViewType)type {
    NSString *imageName;
    if (type == BFEEntranceAvatarViewTypeStudent) {
        imageName = @"liveKnowledgeEntranceStudentRibbon";
    } else if (type == BFEEntranceAvatarViewTypeTeacher) {
        imageName = @"liveKnowledgeEntranceTeacherRibbon";
    }
    return imageName;
}

- (void)hideHalo {
    CGFloat avatarFrameRadio = 146/200.0;
    CGFloat miniHaloRadio = 168/200.0;
    self.largeHalo.transform = CGAffineTransformMakeScale(avatarFrameRadio, avatarFrameRadio);
    self.miniHalo.transform = CGAffineTransformMakeScale(miniHaloRadio * avatarFrameRadio, miniHaloRadio * avatarFrameRadio);
}

- (void)showHalo:(BOOL)animated {
    if (!animated) {
        self.largeHalo.transform = CGAffineTransformIdentity;
        self.miniHalo.transform = CGAffineTransformIdentity;
    } else {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.largeHalo.transform = CGAffineTransformIdentity;
            self.miniHalo.transform = CGAffineTransformIdentity;
        } completion:nil];
    }
}

@end

#pragma mark - 学生头像框

@interface BFELiveKnowledgeEntranceStudentAvatarView ()

@property (nonatomic, strong) UILabel *nameAndCountLabel;

@end

@implementation BFELiveKnowledgeEntranceStudentAvatarView

- (instancetype)initWithStudentName:(NSString *)name breakBarrierSurplusCount:(NSUInteger)count {
    self = [super initWithType:BFEEntranceAvatarViewTypeStudent];
    if (self) {
        _name = name;
        _count = count;
        [self createLabel];
    }
    return self;
}

- (void)createLabel {
    self.nameAndCountLabel = [BFEUICreator createLabel:@" " color:GRAYCOLOR(243) font:[UIFont systemFontOfSize:17]];
    self.nameAndCountLabel.numberOfLines = 1;
    self.nameAndCountLabel.textAlignment = NSTextAlignmentCenter;
    self.nameAndCountLabel.layer.shadowColor = COLOR(0, 22, 99).CGColor;
    CGFloat shadowOffset = 1;
    self.nameAndCountLabel.layer.shadowOffset = CGSizeMake(-shadowOffset, shadowOffset);
    self.nameAndCountLabel.layer.shadowRadius = 0.5;
    self.nameAndCountLabel.layer.shadowOpacity = 1;
    
    [self.ribbonView addSubview:self.nameAndCountLabel];
    [self.nameAndCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ribbonView).offset(5);
        make.centerX.mas_equalTo(self.ribbonView);
    }];
    
    [self updateLabelText];
}

- (void)updateLabelText {
    NSString *labelText = [NSString stringWithFormat:@"%@",self.name];
    self.nameAndCountLabel.text = labelText;
}

- (void)setName:(NSString *)name {
    _name = name;
    [self updateLabelText];
}

- (void)setCount:(NSUInteger)count {
    _count = count;
    [self updateLabelText];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width / 2;
    self.avatarImageView.layer.masksToBounds = YES;
}

@end

#pragma mark - 老师头像框

@interface BFELiveKnowledgeEntranceTeacherAvatarView ()

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation BFELiveKnowledgeEntranceTeacherAvatarView

- (instancetype)initWithTeacherName:(NSString *)name {
    self = [super initWithType:BFEEntranceAvatarViewTypeTeacher];
    if (self) {
        _name = name;
        [self createLabel];
    }
    return self;
}

- (void)createLabel {
    self.nameLabel = [BFEUICreator createLabel:@" " color:GRAYCOLOR(243) font:[UIFont systemFontOfSize:17]];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.layer.shadowColor = COLOR(58, 0, 24).CGColor;
    CGFloat shadowOffset = 1;
    self.nameLabel.layer.shadowOffset = CGSizeMake(-shadowOffset, shadowOffset);
    self.nameLabel.layer.shadowRadius = 1;
    self.nameLabel.layer.shadowOpacity = 1;

    [self.ribbonView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ribbonView).offset(5);
        make.centerX.mas_equalTo(self.ribbonView);
    }];
    
    [self setName:_name];
    
    self.avatarImageView.image = [UIImage imageNamed:@"eac4b74543a98226b8ca9e398282b9014a90eba1"];
//    [self.avatarImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self).offset(8);
//        make.bottom.mas_equalTo(self).offset(-48);
//        make.width.mas_equalTo(self.avatarImageView.mas_height).multipliedBy(120/160.0);
//        make.right.mas_equalTo(self).offset(-31);
//    }];
}

- (void)setName:(NSString *)name {
    _name = name;
    self.nameLabel.text = name?:@" ";
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width / 2;
    self.avatarImageView.layer.masksToBounds = YES;
}

@end
