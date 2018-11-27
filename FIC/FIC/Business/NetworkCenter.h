//
//  NetworkCenter.h
//  NEPFoundation
//
//  Created by 周泽文 on 2018/10/11.
//  Copyright © 2018年 周泽文. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,FIC_NetworkResult) {
    
    FIC_NetworkResultSuccess,       //成功
    FIC_NetworkResultFailure,       //失败，服务器返回具体的错误内容
  
};
NS_ASSUME_NONNULL_BEGIN

@interface NetworkCenter : NSObject
// 登录
-(void)loginWithPhone:(NSString *)phoneNum password:(NSString *)password completion:(void (^)(FIC_NetworkResult result, NSDictionary *responseDic))completion;

// 注册
-(void)registerWithPhone:(NSString *)phoneNum password:(NSString *)password inviteCode:(NSString *)inviteCode completion:(void (^)(FIC_NetworkResult result, NSDictionary *responseDic))completion;

// 登出
-(void)logoutCompletion:(void (^)(FIC_NetworkResult result, NSDictionary *responseDic))completion;

// 重置密码
-(void)resetPassword:(NSString *)password withPhone:(NSString *)phoneNum completion:(void (^)(FIC_NetworkResult result, NSDictionary *responseDic))completion;

// 发送验证码
-(void)sendCodeToPhone:(NSString *)phoneNum completion:(void (^)(FIC_NetworkResult result, NSDictionary *responseDic))completion;

// 获取 fic  余额
-(void)getFICBalanceCompletion:(void (^)(FIC_NetworkResult result, NSDictionary *responseDic))completion;

// 获取 fic 交易记录
-(void)getFICRecordListBalanceCompletion:(void (^)(FIC_NetworkResult result, NSDictionary *responseDic))completion;
@end

NS_ASSUME_NONNULL_END
