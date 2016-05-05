//
//  KFToast.h
//  QYKF
//
//  Created by 金华 on 16/3/16.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KFToast : NSObject

+(void)showToastWithTitle:(NSString*)title Duration:(float)duration;

+(void)showToastWithTitle:(NSString*)title;

+(void)startProgressAnimationInView:(UIView*)view title:(NSString*)title;

+(void)endProgressAnimation;

+(void)endProgressAnimationIfAnimate:(BOOL)animate;

@end
