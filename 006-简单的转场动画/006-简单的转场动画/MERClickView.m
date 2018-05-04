//
//  MERClickView.m
//  MERPresentation_Example
//
//  Created by 马遥 on 2018/4/19.
//  Copyright © 2018年 马遥. All rights reserved.
//

#import "MERClickView.h"

@implementation MERClickView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    self.lastClickPoint = point;
    return nil;
}


@end
