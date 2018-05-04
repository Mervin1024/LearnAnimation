//
//  MERGraduallyFadePresentationManager.h
//  MERPresentation
//
//  Created by 马遥 on 2017/11/29.
//  Copyright © 2017年 boxfish. All rights reserved.
//

#import "MERPresentationManager.h"

@interface MERGraduallyFadePresentationManager : MERPresentationManager
@property (nonatomic, copy) PresentationAfterDismiss dismissBlock;
@end
