//
//  AboutProjectViewController.m
//  FIC
//
//  Created by fic on 2018/11/26.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "AboutProjectViewController.h"

@interface AboutProjectViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImgV;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *introLbl;

@end

@implementation AboutProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"关于淘影";
    
    self.introLbl.textColor = TextMidGray;
    self.introLbl.font = FontSmallest;
    
    self.bgView.layer.masksToBounds = NO;// 设置为NO 才会有阴影的效果
    self.bgView.backgroundColor = [UIColor whiteColor];
    
    self.bgView.layer.shadowColor = BlackColor.CGColor;
    self.bgView.layer.shadowOffset = CGSizeZero;
    self.bgView.layer.shadowOpacity = ShadowOpacity;
    self.bgView.layer.shadowRadius = ViewCorner*2;
    self.bgView.layer.cornerRadius = ViewCorner;
    self.bgView.layer.borderWidth = BorderWidth;
    self.bgView.layer.borderColor = WhiteColor.CGColor;
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
