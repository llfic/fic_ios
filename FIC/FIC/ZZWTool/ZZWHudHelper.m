//
//  ZZWHudHelper.m
//  WeCan
//
//  Created by Summer on 2018/4/19.
//  Copyright © 2018年 WeCan. All rights reserved.
//

#import "ZZWHudHelper.h"
@interface ZZWHudHelper()
@property(nonatomic,strong)MBProgressHUD *hud;
@end
@implementation ZZWHudHelper

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
        _hud = [MBProgressHUD new];
    }
    return self;
}

-(void)showHudInSuperView:(UIView *)superView withText:(NSString *)text withType:(HudMode)type{
    _mode = type;
    switch (type) {
        case HudModeTitle:{
            _hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
            _hud.labelText = text;
            _hud.mode = MBProgressHUDModeText;

        }
            
            break;
        case HudModeDefault:{
            _hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
            _hud.labelText = text;
//            _hud.color = UITools.defaultHudColor;
            if (nil == text) {
                _hud.labelText = @"请稍等";
            }
        }
            
            break;
            
        default:
            break;
    }
    
}


-(BOOL)hideHudInSuperView:(UIView *)superView{
    BOOL result;
    switch (_mode) {
        case HudModeDefault:
            result = [MBProgressHUD hideHUDForView:superView animated:YES];
            _hud = nil;
            break;
        case HudModeTitle:
            [_hud removeFromSuperview];
            _hud = nil;
            result = YES;
            break;
            
        default:
            break;
    }
    return result;
}

-(void)setText:(NSString *)text{
    _text = [text copy];
    _hud.labelText = text;
}


-(void)setMode:(HudMode)mode{
    _mode = mode;
    switch (mode) {
        case HudModeDefault:

            break;
        case HudModeTitle:
            _hud.mode = MBProgressHUDModeText;
            break;
            
        default:
            break;
    }
    
}
@end
