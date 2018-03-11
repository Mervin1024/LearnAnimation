//
//  BFELiveKnowledgeEntranceDetailedRulesView.m
//  boxfish-english
//
//  Created by 马遥 on 2018/3/7.
//  Copyright © 2018年 boxfish. All rights reserved.
//

#import "BFELiveKnowledgeEntranceDetailedRulesView.h"
#import "BFELiveKnowledgeDetailedRulesAnimationView.h"
#import "Macro.h"

@interface BFELiveKnowledgeEntranceDetailedRulesView () <BFEDetailedRulesAnimationViewDelegate>

@property (nonatomic, strong) UIView *backMaskView;
@property (nonatomic, strong) BFELiveKnowledgeDetailedRulesAnimationView *animationView;

@end

@implementation BFELiveKnowledgeEntranceDetailedRulesView

- (void)dealloc {
    NSLog(@"BFELiveKnowledgeEntranceDetailedRulesView 已释放");
}

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    if (self) {
        [self createMainView];
    }
    return self;
}

- (void)createMainView {
    self.backMaskView = [[UIView alloc] initWithFrame:self.bounds];
    self.backMaskView.backgroundColor = ColorWithAlpha(0, 0, 0, 0.8);
    [self addSubview:self.backMaskView];
    
    CGFloat animationViewHeight = 300;
    CGFloat animationViewWidth = 350 / 284.0 * animationViewHeight;
    CGFloat animationOriginX = (Screen_Width - animationViewWidth) / 2;
    CGFloat animationOriginY = 206;
    self.animationView = [[BFELiveKnowledgeDetailedRulesAnimationView alloc] initWithFrame:CGRectMake(animationOriginX, animationOriginY, animationViewWidth, animationViewHeight)];
    [self addSubview:self.animationView];
    self.animationView.delegate = self;
    
    [self hide:NO completion:nil];
}

#pragma mark - Public

- (void)show:(BOOL)animated completion:(void (^)(BOOL))completion {
    self.hidden = NO;
    self.backMaskView.alpha = 0;
    
    NSTimeInterval duration = animated ? 0.3 : 0;
    [UIView animateWithDuration:duration animations:^{
        self.backMaskView.alpha = 1;
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
    [self.animationView show:animated];
}

- (void)hide:(BOOL)animated completion:(void (^)(BOOL))completion {
    [self.animationView hide:animated];
    NSTimeInterval duration = animated ? 0.3 : 0;
    [UIView animateWithDuration:duration animations:^{
        self.backMaskView.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        if (completion) {
            completion(finished);
        }
    }];
}

#pragma mark - BFEDetailedRulesAnimationViewDelegate

- (void)detailedRulesAnimationView:(BFELiveKnowledgeDetailedRulesAnimationView *)view closeButtonDidPressed:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(detailedRulesView:closeButtonDidPressed:)]) {
        [self.delegate detailedRulesView:self closeButtonDidPressed:button];
    }
}

@end
