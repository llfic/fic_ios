//
//  ZZW_APPInfo.h
//  NEPFoundation
//
//  Created by 周泽文 on 2018/10/11.
//  Copyright © 2018年 周泽文. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZW_APPInfo : NSObject
+(instancetype)shareInstance;
@property(nonatomic,strong,readonly)NSString *appName;
@property(nonatomic,strong,readonly)NSString *appVersion;
@property(nonatomic,strong,readonly)NSString *appBuildVersion;

@end

NS_ASSUME_NONNULL_END
