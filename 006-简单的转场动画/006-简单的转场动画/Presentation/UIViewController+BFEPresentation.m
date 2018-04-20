//
//  UIViewController+BFEPresentation.h
//  boxfish-english
//
//  Created by 马遥 on 2017/11/23.
//  Copyright © 2017年 boxfish. All rights reserved.
//

#import "UIViewController+BFEPresentation.h"
#import "MERRegisterGuidePresentationManager.h"
#import <objc/runtime.h>

static char PresentationManagerKey;

@implementation UIViewController (BFEPresentation)

- (void)setPresentationManager:(id)presentationManager {
    objc_setAssociatedObject(self, &PresentationManagerKey, presentationManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)presentationManager {
    id manager = objc_getAssociatedObject(self, &PresentationManagerKey);
    return manager;
}

- (void)presentRegisterGuideViewController:(UIViewController *)viewControllerToPresent
                                  animated:(BOOL)flag
                                completion:(void (^)(void))completion {
    MERRegisterGuidePresentationManager *presentationManager = [[MERRegisterGuidePresentationManager alloc] init];
    [viewControllerToPresent setPresentationManager:presentationManager];
    
    viewControllerToPresent.modalPresentationStyle = UIModalPresentationCustom;
    viewControllerToPresent.transitioningDelegate = presentationManager;

    [self presentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end
