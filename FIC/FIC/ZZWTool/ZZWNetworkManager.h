//
//  ZZWNetworkManager.h
//  NEPFoundation
//
//  Created by 周泽文 on 2018/10/11.
//  Copyright © 2018年 周泽文. All rights reserved.
//
/**
 借助第三方库AFNetworking、SDWebImage来做基本的网络处理类，包含发送post、get等请求，上次图片、视频文件等等
 APP只需要传入必要的参数就可以得到想要的结果
 只针对 网络超时、无网络等几种错误情况做了判断
 不参与请求成功的数据处理
 */
#import <Foundation/Foundation.h>
extern NSString * const NetworkErrorReason;
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,NetworkResult) {
    
    NetworkResultSuccess,       //獲取成功
    NetworkResultFailure,       //獲取失敗
    NetworkResultServerError,   //服务器问题
    NetworkResultTimeout,       //超時
    NetworkResultNotNetwork     //沒有網絡
};

@interface NetworkModel : NSObject

/**
 服务器IP地址字符串
 */
@property (nonatomic,strong) NSString *ipString;
/**
 接口定义的编号，表示动作
 */
@property (nonatomic,strong) NSString *cmd;

/**
 参数字典
 */
@property (nonatomic,strong) NSDictionary *paramterDic;


@end

@interface ZZWNetworkManager : NSObject
@property(nonatomic,strong)NSString *requestHeaderToken;
+(instancetype)shareManager;
- (void)getWithParametersModel:(NetworkModel *)model completion:(void (^)(NetworkResult result, id  _Nullable responseObject))completion;

- (void)PostWithParametersModel:(NetworkModel *)model completion:(void (^)(NetworkResult result, id  _Nullable responseObject))completion;
@end

NS_ASSUME_NONNULL_END
