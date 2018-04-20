//
//  ViewController.m
//  006-简单的转场动画
//
//  Created by 马遥 on 2018/4/19.
//  Copyright © 2018年 马遥. All rights reserved.
//

#import "ViewController.h"
#import "MERSecondViewController.h"
#import "UIViewController+BFEPresentation.h"

@interface ViewController ()
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"7230938E0506696BA96A9E20A1887A03"];
    self.view.layer.contents = (id)image.CGImage;
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    MERSecondViewController *secondVC = [[MERSecondViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:secondVC];
    
    [self presentRegisterGuideViewController:navi animated:NO completion:nil];

}


@end
