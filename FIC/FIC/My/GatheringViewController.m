//
//  GatheringViewController.m
//  FIC
//
//  Created by fic on 2018/10/27.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "GatheringViewController.h"
#import "ZZWDataSaver.h"
#import "ZZWTool.h"
#import "ZZWHudHelper.h"
#import "ZZW_APPInfo.h"
#import "CustomerServiceViewController.h"

@interface GatheringViewController ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *remindLbl;
@property (weak, nonatomic) IBOutlet UIButton *contactBtn;
@property (weak, nonatomic) IBOutlet UIImageView *qrcodeBgImgV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@end

@implementation GatheringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 整体背景
    self.bgView.layer.cornerRadius = ViewCorner*2;
    self.bgView.layer.shadowColor = BlackColor.CGColor;
    self.bgView.layer.shadowOffset = CGSizeZero;
    self.bgView.layer.shadowOpacity = ShadowOpacity;
    self.bgView.layer.shadowRadius = ViewCorner*3/2;
    self.bgView.layer.cornerRadius = ViewCorner;
    self.bgView.layer.borderWidth = BorderWidth;
    self.bgView.layer.borderColor = WhiteColor.CGColor;
    
    
    _contactBtn.layer.cornerRadius = 5.0f;
    _contactBtn.layer.masksToBounds = YES;
    _contactBtn.backgroundColor= ButtonBg_red;
    
    self.title = [NSString stringWithFormat:@"%@收款地址",[ZZW_APPInfo shareInstance].appName];
    self.NaviStyle = DefaultNavi;
    
    
    
    //二维码
    CGFloat width = 100;
    UIImageView *codeImgV = [[UIImageView alloc] initWithFrame:CGRectMake(self.qrcodeBgImgV.frame.size.width/2 - width/2, self.qrcodeBgImgV.frame.size.height/2 - width/2, width, width)];
    codeImgV.image = [ZZWTool createQRCodeImageWithContent:self.infoDic[@"key"] withWidth:100];
    [self.qrcodeBgImgV addSubview:codeImgV];
    
    
    
    _addressLbl.textColor = TextMidGray;
    _addressLbl.text = self.infoDic[@"key"];
    
    
    [_button setTitle:[NSString stringWithFormat:@"复制%@地址",self.infoDic[@"name"]] forState:UIControlStateNormal];
    [_button setTitleColor:TextRed forState:UIControlStateNormal];
    _button.backgroundColor = WhiteColor;
    
    self.heightConstraint.constant = [ZZWTool getHeightWithFont:FontSmallest width:ScreenWidth - 4*DefaultMargin content:[NSString stringWithFormat:@"注意：请勿向上述地址充值任何非%@资产，否则资产将不可找回您充值至上述地址后，需要整个网络节点确认，到账的时间与当前以太坊网络的拥堵情况有关。最小充值金额:0.01%@小于金额的充值将不会上账且无法退回。转账成功后请将截图和淘影账号发给客服。",self.title,self.title]];
    
    _remindLbl.font = FontSmallest;
    _remindLbl.textColor = TextMidGray;
    _remindLbl.text = [NSString stringWithFormat:@"注意：请勿向上述地址充值任何非%@资产，否则资产将不可找回您充值至上述地址后，需要整个网络节点确认，到账的时间与当前以太坊网络的拥堵情况有关。最小充值金额:0.01%@小于金额的充值将不会上账且无法退回。转账成功后请将截图和淘影账号发给客服。",self.title,self.title];
    
}



- (IBAction)copyAdress:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.addressLbl.text;
    
    ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
    [hud showHudInSuperView:self.view withText:@"复制成功" withType:HudModeTitle];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [hud hideHudInSuperView:self.view];
    });
}
- (IBAction)contactAction:(id)sender {
    CustomerServiceViewController *vc = [CustomerServiceViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
