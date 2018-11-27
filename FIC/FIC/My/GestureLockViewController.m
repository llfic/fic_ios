//
//  GestureLockViewController.m
//  FIC
//
//  Created by fic on 2018/10/26.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "GestureLockViewController.h"
#import "GestureLockView.h"
#import "ZZWHudHelper.h"
#import "ZZWDataSaver.h"
#import "ZZWTool.h"
#import "TabBarViewController.h"
@interface GestureLockViewController ()<GestureLockDelegate>
@property (strong, nonatomic) UILabel *label;
@property(nonatomic,assign)BOOL isFirst;
@end

@implementation GestureLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *backImge = [[UIImageView alloc]initWithFrame:self.view.frame];
//    backImge.image = [UIImage imageNamed:@"back.png"];
    [self.view addSubview:backImge];
    
    
    ZZWDataSaver *saver = [ZZWDataSaver shareManager];
    self.isFirst = !saver.hadGesture;
    
    
    GestureLockView *gesView = [[GestureLockView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-self.view.frame.size.width-60, self.view.frame.size.width, self.view.frame.size.width)];
    gesView.center = self.view.center;
    gesView.delegate = self;
    [self.view addSubview:gesView];
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, ScreenWidth, 30)];
    _label.textAlignment = NSTextAlignmentCenter;
    if (self.isFirst) {
        _label.text = @"请设置密码";
    }else{
        _label.text = @"请输入密码";
        [gesView setRigthResult:[ZZWDataSaver shareManager].gesture];
    }
    
//    _label.textColor = [UIColor whiteColor];
    [self.view addSubview:_label];
    // Do any additional setup after loading the view.
}
-(void)setNavi{
    self.navigationItem.title = @"手势锁";
    
    self.view.backgroundColor = [UIColor whiteColor];
    [ZZWTool setBackgroudColorWithNavigation:self.navigationController];//设置导航栏背景色为三种颜色混合
    [ZZWTool setNavigation:self.navigationController TitleHidden:NO];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem setNavigationBarBackGroundImgName:@"back" target:self selector:@selector(back)];//添加返回按钮
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:16]}];//设置导航栏标题颜色
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)resetLabel
{
    _label.text = @"请输入密码";
}

#pragma mark - GestureLockViewDelegate

//原密码为nil调用
- (void)GestureLockSetResult:(NSString *)result gestureView:(GestureLockView *)gestureView
{
    if (self.isFirst) {
        NSLog(@"输入密码：%@",result);
        [gestureView setRigthResult:result];
        _label.text = @"请输再次入密码";
    }else{
        ZZWDataSaver *saver = [ZZWDataSaver shareManager];
        saver.hadExist = NO;
        if ([saver.gesture isEqualToString:result]) {
            NSLog(@"密码正确");
            _label.text = @"密码正确";
            ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
            [hud showHudInSuperView:self.view withText:@"密码正确" withType:HudModeTitle];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [hud hideHudInSuperView:self.view];
                TabBarViewController *vc = [TabBarViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            });
        }else{
            _label.text = @"密码错误";
        }
        
    }
    
}

//密码核对成功调用
- (void)GestureLockPasswordRight:(GestureLockView *)gestureView
{
    if (self.isFirst) {
        ZZWDataSaver *saver = [ZZWDataSaver shareManager];
        saver.gesture = [gestureView getRightResult];
        saver.hadGesture = YES;
        saver.hadExist = NO;
        //第一次设置密码
        ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
        [hud showHudInSuperView:self.view withText:@"设置成功" withType:HudModeTitle];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [hud hideHudInSuperView:self.view];
            [self.navigationController popViewControllerAnimated:YES];
        });
    }else{
        ZZWDataSaver *saver = [ZZWDataSaver shareManager];
        saver.hadExist = NO;
        ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
        [hud showHudInSuperView:self.view withText:@"验证成功" withType:HudModeTitle];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [hud hideHudInSuperView:self.view];
            TabBarViewController *vc = [TabBarViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        });
    }
    
    
    NSLog(@"密码正确");
    _label.text = @"密码正确";
}

//密码核对失败调用
- (void)GestureLockPasswordWrong:(GestureLockView *)gestureView
{
    NSLog(@"密码错误");
    _label.text = @"密码错误";
    [self performSelector:@selector(resetLabel) withObject:nil afterDelay:1];
}


@end
