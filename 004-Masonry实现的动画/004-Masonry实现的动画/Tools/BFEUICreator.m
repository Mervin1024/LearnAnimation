//
//  BFEUICreator.m
//  007-系列转场动画01
//
//  Created by 马遥 on 2018/3/11.
//  Copyright © 2018年 马遥. All rights reserved.
//

#import "BFEUICreator.h"

@implementation BFEUICreator

+ (UILabel *)createLabel:(NSString *)content color:(UIColor *)color font:(UIFont *)font {
    CGSize size = [content sizeWithAttributes:@{NSFontAttributeName : font}];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0,0,size.width,size.height)];
    
    lab.text = content;
    lab.textColor = color;
    lab.backgroundColor = [UIColor clearColor];
    lab.font = font;
    
    return lab;
}

+ (UIButton*)createButtonWithTitle:(NSString *)title
                        titleColor:(UIColor *)titleColor
                              font:(UIFont *)font
                            target:(id)target
                            action:(SEL)action {
    CGSize size = [title sizeWithAttributes:@{ NSFontAttributeName : font }];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom]; //创建圆角矩形button
    [button setFrame:CGRectMake(0, 0, size.width+5, size.height+5)]; //设置button的frame
    [button setTitle:title forState:UIControlStateNormal]; //设置button的标题
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside]; //定义点击时的响应函数
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.backgroundColor = [UIColor clearColor];
    
    if (font) {
        button.titleLabel.font = font;
    }
    return button;

}

@end
