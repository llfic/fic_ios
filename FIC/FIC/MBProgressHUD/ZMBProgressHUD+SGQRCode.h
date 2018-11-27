//
//  ZMBProgressHUD+SGQRCode.h
//  ZMBProgressHUD+SGQRCode
//
//  Created by kingsic on 2015/7/13.
//  Copyright © 2015年 kingsic. All rights reserved.
//

#import "ZMBProgressHUD.h"

@interface ZMBProgressHUD (SGQRCode)

/** ZMBProgressHUD修改后的样式 添加到self.navigationController.view上，导航栏不能被点击 */
+ (ZMBProgressHUD *)SG_showMBProgressHUDWithModifyStyleMessage:(NSString *)message toView:(UIView *)view;
/** ZMBProgressHUD系统自带样式 添加到self.navigationController.view上，导航栏不能被点击 */
+ (ZMBProgressHUD *)SG_showMBProgressHUDWithSystemComesStyleMessage:(NSString *)message toView:(UIView *)view;
/** 10s之后隐藏 */
+ (ZMBProgressHUD *)SG_showMBProgressHUD10sHideWithModifyStyleMessage:(NSString *)message toView:(UIView *)view;

/** 显示加载成功的 ZMBProgressHUD */
+ (void)SG_showMBProgressHUDOfSuccessMessage:(NSString *)message toView:(UIView *)view;

/** 显示加载失败的 MBProgressHUD */
+ (void)SG_showMBProgressHUDOfErrorMessage:(NSString *)message toView:(UIView *)view;

/** 隐藏ZMBProgressHUD 要与添加的view保持一致 */
+ (void)SG_hideHUDForView:(UIView *)view;

/** 只显示文字的 15 号字体（文字最好不要超过 14 个汉字） ZMBProgressHUD */
+ (void)SG_showMBProgressHUDWithOnlyMessage:(NSString *)message delayTime:(CGFloat)time;

@end
