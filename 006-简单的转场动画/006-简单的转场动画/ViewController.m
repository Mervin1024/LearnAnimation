//
//  ViewController.m
//  006-简单的转场动画
//
//  Created by 马遥 on 2018/4/19.
//  Copyright © 2018年 马遥. All rights reserved.
//

#import "ViewController.h"
#import "MERPresentation.h"
#import "MERClickView.h"
#import "MERSecondViewController.h"

typedef NS_ENUM(NSUInteger, MERPresentationAnimationType) {
    MERPresentationAnimationTypeActionSheet = 0,
    MERPresentationAnimationTypeSlider,
    MERPresentationAnimationTypeFade,
    MERPresentationAnimationTypeDiffuse,
    MERPresentationAnimationTypeCount
};

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MERClickView *clickView;
@end

static NSString *const MERReuseIdentifier = @"MERViewControllerReuseIdentifier";

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"简单的自定义转场";
    [self configureTableView];
    _clickView = [[MERClickView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_clickView];
}

- (void)configureTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MERReuseIdentifier];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return MERPresentationAnimationTypeCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MERReuseIdentifier forIndexPath:indexPath];
    NSString *cellTitle;
    if (indexPath.row == MERPresentationAnimationTypeActionSheet) {
        cellTitle = @"Action Sheet";
    } else if (indexPath.row == MERPresentationAnimationTypeSlider) {
        cellTitle = @"侧边滑入";
    } else if (indexPath.row == MERPresentationAnimationTypeFade) {
        cellTitle = @"侧边转场(支持侧滑返回)";
    } else if (indexPath.row == MERPresentationAnimationTypeDiffuse) {
        cellTitle = @"点扩散(支持侧滑返回)";
    }
    cell.textLabel.text = cellTitle;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MERSecondViewController *controller = [[MERSecondViewController alloc] init];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Action Sheet
    if (indexPath.row == MERPresentationAnimationTypeActionSheet) {
        controller.mer_viewSize = CGSizeMake(screenWidth / 6.0 * 5, screenHeight / 5.0 * 2);
        [self presentActionSheetViewController:controller animated:YES completion:nil];
        
        // 侧边滑入
    } else if (indexPath.row == MERPresentationAnimationTypeSlider) {
        controller.mer_viewSize = CGSizeMake(screenWidth / 3.0 * 2, screenHeight);
        [self presentSliderViewController:controller direction:MERSlidePresentationDirectionLeft animated:YES completion:nil];
        
        // 淡入淡出
    } else if (indexPath.row == MERPresentationAnimationTypeFade) {
        [self presentFadePatternViewController:controller animated:YES completion:nil];
        
        // 点扩散
    } else if (indexPath.row == MERPresentationAnimationTypeDiffuse) {
        [self presentDiffuseViewController:controller startPoint:_clickView.lastClickPoint animated:YES completion:nil];
        
    }
}

@end
