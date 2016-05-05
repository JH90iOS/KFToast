//
//  KFToast.m
//  QYKF
//
//  Created by 金华 on 16/3/16.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "KFToast.h"


#define kToastMarginRight 40.0
#define kToastMarginTop  8
#define kToastAnimationDurationDefaut 0.4
#define kToastTextHeight 15.0
#define kToastProgressMargin 5.0

#define kToastShowDefaultDuration 1.0

@interface KFToast()

@property (strong,nonatomic)UIView* textToastView;
@property (strong,nonatomic)UIView* progressToastView;
@property (strong,nonatomic)UIActivityIndicatorView* indicatorView;

@property (assign,nonatomic)BOOL isShowing;

@end

@implementation KFToast


+ (instancetype)sharedManager {
    static KFToast *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[KFToast alloc]init];
    });
    return instance;
}



+(void)showToastWithTitle:(NSString*)title{
    [KFToast showToastWithTitle:title Duration:kToastShowDefaultDuration];
}

+(void)showToastWithTitle:(NSString*)title Duration:(float)duration{
    
    KFToast* toast = [KFToast sharedManager];
    
    if (toast.textToastView != nil) {
        return;
    }

    UIView* textToastView = [[UIView alloc]init];
    toast.textToastView = textToastView;
    
    UILabel* titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:14.0];
    CGFloat labelWidth = [toast getSuitableRectWidthOfLabel:titleLabel];
    titleLabel.frame = CGRectMake(0, 0, labelWidth, kToastTextHeight);
    
    //超过屏幕
    if (labelWidth + kToastMarginRight * 2 > YSFUIScreenWidth) {
        labelWidth = YSFUIScreenWidth - kToastMarginRight*2 - 50;
    }
    
    textToastView.frame = CGRectMake(0, 0, labelWidth + kToastMarginRight*2, kToastTextHeight+kToastMarginTop*2);
    textToastView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    textToastView.layer.cornerRadius = textToastView.frame.size.height * 0.5;

    titleLabel.center = CGPointMake(textToastView.frame.size.width*0.5, textToastView.frame.size.height*0.5);
    [textToastView addSubview:titleLabel];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    textToastView.alpha = 0.0;
    [window addSubview:textToastView];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGPoint screenCenter = CGPointMake(screenRect.size.width / 2, screenRect.size.height / 2);
    CGPoint center = screenCenter;
    [textToastView setCenter:center];
    toast.isShowing = YES;
    
    
    [UIView animateWithDuration:kToastAnimationDurationDefaut
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         textToastView.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         [NSTimer scheduledTimerWithTimeInterval:duration target:toast selector:@selector(toastTimerDidFinish) userInfo:toast repeats:NO];

                     }];
}




- (void)toastTimerDidFinish{
    
    [UIView animateWithDuration:kToastAnimationDurationDefaut
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         _textToastView.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [self.textToastView removeFromSuperview];
                         self.textToastView = nil;
                     }];

}



+(void)startProgressAnimationInView:(UIView*)view title:(NSString*)title{

    KFToast* toast = [KFToast sharedManager];
    
    if (toast.progressToastView != nil) {
        return;
    }
    
    //背景的透明图
    UIView* progressToastView = [[UIView alloc]initWithFrame:view.frame];
    progressToastView.backgroundColor = [UIColor clearColor];
    toast.progressToastView = progressToastView;
    [view addSubview:progressToastView];


    //中间加载视图
    UIView* containerView = [[UIView alloc]init];
    
    containerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    containerView.alpha = 0.0;
    [progressToastView addSubview:containerView];
    toast.isShowing = YES;
    
    //indicatorView
    UIActivityIndicatorView* indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    toast.indicatorView = indicatorView;
    indicatorView.center = CGPointMake(kToastMarginRight+indicatorView.frame.size.width*0.5,(kToastTextHeight + kToastMarginTop*2)*0.5);
    [containerView addSubview:indicatorView];
    
    
    //label
    UILabel* titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:14.0];
    CGFloat labelWidth = [toast getSuitableRectWidthOfLabel:titleLabel];
    
    //超过屏幕
    if (labelWidth + kToastMarginRight * 2 + indicatorView.frame.size.width > YSFUIScreenWidth)
    {
        labelWidth = YSFUIScreenWidth - kToastMarginRight*2 - indicatorView.frame.size.width - 50;
    }
    titleLabel.frame = CGRectMake(0, 0, labelWidth, kToastTextHeight);

    containerView.frame = CGRectMake(0, 0, indicatorView.frame.size.width + labelWidth + kToastProgressMargin + kToastMarginRight*2, kToastTextHeight+kToastMarginTop*2);
    containerView.center = CGPointMake(view.frame.size.width*0.5, view.frame.size.height*0.5);
    containerView.layer.cornerRadius = containerView.frame.size.height * 0.5;

    titleLabel.center = CGPointMake(indicatorView.center.x + indicatorView.frame.size.width*0.5+labelWidth*0.5 + kToastProgressMargin, containerView.frame.size.height*0.5);
    [containerView addSubview:titleLabel];
    [indicatorView startAnimating];

    [UIView animateWithDuration:kToastAnimationDurationDefaut
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         containerView.alpha = 1.0;
                     } completion:^(BOOL finished) {
                     }];

    
}



+(void)endProgressAnimation{
    KFToast* toast = [KFToast sharedManager];

    if (toast.progressToastView) {
        if (toast.indicatorView) {
            [toast.indicatorView stopAnimating];
        }
        
        
        [UIView animateWithDuration:kToastAnimationDurationDefaut
                              delay:0.0
                            options:(UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction)
                         animations:^{
                             toast.progressToastView.alpha = 0.0;
                         } completion:^(BOOL finished) {
                             [toast.progressToastView removeFromSuperview];
                             toast.progressToastView = nil;
                         }];
        
    }
    
}


+(void)endProgressAnimationIfAnimate:(BOOL)animate{
    KFToast* toast = [KFToast sharedManager];
    
    if (toast.progressToastView) {
        if (toast.indicatorView) {
            [toast.indicatorView stopAnimating];
        }
        
        if (animate) {
            
            [UIView animateWithDuration:kToastAnimationDurationDefaut
                                  delay:0.0
                                options:(UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction)
                             animations:^{
                                 toast.progressToastView.alpha = 0.0;
                             } completion:^(BOOL finished) {
                                 [toast.progressToastView removeFromSuperview];
                                 toast.progressToastView = nil;
                             }];

        }
        else{
            [toast.progressToastView removeFromSuperview];
            toast.progressToastView = nil;
        }
        
    }
}


-(CGFloat)getSuitableRectWidthOfLabel:(UILabel*)label{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:label.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize tmpLabelSize = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT,label.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return tmpLabelSize.width;
}

@end
