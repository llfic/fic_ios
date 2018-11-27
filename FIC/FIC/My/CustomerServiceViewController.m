//
//  CustomerServiceViewController.m
//  FIC
//
//  Created by fic on 2018/11/9.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "CustomerServiceViewController.h"
#import "ZZWHudHelper.h"
#import "ZZWTool.h"
@interface CustomerServiceViewController ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *desLbl;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property(nonatomic,strong)NSString *weixinID;
@property(nonatomic,strong)NSString *qqID;
@end

@implementation CustomerServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    
    // 整体背景
    self.bgView.layer.cornerRadius = ViewCorner*2;
    self.bgView.layer.shadowColor = BlackColor.CGColor;
    self.bgView.layer.shadowOffset = CGSizeZero;
    self.bgView.layer.shadowOpacity = ShadowOpacity;
    self.bgView.layer.shadowRadius = ViewCorner*3/2;
    self.bgView.layer.cornerRadius = ViewCorner;
    self.bgView.layer.borderWidth = BorderWidth;
    self.bgView.layer.borderColor = WhiteColor.CGColor;
    
    
    _weixinID = @"FIC-6688";
    _qqID = @"2168704709";
    
    _imageView.image = [UIImage imageNamed:@"my_wx"];
    _imageView2.image = [UIImage imageNamed:@"my_QQ"];
    _label.text = [NSString stringWithFormat:@"微信号：%@",_weixinID];
    _label.textColor = TextMidGray;
    
    _label2.text = [NSString stringWithFormat:@"QQ号：%@",_qqID];
    _label2.textColor = TextMidGray;
    [_button setTitle:[NSString stringWithFormat:@"复制微信号"] forState:UIControlStateNormal];
    _button.backgroundColor = ButtonBg_red;
    _button.layer.cornerRadius = _button.frame.size.height/2;
    _button.layer.masksToBounds = YES;
    
    _button2.layer.cornerRadius = _button2.frame.size.height/2;
    _button2.layer.masksToBounds = YES;
    [_button2 setTitle:[NSString stringWithFormat:@"复制QQ号"] forState:UIControlStateNormal];
    _button2.backgroundColor = ButtonBg_red;
    _desLbl.text = @"您可以扫描微信或者QQ二维码，也可以复制微信或者QQ号添加客服美美，她会帮您解决一切问题哦！";
    _desLbl.textColor = TextMidGray;
    
}

-(void)setNavi{
    self.navigationItem.title = @"客服信息";
}

- (IBAction)copyAction:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.weixinID;
    
    ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
    [hud showHudInSuperView:self.view withText:@"复制成功" withType:HudModeTitle];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [hud hideHudInSuperView:self.view];
    });
}

@end
