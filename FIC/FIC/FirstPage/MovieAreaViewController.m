//
//  MovieAreaViewController.m
//  FIC
//
//  Created by fic on 2018/10/29.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "MovieAreaViewController.h"
#import "MovieInvestViewController.h"
#import "CopyrightViewController.h"
#import "InvestActorViewController.h"
#import "ActorTimeViewController.h"

#import "ZZWTool.h"

@interface MovieAreaViewController ()
@property(nonatomic,strong)UIView *lineV;
@property(nonatomic,strong)UIViewController *currentVC;
@property(nonatomic,assign)CGRect originFrame;
@end

@implementation MovieAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    MovieInvestViewController *vc1=[[MovieInvestViewController alloc]init];
    [self addChildViewController:vc1];
    [vc1 didMoveToParentViewController:self];
    vc1.view.frame = self.view.frame;
    _originFrame = self.view.frame;
    _currentVC = vc1;
    [self.view addSubview:_currentVC.view];
    
    //默认先选择第一个控制器
//    [self didSelectButtonFrom:0 to:0];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    NSArray *naviTitles = @[@"影视投资",@"版权投资",@"投资艺人",@"艺人时间"];
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/(naviTitles.count + 1), 0, ScreenWidth*(naviTitles.count)/(naviTitles.count + 1), 30)];
    for (NSInteger i = 0; i < naviTitles.count ; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100 + i;
        button.frame = CGRectMake( i*(ScreenWidth/(naviTitles.count + 1)), 0, (ScreenWidth/(naviTitles.count + 1)), 30);
        [button setTitle:naviTitles[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        if (ScreenWidth == 320) {
            button.titleLabel.font = [UIFont systemFontOfSize:12];
        }
        
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [button addTarget:self action:@selector(naviAction:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
        if (i == 0) {
            CGPoint center = button.center;
            center.y = 30 ;
            _lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 2)];
            _lineV.backgroundColor = [UIColor whiteColor];
            [titleView addSubview:_lineV];
            _lineV.center = center;
        }
    }
    
    self.navigationItem.titleView = titleView;
    
    
    [ZZWTool setBackgroudColorWithNavigation:self.navigationController];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem setNavigationBarBackGroundImgName:@"back" target:self selector:@selector(back)];//添加返回按钮
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:16]}];//设置导航栏标题颜色
}
-(void)setNavi{
    
    
}


-(void)naviAction:(UIButton *)button{
    if (button.tag == 100) {
        MovieInvestViewController *vc1=[[MovieInvestViewController alloc]init];
        vc1.view.frame = self.view.frame;
        [self changeOldController:_currentVC toNewController:vc1 withButton:button];
    }else if (button.tag == 101){
        CopyrightViewController *vc2=[[CopyrightViewController alloc]init];
        vc2.view.frame = self.view.frame;
        [self changeOldController:_currentVC toNewController:vc2 withButton:button];
        
    }else if (button.tag == 102){
        InvestActorViewController *vc3 =[[InvestActorViewController alloc]init];
        vc3.view.frame = self.view.frame;
        [self changeOldController:_currentVC toNewController:vc3 withButton:button];
    }else if (button.tag == 103){
        ActorTimeViewController *vc4 =[[ActorTimeViewController alloc]init];
        vc4.view.frame = self.view.frame;
        [self changeOldController:_currentVC toNewController:vc4 withButton:button];
    }
//    CGPoint center = button.center;
//    center.y = 30 ;
//    [UIView animateWithDuration:0.5 animations:^{
//        self.lineV.center = center;
//    }];
//    NSLog(@"%ld",button.tag);
}

- (void)back
{
//    [self.tabBarController.navigationController popViewControllerAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
}


-(void)changeOldController:(UIViewController *)oldController toNewController:(UIViewController *)newController withButton:(UIButton *)button{
    [self addChildViewController:newController];
    CGPoint center = button.center;
    center.y = 30 ;
    [self transitionFromViewController:oldController toViewController:newController duration:0.25 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.lineV.center = center;
    } completion:^(BOOL finished) {
        if (finished) {
            
            //移除oldController，但在removeFromParentViewController：方法前不会调用willMoveToParentViewController:nil 方法，所以需要显示调用
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
            [self.view addSubview:self.currentVC.view];
            
        }else
        {
            self.currentVC = oldController;
        }
        
    }];
}

@end
