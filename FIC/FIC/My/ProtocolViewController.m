//
//  ProtocolViewController.m
//  FIC
//
//  Created by fic on 2018/11/14.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "ProtocolViewController.h"
#import "ZZWTool.h"
@interface ProtocolViewController ()
@property(nonatomic,strong)UILabel *label;
@end

@implementation ProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    CGFloat hegith = [ZZWTool getHeightWithFont:[UIFont systemFontOfSize:14] width:ScreenWidth - DefaultMargin*2 content:self.content];
    
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(DefaultMargin, 80, ScreenWidth - DefaultMargin*2, hegith)];
    _label.text = self.content;
    _label.font = [UIFont systemFontOfSize:14];
    _label.numberOfLines = 0;
    _label.textAlignment = NSTextAlignmentLeft;
    _label.textColor = [UIColor blackColor];
    [self.view addSubview:_label];
    
    self.view.backgroundColor = [UIColor whiteColor];
}


@end
