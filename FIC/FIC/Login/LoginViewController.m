//
//  LoginViewController.m
//  FIC
//
//  Created by fic on 2018/10/25.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "NetworkCenter.h"
#import "ZZWHudHelper.h"
#import "AppDelegate.h"
#import "MainTabBarViewController.h"
#import "ResetPasswordViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *accountBgV;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UIView *passwordBgV;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIView *logoBgV;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgView.layer.cornerRadius = ViewCorner*2;
    self.bgView.layer.shadowColor = BlackColor.CGColor;
    self.bgView.layer.shadowOffset = CGSizeZero;
    self.bgView.layer.shadowOpacity = ShadowOpacity;
    self.bgView.layer.shadowRadius = ViewCorner*3/2;
    self.bgView.layer.cornerRadius = ViewCorner;
    self.bgView.layer.borderWidth = BorderWidth;
    self.bgView.layer.borderColor = WhiteColor.CGColor;
    
    self.logoBgV.layer.cornerRadius = self.logoBgV.frame.size.height/2;
    self.logoBgV.layer.masksToBounds = YES;
    
    self.accountBgV.layer.cornerRadius = self.accountBgV.frame.size.height/2;
    self.accountBgV.layer.masksToBounds = YES;
    self.accountTF.textColor = TextMidGray;
    self.accountTF.delegate = self;
    self.accountTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:@{NSForegroundColorAttributeName:TextMidGray}];

    
    
    self.passwordBgV.layer.cornerRadius = self.passwordBgV.frame.size.height/2;
    self.passwordBgV.layer.masksToBounds = YES;
    self.passwordTF.textColor = TextMidGray;
    self.passwordTF.delegate = self;
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName:TextMidGray}];
    self.passwordTF.attributedPlaceholder = attrStr;
    

    
    NSString * str = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"];
    

    self.loginBtn.layer.cornerRadius = self.loginBtn.frame.size.height/2;
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.backgroundColor = ButtonBg_red;
//    self.view.backgroundColor = BlackColor;
//    self.view.alpha = 0.8;
    
    
    _registerBtn.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentLeft;
    _forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    //注册观察键盘的变化
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(transformView:) name:UIKeyboardWillChangeFrameNotification object:nil];
   
}

//键盘回收
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for(UIView *view in self.view.subviews)
    {
        [view resignFirstResponder];
    }
}

//移动UIView
-(void)transformView:(NSNotification *)aNSNotification
{
    //获取键盘弹出前的Rect
    NSValue *keyBoardBeginBounds=[[aNSNotification userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect beginRect=[keyBoardBeginBounds CGRectValue];
    
    //获取键盘弹出后的Rect
    NSValue *keyBoardEndBounds=[[aNSNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect  endRect=[keyBoardEndBounds CGRectValue];
    
    //获取键盘位置变化前后纵坐标Y的变化值
    CGFloat deltaY=endRect.origin.y-beginRect.origin.y;
    NSLog(@"看看这个变化的Y值:%f",deltaY);
    
    //在0.25s内完成self.view的Frame的变化，等于是给self.view添加一个向上移动deltaY的动画
    [UIView animateWithDuration:0.25f animations:^{
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+deltaY, self.view.frame.size.width, self.view.frame.size.height)];
    }];
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    UILabel *label = [textField viewWithTag:100];
    label.hidden = YES;
    return YES;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsCompact];
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    self.navigationController.navigationBar.layer.masksToBounds = YES;
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor clearColor];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (IBAction)registerAction:(id)sender {
    RegisterViewController *vc = [RegisterViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)forgetAction:(id)sender {
    ResetPasswordViewController *vc = [ResetPasswordViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)loginAction:(id)sender {
    BOOL condition = ((self.accountTF.text != nil) && ![self.accountTF.text isEqualToString:@""]) &&  ((self.passwordTF.text != nil) && ![self.passwordTF.text isEqualToString:@""]);
    if (condition) {
        ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
        [hud showHudInSuperView:self.view withText:@"登录中" withType:HudModeDefault];
        
        NetworkCenter *nc = [NetworkCenter new];
        [nc loginWithPhone:self.accountTF.text password:self.passwordTF.text completion:^(FIC_NetworkResult result, NSDictionary * _Nonnull responseDic) {
            if (result == FIC_NetworkResultSuccess) {
//                ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
                hud.text = @"登录成功";
                hud.mode = HudModeTitle;
//                [hud showHudInSuperView:self.view withText:@"登录成功" withType:HudModeTitle];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [hud hideHudInSuperView:self.view];
                    
                    AppDelegate *appd = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    
                    MainTabBarViewController *tabVC = [MainTabBarViewController new];
                    appd.window.rootViewController = tabVC;
                });
            }else{
                hud.text = responseDic[@"reason"];
                hud.mode = HudModeTitle;
//                ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
//                [hud showHudInSuperView:self.view withText:responseDic[@"reason"] withType:HudModeTitle];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [hud hideHudInSuperView:self.view];
                });
            }
        }];
    }else{
        ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
        [hud showHudInSuperView:self.view withText:@"账号密码不能为空" withType:HudModeTitle];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [hud hideHudInSuperView:self.view];
        });
    }
   
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
