//
//  ViewController.m
//  006-图片跳动动画
//
//  Created by 马遥 on 2018/1/25.
//  Copyright © 2018年 马遥. All rights reserved.
//

#import "ViewController.h"
#import "BFEDailyTaskImageView.h"

@interface ViewController ()
@property (nonatomic, strong) BFEDailyTaskImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView = [[BFEDailyTaskImageView alloc] initWithDailyTaskType:BFEDailyTaskTypeCourse];
    self.imageView.frame = CGRectMake(0, 0, 80, 80);
    self.imageView.center = self.view.center;
    [self.view addSubview:self.imageView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.imageView startAnimation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
