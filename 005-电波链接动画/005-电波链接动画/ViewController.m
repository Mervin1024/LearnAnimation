//
//  ViewController.m
//  005-电波链接动画
//
//  Created by 马遥 on 2018/4/18.
//  Copyright © 2018年 马遥. All rights reserved.
//

#define Screen_Bounds       ([UIScreen mainScreen].bounds)
#define Screen_Width        ([UIScreen mainScreen].bounds.size.width)
#define Screen_Height       ([UIScreen mainScreen].bounds.size.height)


#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, strong) UIButton *clearButton;

@property (nonatomic, strong) UIImageView *userAvatar;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UIImageView *targetAvatar;
@property (nonatomic, strong) UILabel *targetNameLabel;
@property (nonatomic, strong) UILabel *beginLabel;
@property (nonatomic, strong) UILabel *connectingLabel;
@property (nonatomic, strong) UITapGestureRecognizer *beginTap;
@end

static CGFloat avatarImageWidth = 102;

@implementation ViewController

- (void)clearMainViewAndReset {
    [self.effectView removeFromSuperview];
    self.effectView = nil;
    [self createMainView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.contentMode = UIViewContentModeScaleAspectFill;
    self.view.layer.contents = (id)[UIImage imageNamed:@"IMG_0932.JPG"].CGImage;

    [self createMainView];
    
}

- (void)createMainView {
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    self.effectView.frame = Screen_Bounds;
    [self.view addSubview:self.effectView];

    self.clearButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.clearButton setTitle:@"清理" forState:UIControlStateNormal];
    [self.clearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.clearButton addTarget:self action:@selector(clearMainViewAndReset) forControlEvents:UIControlEventTouchUpInside];
    [self.clearButton sizeToFit];
    self.clearButton.center = CGPointMake(Screen_Width - 35, 35);
    [self.effectView.contentView addSubview:self.clearButton];
    
    
    self.userAvatar = [[UIImageView alloc] initWithFrame:[self avatarMiddleFrame]];
    self.userAvatar.layer.cornerRadius = 102 / 2;
    self.userAvatar.layer.masksToBounds = YES;
    self.userAvatar.image = [UIImage imageNamed:@"QQ20180418-141358@2x.png"];
    [self.effectView.contentView addSubview:self.userAvatar];
    
    self.userNameLabel = [self createLabelWithTitle:@"用户1" titleColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:14]];
    self.userNameLabel.center = CGPointMake(self.userAvatar.center.x, self.userAvatar.center.y + 40);
    self.userNameLabel.alpha = 0;
    [self.effectView.contentView addSubview:self.userNameLabel];
    
    self.targetAvatar = [[UIImageView alloc] initWithFrame:[self avatarMiddleFrame]];
    self.targetAvatar.layer.cornerRadius = 102 / 2;
    self.targetAvatar.layer.masksToBounds = YES;
    self.targetAvatar.image = [UIImage imageNamed:@"person_default_iPhone.png"];
    [self.effectView.contentView insertSubview:self.targetAvatar belowSubview:self.userAvatar];
    
    self.targetNameLabel = [self createLabelWithTitle:@"用户2" titleColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:14]];
    self.targetNameLabel.center = CGPointMake(self.targetAvatar.center.x, self.targetAvatar.center.y + 40);
    self.targetNameLabel.alpha = 0;
    [self.effectView.contentView addSubview:self.targetNameLabel];

    
    self.beginLabel = [self createLabelWithTitle:@"点击头像开始连线" titleColor:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:20]];
    self.beginLabel.center = [self beginLabelInitCenter];
    [self.effectView.contentView addSubview:self.beginLabel];
    
    self.beginTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginConnect)];
    [self.userAvatar addGestureRecognizer:self.beginTap];
    self.userAvatar.userInteractionEnabled = YES;
    
    self.connectingLabel = [self createLabelWithTitle:@"正在连接中..." titleColor:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:20]];
    self.connectingLabel.center = [self beginLabelInitCenter];
    self.connectingLabel.alpha = 0;
    [self.effectView.contentView addSubview:self.connectingLabel];

}

- (void)beginConnect {
    [self.userAvatar removeGestureRecognizer:self.beginTap];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.userAvatar.center = [self avatarLeftCenter];
        self.targetAvatar.center = [self avatarRightCenter];
        self.userNameLabel.center = CGPointMake([self avatarLeftCenter].x, self.userNameLabel.center.y);
        self.targetNameLabel.center = CGPointMake([self avatarRightCenter].x, self.targetNameLabel.center.y);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            self.userNameLabel.alpha = 1;
            self.userNameLabel.center = CGPointMake(self.userNameLabel.center.x, 342);
        }];
    }];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.beginLabel.center = [self beginLabelFinalCenter];
        self.connectingLabel.center = [self beginLabelFinalCenter];
    } completion:nil];
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.beginLabel.alpha = 0;
    } completion:nil];
    [UIView animateWithDuration:0.4 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.connectingLabel.alpha = 1;
    } completion:nil];
}

- (void)showAvatarNameLabel {
    
}

#pragma mark - Label Creator

- (UILabel *)createLabelWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = titleColor;
    label.font = font;
    [label sizeToFit];
    return label;
}

#pragma mark - Frame Getter

- (CGRect)avatarMiddleFrame {
    return CGRectMake(Screen_Width / 2 - avatarImageWidth / 2, 223, avatarImageWidth, avatarImageWidth);
}

- (CGPoint)avatarLeftCenter {
    return CGPointMake(48 + avatarImageWidth / 2, 223 + avatarImageWidth / 2);
}

- (CGPoint)avatarRightCenter {
    return CGPointMake(Screen_Width - 48 - avatarImageWidth / 2, 223 + avatarImageWidth / 2);
}

- (CGPoint)beginLabelInitCenter {
    return CGPointMake(Screen_Width/2, 360);
}

- (CGPoint)beginLabelFinalCenter {
    return CGPointMake(Screen_Width/2, 410);
}


@end
