//
//  ZMBProgressHUD+SGQRCode.m
//  ZMBProgressHUD+SGQRCode
//
//  Created by kingsic on 2015/7/13.
//  Copyright © 2015年 kingsic. All rights reserved.
//

#import "ZMBProgressHUD+SGQRCode.h"

@implementation ZMBProgressHUD (SGQRCode)

/** ZMBProgressHUD 修改后的样式 */
+ (ZMBProgressHUD *)SG_showMBProgressHUDWithModifyStyleMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    ZMBProgressHUD *hud = [ZMBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.label.font = [UIFont systemFontOfSize:15];
    
    // bezelView.color 自定义progress背景色（默认为白色）
    hud.bezelView.color = [UIColor blackColor];
    // 内容的颜色
    hud.contentColor = [UIColor whiteColor];
    
    [hud hideAnimated:YES afterDelay:5];
    // 隐藏时从父控件上移除
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}
/** ZMBProgressHUD 自带样式 */
+ (ZMBProgressHUD *)SG_showMBProgressHUDWithSystemComesStyleMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    ZMBProgressHUD *hud = [ZMBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.label.font = [UIFont systemFontOfSize:15];
    [hud hideAnimated:YES afterDelay:5];
    // 隐藏时从父控件上移除
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

#pragma mark - - - 显示信息
+ (void)showMessage:(NSString *)message icon:(NSString *)icon toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    ZMBProgressHUD *hud = [ZMBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.label.font = [UIFont systemFontOfSize:15];
    
    // bezelView.color 自定义progress背景色（默认为白色）
    hud.bezelView.color = [UIColor blackColor];
    // 内容的颜色
    hud.contentColor = [UIColor whiteColor];
    
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"ZMBProgressHUD.bundle/%@", icon]]];
    
    // 再设置模式
    hud.mode = ZMBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1.0];
}

/** 显示加载成功的 ZMBProgressHUD */
+ (void)SG_showMBProgressHUDOfSuccessMessage:(NSString *)message toView:(UIView *)view {
    [self showMessage:message icon:@"success" toView:view];
}

/** 显示加载失败的 ZMBProgressHUD */
+ (void)SG_showMBProgressHUDOfErrorMessage:(NSString *)message toView:(UIView *)view {
    [self showMessage:message icon:@"error" toView:view];
}

#pragma mark - - - 隐藏ZMBProgressHUD
/** 隐藏 ZMBProgressHUD */
+ (void)SG_hideHUDForView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}

/** ZMBProgressHUD 修改后的样式 (10s) */
+ (ZMBProgressHUD *)SG_showMBProgressHUD10sHideWithModifyStyleMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    ZMBProgressHUD *hud = [ZMBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.label.font = [UIFont systemFontOfSize:15];
    
    // bezelView.color 自定义progress背景色（默认为白色）
    hud.bezelView.color = [UIColor blackColor];
    // 内容的颜色
    hud.contentColor = [UIColor whiteColor];
    
    [hud hideAnimated:YES afterDelay:10];
    // 隐藏时从父控件上移除
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}


/** 只显示文字的 15 号字体（文字最好不要超过 14 个汉字） ZMBProgressHUD */
+ (void)SG_showMBProgressHUDWithOnlyMessage:(NSString *)message delayTime:(CGFloat)time {
    ZMBProgressHUD *hud = [[ZMBProgressHUD alloc] initWithView:[[[UIApplication sharedApplication] delegate] window]] ;
    hud.mode = ZMBProgressHUDModeText;
    hud.label.text = message;
    hud.label.font = [UIFont systemFontOfSize:15.0];
    hud.removeFromSuperViewOnHide = YES;
    hud.bezelView.color = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    [hud showAnimated:YES];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:hud];
    
    [hud hideAnimated:YES afterDelay:time];
}


@end

