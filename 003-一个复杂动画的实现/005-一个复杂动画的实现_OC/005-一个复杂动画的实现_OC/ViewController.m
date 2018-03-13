//
//  ViewController.m
//  005-一个复杂动画的实现_OC
//
//  Created by 马遥 on 2018/1/23.
//  Copyright © 2018年 马遥. All rights reserved.
//

#import "ViewController.h"
#import "AnimationView.h"

@interface ViewController ()
@property (nonatomic, strong) AnimationView *animationView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _animationView = [[AnimationView alloc] initWithFrame:self.view.bounds];
    __weak typeof(&*self) weakSelf = self;
    _animationView.animationCompleted = ^(BOOL completed) {
        NSLog(@"动画已结束 ： %@",completed?@"YES":@"NO");
        [weakSelf animationFinished];
    };
    
    [self.view addSubview:_animationView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:50];
    _titleLabel.text = @"Welcome";
    _titleLabel.textColor = [UIColor whiteColor];
    [_titleLabel sizeToFit];
    _titleLabel.center = CGPointMake(self.view.center.x, self.view.center.y - 50);
    [self.view addSubview:_titleLabel];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startAnimation:nil];
}

- (void)startAnimation:(UITapGestureRecognizer *)tap {
    [self.view.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.view removeGestureRecognizer:obj];
    }];
    _titleLabel.transform = CGAffineTransformScale(_titleLabel.transform, 0.25, 0.25);
    _titleLabel.hidden = YES;
    NSLog(@"点击=====开始动画");
    [_animationView startAnimation];
}

- (void)animationFinished {
    _titleLabel.hidden = NO;
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.titleLabel.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation:)];
        [self.view addGestureRecognizer:tap];
    }];
}


@end
