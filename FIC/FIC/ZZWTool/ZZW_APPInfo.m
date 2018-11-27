//
//  ZZW_APPInfo.m
//  NEPFoundation
//
//  Created by 周泽文 on 2018/10/11.
//  Copyright © 2018年 周泽文. All rights reserved.
//

#import "ZZW_APPInfo.h"

@implementation ZZW_APPInfo
+(instancetype)shareInstance{
    static id _shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[self alloc] init];
    });
    
    return _shareInstance;
}

-(id)init{
    self = [super init];
    if (self) {
        NSDictionary *appInfoDictionary = [[NSBundle mainBundle] infoDictionary];
        _appName = [appInfoDictionary objectForKey:@"CFBundleDisplayName"];
        _appVersion = [appInfoDictionary objectForKey:@"CFBundleShortVersionString"];;
        _appBuildVersion = [appInfoDictionary objectForKey:@"CFBundleVersion"];
    }
    return self;
}
@end
