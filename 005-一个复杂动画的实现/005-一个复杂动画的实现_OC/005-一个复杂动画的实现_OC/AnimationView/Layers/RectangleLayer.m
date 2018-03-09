//
//  RectangleLayer.m
//  005-一个复杂动画的实现_OC
//
//  Created by 马遥 on 2018/1/23.
//  Copyright © 2018年 马遥. All rights reserved.
//

#import "RectangleLayer.h"

@interface RectangleLayer ()
@property (nonatomic, strong) UIBezierPath *rectangleFullPath;
@property (nonatomic, strong) UIColor *color;
@end

@implementation RectangleLayer

- (instancetype)init {
    self = [super init];
    if (self) {
        self.path = self.rectangleFullPath.CGPath;
        self.fillColor = [UIColor clearColor].CGColor;
        self.lineWidth = 5;
        _color = [UIColor colorWithRed:64/255.0 green:224/255.0 blue:176/255.0 alpha:1];
    }
    return self;
}

- (void)startStrokeWithColor:(UIColor *)color {
    if (color) {
        _color = color;
    }
    [self stroke];
}

- (void)stroke {
    [self addAnimation:[self strokeAnimation] forKey:nil];
}

#pragma mark - Animation

- (CABasicAnimation *)strokeAnimation {
    self.strokeColor = self.color.CGColor;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 0.4;
    return animation;
}

#pragma mark - UIBezierPath

- (UIBezierPath *)rectangleFullPath {
    if (!_rectangleFullPath) {
        CGRect bounds = [UIScreen mainScreen].bounds;
        CGFloat width = (0.866 * (90/2.0+15) + 5/2.0) * 2;
        // 左下角
        CGPoint lowerLeftPoint = CGPointMake(bounds.size.width/2 - width/2, bounds.size.height/2 + 90/2.0/2.0 + 15/2 + 5/2.0);
        // 左上角
        CGPoint topLeftPoint = CGPointMake(lowerLeftPoint.x, lowerLeftPoint.y - width);
        // 右上角
        CGPoint topRightPoint = CGPointMake(lowerLeftPoint.x + width, topLeftPoint.y);
        // 右下角
        CGPoint lowerRightPoint = CGPointMake(topRightPoint.x, lowerLeftPoint.y);

        _rectangleFullPath = [UIBezierPath bezierPath];

        [_rectangleFullPath moveToPoint:lowerLeftPoint];
        [_rectangleFullPath addLineToPoint:topLeftPoint];
        [_rectangleFullPath addLineToPoint:topRightPoint];
        [_rectangleFullPath addLineToPoint:lowerRightPoint];
        [_rectangleFullPath closePath];
    }
    return _rectangleFullPath;
}

@end
