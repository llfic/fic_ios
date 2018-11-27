//
//  TabBarViewController.h
//  TransparentNavigationBar
//
//  Created by ChenMan on 2017/6/17.
//  Copyright © 2017年 满 陈. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RechargeStyleViewController.h"
#import "ExchangeViewController.h"


@interface TabBarViewController : UITabBarController

@property (nonatomic , assign) NSInteger currentTabIndex;

@property (nonatomic, strong) RechargeStyleViewController *firstVC;
@property (nonatomic, strong) ExchangeViewController *secondVC;

@end
