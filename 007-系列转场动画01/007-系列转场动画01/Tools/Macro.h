//
//  Macro.h
//  007-系列转场动画01
//
//  Created by 马遥 on 2018/3/11.
//  Copyright © 2018年 马遥. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define Screen_Width (CGRectGetWidth([UIScreen mainScreen].bounds))
#define Screen_Height (CGRectGetHeight([UIScreen mainScreen].bounds))

#define isiPhoneX (Screen_Width == 375 && Screen_Height == 812 ? YES : NO)

#define StatusBarIncrease (isiPhoneX ? 24 : 0)


#define COLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define ColorWithAlpha(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define RANDOM_COLOR [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1]

#define GRAYCOLOR(c) COLOR(c,c,c)


#define PingFang_R(fontSize) [UIFont systemFontOfSize:fontSize]
#define PingFang_S(fontSize) [UIFont boldSystemFontOfSize:fontSize]


#endif /* Macro_h */
