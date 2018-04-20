//
//  MERSecondViewController.m
//  006-简单的转场动画
//
//  Created by 马遥 on 2018/4/20.
//  Copyright © 2018年 马遥. All rights reserved.
//

#import "MERSecondViewController.h"

@interface MERSecondViewController ()
@property (nonatomic, strong) UIButton *registerButton;
@end

@implementation MERSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"开始注册";
    
    _registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_registerButton setTitle:@"点击注册" forState:UIControlStateNormal];
    [_registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_registerButton setBackgroundColor:[UIColor colorWithRed:255/255.0 green:196/255.0 blue:0/255.0 alpha:1]];
    _registerButton.titleLabel.font = [UIFont systemFontOfSize:21];
    [_registerButton sizeToFit];
    _registerButton.center = self.view.center;
    [_registerButton addTarget:self action:@selector(registerButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerButton];
}

- (void)registerButtonDidPressed:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
