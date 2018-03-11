//
//  BFEUICreator.h
//  007-系列转场动画01
//
//  Created by 马遥 on 2018/3/11.
//  Copyright © 2018年 马遥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BFEUICreator : NSObject

+ (UILabel *)createLabel:(NSString *)content color:(UIColor *)color font:(UIFont *)font;

+ (UIButton*)createButtonWithTitle:(NSString *)title
                        titleColor:(UIColor *)titleColor
                              font:(UIFont *)font
                            target:(id)target
                            action:(SEL)action;

@end
