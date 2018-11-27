//
//  ParamCenter.h
//  NEPFoundation
//
//  Created by 周泽文 on 2018/10/11.
//  Copyright © 2018年 周泽文. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 此类专门用来处理项目所有的参数数据
 包括 IP地址的，服务器返回数据的等等都几种在此类在中处理
 */
NS_ASSUME_NONNULL_BEGIN

@interface ParamCenter : NSObject
@property(nonatomic,strong,readonly)NSString *ficIP; // FIC ip地址
@property(nonatomic,strong,readonly)NSString *ficCmd;//登录 注册 登出
@property(nonatomic,strong,readonly)NSString *ficCmd2;// 业务接口

@property(nonatomic,strong,readonly)NSString *txIP;// 腾讯短信服务 ip
@property(nonatomic,strong,readonly)NSString *txCmd;// 腾讯短信 
@end

NS_ASSUME_NONNULL_END
