//
//  ResetPasswordViewController.m
//  FIC
//
//  Created by fic on 2018/11/8.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "ZZWTool.h"
#import "ZZWButton.h"
#import "NetworkCenter.h"
#import "ZZWHudHelper.h"
#import "InputCell.h"

@interface ResetPasswordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)UIButton *sendCodeBtn;
@property(nonatomic,strong)NSString *code;
@end

@implementation ResetPasswordViewController
-(void)setData{
    _titles = @[@"请输入手机号",@"请输入密码",@"请输入6-18位新密码"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)setTable{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = DefaultBgColor;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);//设置分割线长度
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏分割线
    [self.tableView registerNib:[UINib nibWithNibName:InputCell_Name bundle:nil] forCellReuseIdentifier:InputCell_Identifier];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifer"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];//隐藏多余的cell
    //    self.tableView.scrollEnabled = NO;//table不能滚动
    //    self.tableView.contentOffset = CGPointMake(0, -self.navigationController.navigationBar.frame.size.height);
    self.tableView.bounces = NO;
    //    self.view.backgroundColor = DefaultBgColor;
}
-(void)setNavi{
    self.navigationItem.title = @"重置密码";
    self.NaviStyle = DefaultNavi;

}

#pragma mark table
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titles.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(DefaultMargin, 0, 200, 44)];
    textField.font = FontSmall;
    textField.placeholder = _titles[indexPath.row];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.tag = 100 + indexPath.row;
    [cell.contentView addSubview:textField];
    if (indexPath.row == 1) {
        if (_sendCodeBtn == nil) {
            _sendCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            //            [_sendCodeBtn setBackgroundImage:[UIImage imageNamed:@"login_btnBg"] forState:UIControlStateNormal];
            //            _sendCodeBtn.backgroundColor = [UIColor redColor];
            [_sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            _sendCodeBtn.titleLabel.font = FontSmall;
            [_sendCodeBtn setTitleColor:TextRed forState:UIControlStateNormal];
            _sendCodeBtn.frame = CGRectMake(ScreenWidth - 100, 5, 100, 30);
            [_sendCodeBtn addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:_sendCodeBtn];
        }
    }else if (indexPath.row == 2){
        textField.secureTextEntry = YES;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
//    bgView.backgroundColor = DefaultBgColor;
    return bgView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
//    view.backgroundColor = DefaultBgColor;//table背景色，默认灰色
    
    UIButton *button = [ZZWButton getLongButtonWithTitle:@"提交" originY:20];
    button.backgroundColor = ButtonBg_red;
    [button setTitleColor:WhiteColor forState:UIControlStateNormal];
    [view addSubview:button];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    return view;
    
}
-(void)buttonAction{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField *textfield = [cell viewWithTag:100 + 0];
    NSString *phone = textfield.text;
    // 先检查手机输入框中的内容是否有效
    BOOL conditon = [ZZWTool isValidPhoneNumber:phone];
    if (conditon) {
        UITableViewCell *cell2 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        UITextField *textfield2 = [cell2 viewWithTag:100 + 1];
        NSString *code = textfield2.text;
        if ([code integerValue] == [self.code integerValue]) {
            UITableViewCell *cell3 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            UITextField *textfield3 = [cell3 viewWithTag:100 + 2];
            NSString *password = textfield3.text;
            if (![password isEqualToString:@""]) {
                ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
                [hud showHudInSuperView:self.view withText:@"修改中" withType:HudModeDefault];
                
                NetworkCenter *nc = [NetworkCenter new];
                [nc resetPassword:password withPhone:phone completion:^(FIC_NetworkResult result, NSDictionary * _Nonnull responseDic) {
                    if (result == FIC_NetworkResultSuccess) {
                        hud.text = @"修改成功";
                        hud.mode = HudModeTitle;
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                            [hud hideHudInSuperView:self.view];
                            [self.navigationController popViewControllerAnimated:YES];
                        });
                    }else{
                        hud.text = responseDic[@"reason"];
                        hud.mode = HudModeTitle;
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                            [hud hideHudInSuperView:self.view];
                        });
                    }
                }];
            }else{
                ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
                [hud showHudInSuperView:self.view withText:@"密码不能为空" withType:HudModeTitle];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [hud hideHudInSuperView:self.view];
                });
            }
        }else{
            ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
            [hud showHudInSuperView:self.view withText:@"验证码错误" withType:HudModeTitle];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [hud hideHudInSuperView:self.view];
            });
        }
    }else{
        ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
        [hud showHudInSuperView:self.view withText:@"手机格式不对" withType:HudModeTitle];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [hud hideHudInSuperView:self.view];
        });
    }
    
}

-(void)getCode:(UIButton *)button{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField *textfield = [cell viewWithTag:100 + 0];
    NSString *phone = textfield.text;
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
@end
