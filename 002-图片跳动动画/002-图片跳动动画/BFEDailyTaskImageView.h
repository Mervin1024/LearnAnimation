//
//  BFEDailyTaskImageView.h
//  boxfish-english
//
//  Created by 马遥 on 2018/1/25.
//  Copyright © 2018年 boxfish. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BFEDailyTaskType) {
    BFEDailyTaskTypeStudy,
    BFEDailyTaskTypeCourse
};

@interface BFEDailyTaskImageView : UIView

- (instancetype)initWithDailyTaskType:(BFEDailyTaskType)type;
- (void)startAnimation;

@end
