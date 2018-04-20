//
//  UIViewController+BFEPresentation.h
//  boxfish-english
//
//  Created by 马遥 on 2017/11/23.
//  Copyright © 2017年 boxfish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BFEPresentation)

- (void)presentRegisterGuideViewController:(UIViewController *)viewControllerToPresent
                                  animated:(BOOL)flag
                                completion:(void (^)(void))completion;
@end

