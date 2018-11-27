//
//  CustomNavigationController.m
//  FIC
//
//  Created by fic on 2018/11/21.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "CustomNavigationController.h"
#import "ZZWTool.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController
-(instancetype)init{
    self = [super init];
    if (self) {
        _style = CustomNavigation_ClearNavi;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.style == CustomNavigation_ClearNavi) {
        [ZZWTool setNavigation:self.navigationController clear:YES];
        self.navigationItem.title = @"";
    }else if (self.style == CustomNavigation_DefaultNavi){
        [ZZWTool setBackgroudColorWithNavigation:self.navigationController];//设置导航栏背景色为三种颜色混合
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem setNavigationBarBackGroundImgName:@"back" target:self selector:@selector(back)];//添加返回按钮
        
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : WhiteColor, NSFontAttributeName : FontDefault}];//设置导航栏标题颜色
    }
    
}
- (void)back
{
    //    [self.tabBarController.navigationController popViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
