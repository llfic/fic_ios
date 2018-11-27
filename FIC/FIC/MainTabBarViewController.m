//
//  MainTabBarViewController.m
//  NEPWallet
//
//  Created by 周泽文 on 2018/9/17.
//  Copyright © 2018年 zhouzewen. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "FirstPageViewController.h"
#import "SocialViewController.h"
#import "MallViewController.h"
#import "VideoViewController.h"
#import "MyViewController.h"
@interface MainTabBarViewController ()
@end

@implementation MainTabBarViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    FirstPageViewController *fistVC = [FirstPageViewController new];
    [self addChildController:fistVC title:@"首页" iconNormal:@"icon_shouye_wx" iconSelected:@"icon_shouye_xz" withNavi:YES];
    
//    SocialViewController *socialVC = [SocialViewController new];
//    [self addChildController:socialVC title:@"社交" iconNormal:@"icon-shejiao" iconSelected:@"icon-shejiao-1" withNavi:YES];
//
//    MallViewController *mallVC = [MallViewController new];
//    [self addChildController:mallVC title:@"商城" iconNormal:@"icon-mall" iconSelected:@"icon-mall-1" withNavi:YES];

//    VideoViewController *videoVC = [VideoViewController new];
//    [self addChildController:videoVC title:@"视频" iconNormal:@"icon-shiping" iconSelected:@"icon-shiping-1" withNavi:YES];
    
    
    MyViewController *myVC = [MyViewController new];
    [self addChildController:myVC title:@"我的" iconNormal:@"icon_wode_wx" iconSelected:@"icon_wode" withNavi:YES];
    
    
    // Do any additional setup after loading the view.
}

- (void) addChildController : (UIViewController *) viewController title : (NSString *) title iconNormal : (NSString *) iconNormal iconSelected : (NSString *) iconSelected withNavi:(BOOL)hasNavi
{
    [UITabBar appearance].backgroundColor = WhiteColor;// tabbar 背景色
    
    viewController.view.backgroundColor = WhiteColor;
    viewController.title = title;
    viewController.tabBarItem.image = [[UIImage imageNamed:iconNormal] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [UIImage imageNamed:iconSelected];
    // 声明：这张图片按照原始的样子显示出来，不要渲染成其他的颜色（比如说默认的蓝色）
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = selectedImage;
    [viewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:TabbarSelectColor} forState:UIControlStateSelected];
    if (hasNavi) {
        [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:viewController]];
    }else{
        [self addChildViewController:viewController];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
