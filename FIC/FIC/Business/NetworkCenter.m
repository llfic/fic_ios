//
//  NetworkCenter.m
//  NEPFoundation
//
//  Created by 周泽文 on 2018/10/11.
//  Copyright © 2018年 周泽文. All rights reserved.
//

#import "NetworkCenter.h"
#import "ZZWNetworkManager.h"
#import "ParamCenter.h"
#import "ZZWDataSaver.h"
#import "ZZWTool.h"
#import "ZZW_APPInfo.h"
#import "NSString+Sha256.h"
#import "LCNetworking.h"
#import "ZZWEncryption.h"
@interface NetworkCenter()
@property(nonatomic,strong)ZZWNetworkManager *manager;
@property(nonatomic,strong)NetworkModel *model;
@property(nonatomic,strong)ParamCenter *pc;
@end
@implementation NetworkCenter


-(instancetype)init{
    self = [super init];
    if (self) {
        _pc = [ParamCenter new];
        
        
        _manager = [ZZWNetworkManager shareManager];
        
        
        _model = [NetworkModel new];
        _model.ipString = _pc.ficIP;
        _model.cmd = _pc.ficCmd;
    }
    return self;
}

-(void)registerWithPhone:(NSString *)phoneNum password:(NSString *)password inviteCode:(NSString *)inviteCode completion:(void (^)(FIC_NetworkResult result, NSDictionary *responseDic))completion;{
    ZZWNetworkManager *manager = [ZZWNetworkManager shareManager];
    password = [ZZWEncryption MD5ForLower32Bate:password];
    _model.paramterDic = @{@"username":phoneNum,@"password":password,@"inviteCode":inviteCode};
    _model.cmd = [_model.cmd stringByAppendingString:@"register"];
    
    [manager PostWithParametersModel:_model completion:^(NetworkResult result, id  _Nullable responseObject) {

        if (result == NetworkResultSuccess) {
            NSDictionary *dic = (NSDictionary *)responseObject[@"data"];
            NSInteger code = [responseObject[@"code"] integerValue];
            if (code == 200) {
                ZZWDataSaver *saver = [ZZWDataSaver shareManager];
                saver.phoneNumber = phoneNum;
                saver.inviteCode = dic[@"myInviteCode"];
                saver.userId = [dic[@"userId"] integerValue];
                saver.tokenValue = dic[@"tokenValue"];
                //dic[@"himageUrl"];//头像
                //            saver.password = password;
                completion(FIC_NetworkResultSuccess,dic);
            }else{
                completion(FIC_NetworkResultFailure,@{@"reason":[self getErrorContentWithCode:code]});
            }
        }else{
            completion(FIC_NetworkResultFailure,(NSDictionary *)responseObject);
        }
        
    }];
}
-(void)loginWithPhone:(NSString *)phoneNum password:(NSString *)password completion:(void (^)(FIC_NetworkResult result, NSDictionary *responseDic))completion
{
    ZZWNetworkManager *manager = [ZZWNetworkManager shareManager];
    password = [ZZWEncryption MD5ForLower32Bate:password];
    _model.paramterDic = @{@"username":phoneNum,@"password":password};
    _model.cmd = [_model.cmd stringByAppendingString:@"login"];
    
    [manager getWithParametersModel:_model completion:^(NetworkResult result, id  _Nullable responseObject) {
        if (result == NetworkResultSuccess) {
            NSDictionary *dic = (NSDictionary *)responseObject[@"data"];
            NSInteger code = [responseObject[@"code"] integerValue];
            if (code == 200) {
                ZZWDataSaver *saver = [ZZWDataSaver shareManager];
                saver.phoneNumber = phoneNum;
                saver.inviteCode = dic[@"myInviteCode"];
                saver.userId = [dic[@"userId"] integerValue];
                saver.tokenValue = dic[@"tokenValue"];
                //dic[@"himageUrl"];//头像
                //            saver.password = password;
                completion(FIC_NetworkResultSuccess,dic);
            }else{
                completion(FIC_NetworkResultFailure,@{@"reason":[self getErrorContentWithCode:code]});
            }
        }else{
            completion(FIC_NetworkResultFailure,(NSDictionary *)responseObject);
        }
        
//        NSDictionary *dic = (NSDictionary *)responseObject[@"data"];
//        NSInteger code = [responseObject[@"code"] integerValue];
//        if (code == 200) {
//            ZZWDataSaver *saver = [ZZWDataSaver shareManager];
//            saver.phoneNumber = phoneNum;
//            saver.inviteCode = dic[@"myInviteCode"];
//            saver.userId = [dic[@"userId"] integerValue];
//            saver.tokenValue = dic[@"tokenValue"];
//            //dic[@"himageUrl"];//头像
//            //            saver.password = password;
//            completion(FIC_NetworkResultSuccess,dic);
//        }else{
//            completion(FIC_NetworkResultFailure,@{@"reason":[self getErrorContentWithCode:code]});
//        }
        
        
//        NSDictionary *dic = (NSDictionary *)responseObject[@"data"];
//        if (result == NetworkResultSuccess) {
//            ZZWDataSaver *saver = [ZZWDataSaver shareManager];
//
//            saver.phoneNumber = phoneNum;
//            saver.inviteCode = dic[@"myInviteCode"];
//            saver.userId = [dic[@"userId"] integerValue];
//            saver.tokenValue = dic[@"tokenValue"];
//            //dic[@"himageUrl"];//头像
//            completion(FIC_NetworkResultSuccess,dic);
//        }
//        else if (result == NetworkResultFailure){
//            NSString *reason = @"账号或者密码错误";
//            dic = @{@"reason":reason};
//            completion(FIC_NetworkResultFailure,dic);
//        }else
//        {
//            completion(FIC_NetworkResultFailure,dic);
//        }
    }];
//    [manager PostWithParametersModel:_model completion:^(NetworkResult result, id  _Nullable responseObject) {
//
//        NSDictionary *dic = (NSDictionary *)responseObject;
//        if (result == NetworkResultSuccess) {
//            ZZWDataSaver *saver = [ZZWDataSaver shareManager];
//            saver.key = responseObject[@"key"];
//            saver.phoneNumber = phoneNum;
//            saver.password = password;
//            completion(FIC_NetworkResultSuccess,dic);
//        }
//        else if (result == NetworkResultFailure){
//            NSString *reason = @"账号或者密码错误";
//            dic = @{@"reason":reason};
//            completion(FIC_NetworkResultFailure,dic);
//        }else
//        {
//            completion(FIC_NetworkResultFailure,dic);
//        }
//
//    }];
}

-(void)sendCodeToPhone:(NSString *)phoneNum completion:(void (^)(FIC_NetworkResult result, NSDictionary *responseDic))completion{
    // 本地生成一个 6位数字符串，发送给腾讯云，让其发短信给用户。比对用户输入的6位验证码和这个字符串是否相同
    
    ZZWNetworkManager *manager = [ZZWNetworkManager shareManager];
    NSString *sdkAppID = @"1400157560";//来自腾讯云
    
    // 6位随机数
    NSInteger num = [ZZWTool getRandomNumWithLength:6];
    NSString *random = [NSString stringWithFormat:@"%.6ld",num];
//    NSString *random = [NSString stringWithFormat:@"%ld",[ZZWTool getRandomNumWithLength:10]];

    _model.ipString = _pc.txIP;
    _model.cmd = [NSString stringWithFormat:@"%@sdkappid=%@&random=%@",_pc.txCmd,sdkAppID,random];
//    _model.ipString = [NSString stringWithFormat:@"https://yun.tim.qq.com/v5/tlssmssvr/sendsms?sdkappid=%@&random=%@",sdkAppID,random];//腾讯云
    
    // 当前时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970];
//    NSTimeInterval b = a+ 11*60;
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    
    NSString *appName = [ZZW_APPInfo shareInstance].appName;
    
    
    NSString *appKey = @"ff87981bb86f4f51468f4d30a065bbfc";// appkey 腾讯云上申请到的
    NSString *plainSig = [NSString stringWithFormat:@"appkey=%@&random=%@&time=%@&mobile=%@",appKey,random,timeString,phoneNum];
//    NSString *plainSig = [NSString stringWithFormat:@"appkey=%@&random=%@&time=%@&mobile=%@",@"5f03a35d00ee52a21327ab048186a2c4",@"7226249334",@"1457336869",@"13788888888"];
    NSString *sig = plainSig.SHA256;
    
    NSString *tpl_id = @"224458";//模板id
    _model.paramterDic = @{@"params":@[random],@"sig":sig,@"sign":appName,@"tel":@{@"mobile":phoneNum,@"nationcode":@"86"},@"time":timeString,@"tpl_id":tpl_id};
//    _model.cmd = @"";
    [manager PostWithParametersModel:_model completion:^(NetworkResult result, id  _Nullable responseObject) {
        NSDictionary *resultDic = (NSDictionary *)responseObject;
        NSInteger code = [resultDic[@"result"] integerValue];
        if (code == 0) {
            completion(FIC_NetworkResultSuccess,@{@"code":[NSNumber numberWithInteger:num]});
        }else{
            completion(FIC_NetworkResultFailure,@{@"reason":@"网络波动，请重新发送验证码"});
        }
        
    }];

}
-(void)logoutCompletion:(void (^)(FIC_NetworkResult result, NSDictionary *responseDic))completion{
    ZZWNetworkManager *manager = [ZZWNetworkManager shareManager];
    manager.requestHeaderToken = [ZZWDataSaver shareManager].tokenValue;
    _model.paramterDic = [NSDictionary dictionary];
    _model.cmd = [_model.cmd stringByAppendingString:@"logout"];
    [manager getWithParametersModel:_model completion:^(NetworkResult result, id  _Nullable responseObject) {
        if (result == NetworkResultSuccess) {
            NSDictionary *dic = (NSDictionary *)responseObject[@"data"];
            NSInteger code = [responseObject[@"code"] integerValue];
            if (code == 200) {
                completion(FIC_NetworkResultSuccess,dic);
            }else{
                completion(FIC_NetworkResultFailure,@{@"reason":[self getErrorContentWithCode:code]});
            }
        }else{
            completion(FIC_NetworkResultFailure,(NSDictionary *)responseObject);
        }
    }];
    
    
//    NSString *URL =[NSString stringWithFormat:@"%@/%@/",_model.ipString,_model.cmd];
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    //    params[@"type"] = @"consultant";
//
//    [LCNetworking PostWithURL:URL Params:params success:^(NSDictionary *responseObject) {
//        NSHTTPCookieStorage* cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//
//        NSArray<NSHTTPCookie *> *cookies = [cookieStorage cookiesForURL:[NSURL URLWithString:URL]];
//         NSMutableArray<NSDictionary *> *propertiesList = [[NSMutableArray alloc] init];
//
//        [cookies enumerateObjectsUsingBlock:^(NSHTTPCookie * _Nonnull cookie, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSMutableDictionary *properties = [[cookie properties] mutableCopy];
//            //将cookie过期时间设置为一年后
//             NSDate *expiresDate = [NSDate dateWithTimeIntervalSinceNow:3600*24*30*12];
//             properties[NSHTTPCookieExpires] = expiresDate;
//            //下面一行是关键,删除Cookies的discard字段，应用退出，会话结束的时候继续保留Cookies
//            [properties removeObjectForKey:NSHTTPCookieDiscard];
//             //重新设置改动后的Cookies
//            [cookieStorage setCookie:[NSHTTPCookie cookieWithProperties:properties]];
//
//        }];
//
//        NSLog(@"POST_success____%@", responseObject);
//    } failure:^(NSString *error) {
//        NSLog(@"POST_failure____%@", error);
//    }];
    
}

-(void)resetPassword:(NSString *)password withPhone:(NSString *)phoneNum completion:(void (^)(FIC_NetworkResult result, NSDictionary *responseDic))completion{
    ZZWNetworkManager *manager = [ZZWNetworkManager shareManager];
    manager.requestHeaderToken = [ZZWDataSaver shareManager].tokenValue;
    password = [ZZWEncryption MD5ForLower32Bate:password];
    _model.paramterDic = @{@"username":phoneNum,@"newpassword":password,@"validateCode":@""};
    _model.cmd = [_model.cmd stringByAppendingString:@"resetPassword"];
    
    [manager getWithParametersModel:_model completion:^(NetworkResult result, id  _Nullable responseObject) {
        if (result == NetworkResultSuccess) {
            NSDictionary *dic = (NSDictionary *)responseObject[@"data"];
            NSInteger code = [responseObject[@"code"] integerValue];
            if (code == 200) {
                ZZWDataSaver *saver = [ZZWDataSaver shareManager];
                saver.phoneNumber = phoneNum;
                saver.inviteCode = dic[@"myInviteCode"];
                saver.userId = [dic[@"userId"] integerValue];
                saver.tokenValue = dic[@"tokenValue"];
                //dic[@"himageUrl"];//头像
                //            saver.password = password;
                completion(FIC_NetworkResultSuccess,dic);
            }else{
                completion(FIC_NetworkResultFailure,@{@"reason":[self getErrorContentWithCode:code]});
            }
        }else{
            completion(FIC_NetworkResultFailure,(NSDictionary *)responseObject);
        }
        
//        NSDictionary *dic = (NSDictionary *)responseObject[@"data"];
//        if (result == NetworkResultSuccess) {
//            ZZWDataSaver *saver = [ZZWDataSaver shareManager];
//
//            saver.phoneNumber = phoneNum;
//            saver.inviteCode = dic[@"myInviteCode"];
//            saver.userId = [dic[@"userId"] integerValue];
//            saver.tokenValue = dic[@"tokenValue"];
//            //dic[@"himageUrl"];//头像
//            completion(FIC_NetworkResultSuccess,dic);
//        }
//        else if (result == NetworkResultFailure){
//            NSString *reason = @"账号或者密码错误";
//            dic = @{@"reason":reason};
//            completion(FIC_NetworkResultFailure,dic);
//        }else
//        {
//            completion(FIC_NetworkResultFailure,dic);
//        }
    }];
}
-(void)getFICBalanceCompletion:(void (^)(FIC_NetworkResult result, NSDictionary *responseDic))completion{
    ZZWNetworkManager *manager = [ZZWNetworkManager shareManager];

    _model.cmd = _pc.ficCmd2;
    //    _model.paramterDic = @{@"username":phoneNum,@"password1":password,@"password2":password,@"email":@""};
    _model.paramterDic = @{};
    _model.cmd = [_model.cmd stringByAppendingString:@"fic"];
    
    
    [manager PostWithParametersModel:_model completion:^(NetworkResult result, id  _Nullable responseObject) {
  
        NSDictionary *dic = (NSDictionary *)responseObject;
        if (result == NetworkResultSuccess) {
            
            completion(FIC_NetworkResultSuccess,dic);
        }else if (result == NetworkResultFailure){
            NSString *reason = [dic objectForKey:@"detail"];
            if ([reason isEqualToString:@"A user with that username already exists."]) {
                reason = @"该账号已经存在";
            }else if (reason == nil){
                NSArray *arr = [dic objectForKey:@"password1"];
                if (arr.count > 0) {
                    reason = @"密码至少八位数字和字母结合";
                }
            }
            
            
            dic = @{@"reason":reason};
            completion(FIC_NetworkResultFailure,dic);
        }
        
    }];
}

-(void)getFICRecordListBalanceCompletion:(void (^)(FIC_NetworkResult result, NSDictionary *responseDic))completion{
    ZZWNetworkManager *manager = [ZZWNetworkManager shareManager];
    //    _model.paramterDic = @{@"username":phoneNum,@"password1":password,@"password2":password,@"email":@""};
    _model.paramterDic = @{};
    _model.cmd = [_model.cmd stringByAppendingPathComponent:@"ficlist"];
    
    [manager PostWithParametersModel:_model completion:^(NetworkResult result, id  _Nullable responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if (result == NetworkResultSuccess) {
            
            completion(FIC_NetworkResultSuccess,dic);
        }else if (result == NetworkResultFailure){
            NSString *reason = [dic objectForKey:@"username"];
            if ([reason isEqualToString:@"A user with that username already exists."]) {
                reason = @"该账号已经存在";
            }else if (reason == nil){
                NSArray *arr = [dic objectForKey:@"password1"];
                if (arr.count > 0) {
                    reason = @"密码至少八位数字和字母结合";
                }
            }
            
            
            dic = @{@"reason":reason};
            completion(FIC_NetworkResultFailure,dic);
        }else{
            completion(FIC_NetworkResultFailure,(NSDictionary *)responseObject);
            
        }
        
    }];
}

-(NSString *)getErrorContentWithCode:(NSInteger)code{
    /*
     TOKEN_MISSED_HEADER    (1002,"Missed Token In Header"),
     TOKEN_NOT_EXIST        (1010,"TOKEN NOT EXIST"),
     USER_NOT_EXIST         (1001,"User Not Exist"),
     TOKEN_NOT_MATCH        (1004,"INVALID TOKEN"),
     TOKEN_INVALID          (1005,"TOKEN INVALID TIME_OUT"),
     USER_AGENT_NOT_MATCH   (1006,"USER AGENT NOT MATCH"),
     用户已存在               1007
     */
    
    NSString *content = nil;
    if (code == 401) {
        content = @"用户已经存在";
    }else if (code == 1000){// 密码不对
        content = @"手机号或密码错误";
    }else if (code == 1001){// 手机号不丢
        content = @"手机号或密码错误";
    }else if (code == 1002){// 请求头缺少token
        content = @"登录过期，请重新登录";
    }else if (code == 1003){// 手机号格式不对
        content = @"";
    }else if (code == 1004){// token 无效
        content = @"登录过期，请重新登录";
    }else if (code == 1005){// token 超时
        content = @"登录过期，请重新登录";
    }else if (code == 1006){// 账号被登出
        content = @"登录过期，请重新登录";
    }else if (code == 1007){// 手机号已经注册
        content = @"手机号已经注册，请直接登录";
    }else if (code == 1008){// 旧密码不正确
        content = @"旧密码错误";
    }else if (code == 1009){// 两次输入的新密码不同
        content = @"";
    }else if (code == 1010){// token不存在
        content = @"登录过期，请重新登录";
    }else if (code == 1011){// 邀请码无效
        content = @"邀请码错误";
    }
    
    
    return content;
}
@end
