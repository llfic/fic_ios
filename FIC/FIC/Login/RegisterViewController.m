//
//  RegisterViewController.m
//  FIC
//
//  Created by fic on 2018/10/25.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "RegisterViewController.h"
#import "Input3Cell.h"
#import "ZZWButton.h"
#import "ZZWTool.h"
#import "ZZWDataSaver.h"
#import "NetworkCenter.h"
#import "ZZWHudHelper.h"
#import <CoreGraphics/CoreGraphics.h>
#import "AppDelegate.h"
#import "MainTabBarViewController.h"
@interface RegisterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSArray *contents;
@property(nonatomic,assign)BOOL isAgree;
@property(nonatomic,assign)BOOL getCode;
@property(nonatomic,strong)UIButton *sendCodeBtn;
@property(nonatomic,strong)NSString *code;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.title = @"注册";
    _titles = @[@"+86",@"密码",@"确认密码",@"验证码",@"邀请码"];
    _contents = @[@"请输入手机号",@"请输入密码",@"请确认密码",@"请输入验证码",@"请输入邀请码(选填)"];
    _isAgree = NO;
    _getCode = YES;
    self.NaviStyle = DefaultNavi;
    self.view.backgroundColor = WhiteColor;
}
-(void)setTable{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
//    self.tableView.backgroundColor = DefaultBgColor;//table背景色，默认灰色
//    self.tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0);//设置分割线长度
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏分割线
    [self.tableView registerNib:[UINib nibWithNibName:Input3Cell_Name bundle:nil] forCellReuseIdentifier:Input3Cell_Identifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];//隐藏多余的cell
    //    self.tableView.scrollEnabled = NO;//table不能滚动
    //    self.tableView.bounces = NO;
    //    self.view.backgroundColor = DefaultBgColor;//table背景色，默认灰色
}


#pragma mark - Table
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    view.backgroundColor = WhiteColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(DefaultMargin, 20, ScreenWidth - DefaultMargin*2, 30)];
    label.text = @"注册淘影新账号";
    label.textColor = BlackColor;
    label.font = [UIFont fontWithName:FontNameBold size:FontBig.pointSize];
    [view addSubview:label];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 150;
    
   
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
    view.backgroundColor = WhiteColor;//table背景色，默认灰色
    
    CGFloat originY = 20;
//    CGFloat space = 8;
    
    //同意协议按钮
    UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeBtn.selected = NO;
    [agreeBtn setFrame:CGRectMake(DefaultMargin -12,originY - 12, 40, 40)];
    //    agreeBtn.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    [agreeBtn setImage:[UIImage imageNamed:@"yes_bg"] forState:UIControlStateNormal];
    [agreeBtn addTarget:self action:@selector(agreeProtocolAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview: agreeBtn];
    
    // 协议按钮
    UILabel *textLbl = [[UILabel alloc] initWithFrame:CGRectMake(agreeBtn.frame.size.width,originY , ScreenWidth, 20)];
    textLbl.text = @"我已阅读并接受版权声明和隐私条款";
    textLbl.font = FontSmallest;
    textLbl.textAlignment = NSTextAlignmentLeft;
    [textLbl sizeToFit];
    CGFloat x = 40;
    CGRect frame = CGRectMake(x, textLbl.frame.origin.y, textLbl.frame.size.width, textLbl.frame.size.height);
    UIButton *proBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    proBtn.frame = frame;
//    [proBtn setAttributedTitle:textLbl.attributedText forState:UIControlStateNormal];
    [proBtn setTitle:textLbl.text forState:UIControlStateNormal];
    proBtn.titleLabel.font = FontSmallest;
    [proBtn setTitleColor:TextMidGray forState:UIControlStateNormal];
    [proBtn addTarget:self action:@selector(checkProtocolAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:proBtn];
    
    
    
    
    originY += 40;
    UIButton *button = [ZZWButton getLongButtonWithTitle:@"确定" originY:originY];
//    button.frame = CGRectMake(DefaultMargin, originY, ScreenWidth - DefaultMargin*2, 44);
//    [button setTitle:@"确定" forState:UIControlStateNormal];
//    button.layer.cornerRadius = ButtonCorner;
//    button.layer.masksToBounds = YES;
    button.backgroundColor = ButtonBg_gray;
    [view addSubview:button];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 1000;
    
    return view;
}
-(void)checkProtocolAction:(UIButton *)button{
    
}

-(void)agreeProtocolAction:(UIButton *)button{
    button.selected = !button.selected;
    _isAgree = button.selected;
    if (button.selected == YES) {
        [button setImage:[UIImage imageNamed:@"yes"] forState:UIControlStateNormal];
        UIButton *btn = [self.view viewWithTag:1000];
        btn.backgroundColor = ButtonBg_red;
    }else{
        [button setImage:[UIImage imageNamed:@"yes_bg"] forState:UIControlStateNormal];
        UIButton *btn = [self.view viewWithTag:1000];
        btn.backgroundColor = ButtonBg_gray;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titles.count;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Input3Cell_Height;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Input3Cell *cell = [tableView dequeueReusableCellWithIdentifier:Input3Cell_Identifier];
    cell.titleLbl.text = _titles[indexPath.row];
    cell.textField.placeholder = _contents[indexPath.row];
    cell.backgroundColor = WhiteColor;//table背景色，默认灰色
    if (indexPath.row == 3) {
        if (_sendCodeBtn == nil) {
            _sendCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            [_sendCodeBtn setBackgroundImage:[UIImage imageNamed:@"login_btnBg"] forState:UIControlStateNormal];
            //            _sendCodeBtn.backgroundColor = [UIColor redColor];
            [_sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            _sendCodeBtn.titleLabel.font = FontSmall;
            [_sendCodeBtn setTitleColor:TextRed forState:UIControlStateNormal];
            _sendCodeBtn.frame = CGRectMake(ScreenWidth - 100 , 5, 100, 30);
            [_sendCodeBtn addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:_sendCodeBtn];
        }
    }else if (indexPath.row == 2 || indexPath.row == 1){
        cell.textField.secureTextEntry = YES;
    }
    return cell;
    
    
}
-(void)getCode:(UIButton *)button{
    Input3Cell *cell = (Input3Cell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString *phone = cell.textField.text;
    // 先检查手机输入框中的内容是否有效
    BOOL conditon = [ZZWTool isValidPhoneNumber:phone];
    if (conditon) {
        NetworkCenter *nc = [NetworkCenter new];
        [nc sendCodeToPhone:phone completion:^(FIC_NetworkResult result, NSDictionary * _Nonnull responseDic) {
            if (result == FIC_NetworkResultSuccess) {
                ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
                [hud showHudInSuperView:self.view withText:@"已请求" withType:HudModeTitle];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [hud hideHudInSuperView:self.view];
                    //开始倒计时
                    [self openCountdown];
                    self.code = responseDic[@"code"];
                });
            }else{
                ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
                [hud showHudInSuperView:self.view withText:@"请求失败" withType:HudModeTitle];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [hud hideHudInSuperView:self.view];
                });
            }
        }];
        
    }else{
        ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
        [hud showHudInSuperView:self.view withText:@"手机号格式不正确" withType:HudModeTitle];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [hud hideHudInSuperView:self.view];
        });
    }
}

-(void)openCountdown
{
    //这种方式可以保证，程序进入后台的时候还能计时
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); // 每秒执行一次
    
    NSTimeInterval seconds = 120.f;
    NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:seconds]; // 最后期限
    
    dispatch_source_set_event_handler(_timer, ^{
        int interval = [endTime timeIntervalSinceNow];
        if (interval > 0) { // 更新倒计时
            NSString *timeStr = [NSString stringWithFormat:@"%d秒后重发", interval];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.sendCodeBtn.enabled = NO;
                [self.sendCodeBtn setTitle:timeStr forState:UIControlStateNormal];
            });
        } else { // 倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.sendCodeBtn.enabled = YES;
                [self.sendCodeBtn setTitle:@"重发验证码" forState:UIControlStateNormal];
            });
        }
    });
    dispatch_resume(_timer);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)buttonAction{
    if (self.getCode) {
        if (_isAgree) {
            Input3Cell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            Input3Cell *cell2 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            Input3Cell *cell3 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            // 先检查手机输入框中的内容是否有效
            BOOL conditon = [ZZWTool isValidPhoneNumber:cell.textField.text];
            if (conditon) {
                
                // 检查是否输入了密码
                if (cell2.textField.text != nil && ![cell2.textField.text isEqualToString:@""]) {
                    
                    
                    //检查两次输入的密码是否相同
                    conditon = [cell2.textField.text isEqualToString:cell3.textField.text];
                    if (conditon) {
//                        Input3Cell *cell4 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
//                        conditon = self.code && ([self.code integerValue] == [cell4.textField.text integerValue]);
                        if (conditon) {
                            NSString *inviteCode = @"";
                            Input3Cell *cell5 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
                            if (cell5.textField.text) {
                                inviteCode = cell5.textField.text;
                            }
                            NetworkCenter *nc = [NetworkCenter new];
                            [nc registerWithPhone:cell.textField.text password:cell2.textField.text inviteCode:inviteCode completion:^(FIC_NetworkResult result, NSDictionary * _Nonnull responseDic) {
                                if (result == FIC_NetworkResultSuccess) {
                                    ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
                                    [hud showHudInSuperView:self.view withText:@"注册成功" withType:HudModeTitle];
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                        [hud hideHudInSuperView:self.view];
                                        AppDelegate *appd = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                                        
                                        MainTabBarViewController *tabVC = [MainTabBarViewController new];
                                        appd.window.rootViewController = tabVC;
                                        
                                        
                                    });
                                }else if (result == FIC_NetworkResultFailure){
                                    
                                    ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
                                    [hud showHudInSuperView:self.view withText:responseDic[@"reason"] withType:HudModeTitle];
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                        [hud hideHudInSuperView:self.view];
                                    });
                                }
                            }];
                        }else{
                            ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
                            [hud showHudInSuperView:self.view withText:@"验证码错误" withType:HudModeTitle];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                [hud hideHudInSuperView:self.view];
                            });
                        }
                        
                        
                    }else{
                        ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
                        [hud showHudInSuperView:self.view withText:@"两次输入的密码不同" withType:HudModeTitle];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                            [hud hideHudInSuperView:self.view];
                        });
                    }
                }else{
                    ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
                    [hud showHudInSuperView:self.view withText:@"别忘记设置密码哦" withType:HudModeTitle];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                        [hud hideHudInSuperView:self.view];
                    });
                }
                
                
                
            }else{
                ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
                [hud showHudInSuperView:self.view withText:@"手机号格式不正确" withType:HudModeTitle];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [hud hideHudInSuperView:self.view];
                });
            }
        }else{
            ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
            [hud showHudInSuperView:self.view withText:@"请先同意声明和隐私条款" withType:HudModeTitle];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [hud hideHudInSuperView:self.view];
            });
        }
    }else{
        ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
        [hud showHudInSuperView:self.view withText:@"请先获取验证码" withType:HudModeTitle];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [hud hideHudInSuperView:self.view];
        });
    }
    
   
}
@end
