//
//  RippleAnimationView.h
//  boxfish-english
//
//  Created by mervin on 2016/11/4.
//  Copyright © 2016年 boxfish. All rights reserved.
//

#define ColorWithAlpha(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AnimationType) {
    AnimationTypeWithBackground,
    AnimationTypeWithoutBackground
};

@interface RippleAnimationView : UIView

/**
 设置扩散倍数。默认1.423倍
 */
@property (nonatomic, assign) CGFloat multiple;

- (instancetype)initWithFrame:(CGRect)frame animationType:(AnimationType)animationType;

@end
