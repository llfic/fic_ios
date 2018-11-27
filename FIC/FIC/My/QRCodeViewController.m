//
//  QRCodeViewController.m
//  FIC
//
//  Created by fic on 2018/11/19.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "QRCodeViewController.h"
#import "ZZWTool.h"
#import "ZZWHudHelper.h"

@interface QRCodeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *codeimageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _codeimageView.image = [ZZWTool createQRCodeImageWithContent:self.qrcodeContent withWidth:200];
    
    _contentLbl.text = self.qrcodeContent;
    _contentLbl.font = FontDefault;
    
    [_button setTitle:@"复制地址" forState:UIControlStateNormal];
    _button.layer.cornerRadius = ButtonCorner;
    _button.layer.masksToBounds = YES;
    _button.backgroundColor = ButtonBg_red;
}

- (IBAction)copyAction:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.qrcodeContent;
    
    ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
    [hud showHudInSuperView:self.view withText:@"复制成功" withType:HudModeTitle];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [hud hideHudInSuperView:self.view];
    });

}

@end
