//
//  BaseViewController.h
//  NEPWallet
//
//  Created by 周泽文 on 2018/9/18.
//  Copyright © 2018年 zhouzewen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,ErrorType) {
    NetworkError,//网络问题
    ServerError,//服务器问题
    NOData,//暂无数据
    ToBeOpen//暂未开放
};
typedef NS_ENUM(NSInteger,HudType) {
    NotOpen,//功能未开放
    LatestVersion,//最新版本
    HadSigned,//已经签到过了
    NoMoreData,//没有更多数据
    HadRefreshed//已刷新
};

typedef NS_ENUM(NSInteger,NavigationControllerStyle) {
    DefaultNavi,//默认的导航栏
    DefaultNaviWithoutBack,//没有返回按钮的白色导航栏
    ClearNavi,//透明的导航栏
    ClearNaviWithBack//透明的导航栏 带有返回按钮
    
};
@interface BaseViewController : UIViewController
@property(nonatomic,assign)NavigationControllerStyle NaviStyle;
-(void)showErrorInfoWithType:(ErrorType)type;
-(void)showHudWithType:(HudType)type;

/**
 设置数据
 */
-(void)setData;

/**
 设置导航栏
 */
-(void)setNavi;

/**
 配置tableview
 */
-(void)setTable;
@end
