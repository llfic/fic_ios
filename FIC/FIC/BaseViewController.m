//
//  BaseViewController.m
//  NEPWallet
//
//  Created by 周泽文 on 2018/9/18.
//  Copyright © 2018年 zhouzewen. All rights reserved.
//

#import "BaseViewController.h"
#import "ZZWHudHelper.h"
#import "ZZWTool.h"
@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.NaviStyle = DefaultNavi;
    [self setData]; // 先初始化数据
    [self setNavi]; // 然后设置导航栏
    [self setTable]; // 最后设置tableView
    // Do any additional setup after loading the view.
    

    

}

-(void)setData{
    
}
-(void)setNavi{
    
}
-(void)setTable{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showErrorInfoWithType:(ErrorType)type{
    /**
     隐藏掉界面的其他控件
     */
    for (UIView *view in self.view.subviews) {
        view.hidden = YES;
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2 - 200/2, ScreenHeight/2, 200, 20)];
    switch (type) {
        case ServerError:
            label.text = @"服务器遇到小麻烦";
            break;
        case NetworkError:
            label.text = @"请检查您的网络";
            break;
        case NOData:
            label.text = @"暂无相关数据";
            break;
        case ToBeOpen:
            label.text = @"待开放";
            break;
        default:
            break;
    }
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}
-(void)showNotOpen{
    
    
}
-(void)showHudWithType:(HudType)type{
    NSString *text = @"";
    switch (type) {
        case NotOpen:
            text = @"该功能尚未开放，敬请期待";
            break;
        case LatestVersion:
            text = @"已经是最新版本";
            break;
        case HadSigned:
            text = @"已经签到过了";
            break;
        case HadRefreshed:
            text = @"已刷新";
            break;
        case NoMoreData:
            text = @"没有更多数据了";
            break;
            
        default:
            break;
    }
    
    ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
    [hud showHudInSuperView:self.view withText:text withType:HudModeTitle];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [hud hideHudInSuperView:self.view];
    });
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.NaviStyle == DefaultNavi)
    {
        [ZZWTool setBackgroudColorWithNavigation:self.navigationController];//设置导航栏背景色为白色
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem setNavigationBarBackGroundImgName:@"icon_houtui" target:self selector:@selector(back)];//添加返回按钮
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    else if (self.NaviStyle == DefaultNaviWithoutBack)
    {
        [ZZWTool setBackgroudColorWithNavigation:self.navigationController];//设置导航栏背景色为白色
        self.navigationItem.title = @"";
    }
    else if (self.NaviStyle == ClearNavi)
    {
        [ZZWTool setNavigation:self.navigationController clear:YES];
        self.navigationItem.title = @"";
        UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
        if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
            statusBar.backgroundColor = [UIColor clearColor];
        }
    }
    else if (self.NaviStyle == ClearNaviWithBack)
    {
        [ZZWTool setNavigation:self.navigationController clear:YES];
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem setNavigationBarBackGroundImgName:@"icon_houtui" target:self selector:@selector(back)];//添加返回按钮
    }
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)back
{
    //    [self.tabBarController.navigationController popViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}
@end
