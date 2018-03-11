//
//  BFELiveKnowledgeEntranceAvatarView.h
//  boxfish-english
//
//  Created by 马遥 on 2018/3/6.
//  Copyright © 2018年 boxfish. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BFEEntranceAvatarViewType) {
    BFEEntranceAvatarViewTypeStudent,
    BFEEntranceAvatarViewTypeTeacher
};

#pragma mark - 带如来佛祖光环的头像框 (基类)

@interface BFELiveKnowledgeEntranceAvatarView : UIView
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, assign) BFEEntranceAvatarViewType type;

- (instancetype)initWithType:(BFEEntranceAvatarViewType)type;

- (void)hideHalo;// 缩小光环至不可见
- (void)showHalo:(BOOL)animated;// 显示光环

@end

#pragma mark - 学生头像框

@interface BFELiveKnowledgeEntranceStudentAvatarView : BFELiveKnowledgeEntranceAvatarView

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSUInteger count;

- (instancetype)initWithStudentName:(NSString *)name breakBarrierSurplusCount:(NSUInteger)count;

@end

#pragma mark - 老师头像框

@interface BFELiveKnowledgeEntranceTeacherAvatarView : BFELiveKnowledgeEntranceAvatarView

@property (nonatomic, strong) NSString *name;

- (instancetype)initWithTeacherName:(NSString *)name;

@end
