//
//  ZZWNetworkManager.m
//  NEPFoundation
//
//  Created by 周泽文 on 2018/10/11.
//  Copyright © 2018年 周泽文. All rights reserved.
//

#import "ZZWNetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import "ZZWTool.h"
#import "ZZWDataSaver.h"
static ZZWNetworkManager *_manager = nil;
NSString * const NetworkErrorReason = @"reason";
@interface ZZWNetworkManager ()

@property (nonatomic,strong) AFHTTPSessionManager *manager;
@property (nonatomic,strong) AFNetworkReachabilityManager *networkManager;
@end
@implementation NetworkModel

@end
@implementation ZZWNetworkManager
+ (instancetype)shareManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [ZZWNetworkManager new];
    });
    return _manager;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        
        //基礎配置
        self.manager = [AFHTTPSessionManager manager];
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.manager.requestSerializer.HTTPShouldHandleCookies = NO;
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        self.manager.requestSerializer.timeoutInterval = 20;
        
    }
    return self;
}
-(void)setRequestHeaderToken:(NSString *)requestHeaderToken{
    if (_requestHeaderToken == nil) {
        _requestHeaderToken = requestHeaderToken;
        [self.manager.requestSerializer setValue:requestHeaderToken forHTTPHeaderField:@"x-auth-token"];
    }
}

- (void)getWithParametersModel:(NetworkModel *)model completion:(void (^)(NetworkResult result, id  _Nullable responseObject))completion{
    
    NSString *urlStr = [model.ipString stringByAppendingFormat:@"%@",model.cmd];//拼接url字符串
    
    [self showNetworkActivityVisible:YES];
    
    [self.manager GET:urlStr parameters:model.paramterDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self showNetworkActivityVisible:NO];
        if (!completion) {
            return;
        }
        completion(NetworkResultSuccess,responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self showNetworkActivityVisible:NO];
        NSLog(@"%@",error);
        NSString *errorText = error.userInfo[@"NSLocalizedDescription"];
        
        if ([errorText isEqualToString:@"The request timed out."])
        {
            completion(NetworkResultTimeout,@{NetworkErrorReason:@"请求超时"});
        }
        else if ([errorText isEqualToString:@"Could not connect to the server."])
        {
            completion(NetworkResultServerError,@{NetworkErrorReason:@"无法连接到服务器"});
        }
        else if ([errorText isEqualToString:@"The Internet connection appears to be offline."])
        {
            completion(NetworkResultNotNetwork,@{NetworkErrorReason:@"没有网络"});
        }else{
            completion(NetworkResultFailure,error);
        }
    }];
    
}


- (void)PostWithParametersModel:(NetworkModel *)model completion:(void (^)(NetworkResult result, id  _Nullable responseObject))completion{

    NSString *urlStr = [model.ipString stringByAppendingString:model.cmd];//拼接url字符串
    [self showNetworkActivityVisible:YES];
    [self.manager.requestSerializer requestWithMethod:@"POST" URLString:urlStr parameters:model.paramterDic error:nil];
    [self.manager POST:urlStr parameters:model.paramterDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [self showNetworkActivityVisible:NO];
        if (!completion) {
            return;
        }
        completion(NetworkResultSuccess,responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showNetworkActivityVisible:NO];
        NSLog(@"%@",error);
        NSString *errorText = error.userInfo[@"NSLocalizedDescription"];
        
        if ([errorText isEqualToString:@"The request timed out."])
        {
            completion(NetworkResultTimeout,@{NetworkErrorReason:@"请求超时"});
        }
        else if ([errorText isEqualToString:@"Could not connect to the server."])
        {
            completion(NetworkResultServerError,@{NetworkErrorReason:@"无法连接到服务器"});
        }
        else if ([errorText isEqualToString:@"The Internet connection appears to be offline."])
        {
            completion(NetworkResultNotNetwork,@{NetworkErrorReason:@"没有网络"});
        }else{
            completion(NetworkResultFailure,error);
        }

    }];
}


- (void)showNetworkActivityVisible:(BOOL)visible {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = visible;
    });
}

-(void)OtherPostMethod{
    
    //    //1.创建会话对象
    //    NSURLSession *session = [NSURLSession sharedSession];
    //
    //    //2.根据会话对象创建task
    //    NSURL *url = [NSURL URLWithString:[model.ipString stringByAppendingFormat:@"/%@",model.cmd]];
    //
    //    //3.创建可变的请求对象
    //    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //
    //    //4.修改请求方法为POST
    //    request.HTTPMethod = @"POST";
    //    //5.设置请求体
    //    request.HTTPBody = [[NSString stringWithFormat:@"username=%@&password1=%@&password2=%@&email=%@",model.paramterDic[@"username"],model.paramterDic[@"password1"],model.paramterDic[@"password2"],@""] dataUsingEncoding:NSUTF8StringEncoding];
    //    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //    //6.根据会话对象创建一个Task(发送请求）
    //    /*
    //     第一个参数：请求对象
    //     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
    //     data：响应体信息（期望的数据）
    //     response：响应头信息，主要是对服务器端的描述
    //     error：错误信息，如果请求失败，则error有值
    //     */
    //    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    //
    //        //8.解析数据
    //        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //        NSDictionary *dict2 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    //        NSDictionary *dict3 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    //        NSDictionary *dict4 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //        NSDictionary *dict5 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //        NSLog(@"%@",dict);
    //
    //    }];
    //
    //    //7.执行任务
    //    [dataTask resume];
    
    
    
    //    NSString *urlStr = [model.ipString stringByAppendingFormat:@"/%@/",model.cmd];//拼接url字符串
    //
    //    [self showNetworkActivityVisible:YES];
    //    [self.manager.requestSerializer requestWithMethod:@"POST" URLString:urlStr parameters:model.paramterDic error:nil];
    //    [self.manager POST:urlStr parameters:model.paramterDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //
    //        [self showNetworkActivityVisible:NO];
    //        if (!completion) {
    //            return;
    //        }
    //        completion(NetworkResultSuccess,responseObject);
    //
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //        [self showNetworkActivityVisible:NO];
    //        NSLog(@"%@",error);
    //        if (completion) {
    //            completion(NetworkResultServerError,nil);
    //        }
    //    }];
    
    
    
    //    NSString *jsonStr = [ZZWTool getJsonStrWithDictionary:model.paramterDic];
    ////    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    //
    //    NSData *postData = [jsonStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    //    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[model.ipString stringByAppendingFormat:@"/%@/",model.cmd] parameters:nil error:nil];
    //    request.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    //    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //    [request setValue:[ZZWDataSaver shareManager].key forHTTPHeaderField:@"X-CSRFToken"];
    //    [request setHTTPBody:postData];
    //
    //    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
    //        if (!error) {
    ////            NSDictionary *fields = (NSHTTPURLResponse*)response.allHeaderFields;
    ////            NSLog(@"fields = %@",[fields description]);
    ////            NSURL *url = [NSURL URLWithString:@"http://dev.skyfox.org/cookie.php"];
    ////            NSLog(@"\n======================================\n");
    ////            //获取cookie方法1
    ////            NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:fields forURL:url];
    ////            for (NSHTTPCookie *cookie in cookies) {
    ////                NSLog(@"cookie,name:= %@,valuie = %@",cookie.name,cookie.value);
    ////            }
    ////            NSLog(@"\n======================================\n");
    //
    //
    //            completion(NetworkResultSuccess,responseObject);
    //            NSLog(@"responseObject: %@", responseObject);
    //        } else {
    ////            NSError *underError = error.userInfo[@"NSErrorFailingURLKey"];
    //
    //            NSData *responseData = error.userInfo[@"com.alamofire.serialization.response.error.data"];
    //
    //            NSString *result = [[NSString alloc] initWithData:responseData  encoding:NSUTF8StringEncoding];
    //
    //            NSLog(@"%@",result);
    //
    //            NSLog(@"error: %@, %@, %@", error, response, responseObject);
    //            completion(NetworkResultFailure,responseObject);
    //        }
    //    }] resume];
}
@end
