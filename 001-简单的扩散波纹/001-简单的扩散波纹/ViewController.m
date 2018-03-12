//
//  ViewController.m
//  001-简单的扩散波纹
//
//  Created by 马遥 on 2018/3/12.
//  Copyright © 2018年 马遥. All rights reserved.
//

#import "ViewController.h"
#import "RippleAnimationView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    UIView *circleA = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    circleA.layer.cornerRadius = 75;
    circleA.backgroundColor = ColorWithAlpha(255, 216, 87, 1);
    circleA.center = CGPointMake(screenSize.width / 2, 50+150);

    RippleAnimationView *viewA = [[RippleAnimationView alloc] initWithFrame:CGRectMake(0, 0, 150, 150) animationType:AnimationTypeWithBackground];
    viewA.center = circleA.center;

    [self.view addSubview:viewA];
    [self.view addSubview:circleA];

    
    UIView *circleB = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    circleB.layer.cornerRadius = 75;
    circleB.backgroundColor = ColorWithAlpha(255, 216, 87, 1);
    circleB.center = CGPointMake(screenSize.width / 2, screenSize.height - 50 - 150);
    
    RippleAnimationView *viewB = [[RippleAnimationView alloc] initWithFrame:CGRectMake(0, 0, 150, 150) animationType:AnimationTypeWithoutBackground];
    viewB.center = circleB.center;
    
    [self.view addSubview:viewB];
    [self.view addSubview:circleB];

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
