//
//  ViewController.m
//  007-系列转场动画01
//
//  Created by 马遥 on 2018/3/11.
//  Copyright © 2018年 马遥. All rights reserved.
//

#import "ViewController.h"
#import "BFELiveKnowledgeEntranceView.h"

@interface ViewController ()
@property (nonatomic, strong) BFELiveKnowledgeEntranceView *entranceView;
@property (nonatomic, strong) UIButton *openButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.entranceView = [[BFELiveKnowledgeEntranceView alloc] init];
    
    self.openButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.openButton setTitle:@"开始闯关" forState:UIControlStateNormal];
    self.openButton.titleLabel.font = [UIFont systemFontOfSize:22];
    [self.openButton sizeToFit];
    [self.view addSubview:self.openButton];
    self.openButton.center = self.view.center;
    [self.openButton addTarget:self action:@selector(openButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)openButtonDidPress:(UIButton *)button {
    if ([self.view.subviews containsObject:self.entranceView]) {
        return;
    }
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.view addSubview:self.entranceView];
    [self.entranceView show:YES];
}


@end
