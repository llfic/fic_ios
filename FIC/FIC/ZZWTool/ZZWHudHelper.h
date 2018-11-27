//
//  ZZWHudHelper.h
//  WeCan
//
//  Created by Summer on 2018/4/19.
//  Copyright © 2018年 WeCan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD.h>
#import <UIKit/UIView.h>
typedef NS_ENUM(NSInteger,HudMode) {
    HudModeDefault,//默认 转菊花+文字
    HudModeTitle// 只有文字
};

@interface ZZWHudHelper : NSObject
@property(nonatomic,copy)NSString *text;
@property(nonatomic,assign) HudMode mode;

+(instancetype)shareInstance;

/**
 展示蒙版

 @param superView 蒙版的父视图
 @param text 蒙版文字
 @param type 蒙版类型
 */
-(void)showHudInSuperView:(UIView *)superView withText:(NSString *)text withType:(HudMode)type;
-(BOOL)hideHudInSuperView:(UIView *)superView;
@end
