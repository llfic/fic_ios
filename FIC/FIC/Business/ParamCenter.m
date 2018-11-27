//
//  ParamCenter.m
//  NEPFoundation
//
//  Created by 周泽文 on 2018/10/11.
//  Copyright © 2018年 周泽文. All rights reserved.
//

#import "ParamCenter.h"

@implementation ParamCenter
-(instancetype)init{
    self = [super init];
    if (self) {
//        _ficIP = @"http://47.75.111.229:8090"; //国外的
        _ficIP =  @"http://192.168.0.102:8088"; //测试服务器
//        _ficIP = @"http://148.70.53.15:8089";//国内腾讯云
        _ficCmd = @"/api/v1/";//登录 注册 登出
        _ficCmd2 = @"/api/v1/users/";//新的 投资余额
        
        _txIP = @"https://yun.tim.qq.com";
        _txCmd = @"/v5/tlssmssvr/sendsms?";
    }
    return self;
}
@end
