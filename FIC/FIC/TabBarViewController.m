//
//  TabBarViewController.m
//  TransparentNavigationBar
//
//  Created by ChenMan on 2017/6/17.
//  Copyright © 2017年 满 陈. All rights reserved.
//

#import "TabBarViewController.h"


@interface TabBarViewController ()<UITabBarDelegate>

@end

@implementation TabBarViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 开启返回
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViewControllers];
    // Do any additional setup after loading the view from its nib.
}


- (void)setUpViewControllers
{
    RechargeStyleViewController *firstVC = [[RechargeStyleViewController alloc] initWithNibName:NSStringFromClass([RechargeStyleViewController class]) bundle:nil];
    [self addOneChildVC:firstVC title:@"资产" imageName:@"zichan" selectedImageName:@"zichanSelect"];
    _firstVC = firstVC;
    self.firstVC.tabBarItem.tag = 0;
    
    ExchangeViewController *secondVC = [[ExchangeViewController alloc] initWithNibName:NSStringFromClass([ExchangeViewController class]) bundle:nil];
    [self addOneChildVC:secondVC title:@"兑换" imageName:@"shift" selectedImageName:@"shiftSelect"];
    _secondVC = secondVC;
    self.secondVC.tabBarItem.tag = 1;
    
}

- (void)addOneChildVC:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVC];// 添加导航控制器
    
    nav.title = title;// 设置标题
    
    nav.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];// 设置图标
    
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];// 设置选中图标
    
    nav.tabBarItem.selectedImage = selectedImage;
    
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"da4b96"]} forState:UIControlStateSelected];
    //    // 添加导航控制器
    //    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    switch (item.tag) {
        case 0:
        {
            self.currentTabIndex = 0;
        }
            break;
        case 1:
        {
            self.currentTabIndex = 1;
        }
            break;
            
        default:
            break;
    }
    NSLog(@"didSelectItem: %ld tag: %ld", (long)tabBar.tag, (long)item.tag);
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
