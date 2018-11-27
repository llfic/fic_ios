//
//  InvestViewController.m
//  FIC
//
//  Created by fic on 2018/11/1.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "InvestViewController.h"
#import "ZZWTool.h"
#import "Input2Cell.h"
#import "NetworkCenter.h"
#import <ZWPullMenuView/ZWPullMenuView.h>
#import "UIButton+ImageTitleSpacing.h"
#import "ProtocolViewController.h"
#import "InvestSuccessViewController.h"
#import "HSLeftPresentAnimation.h"
#import "ZZWDataSaver.h"
#import "FilmModel.h"

@interface InvestViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerTransitioningDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSArray *subTitles;
@property(nonatomic,assign)BOOL isAgree;
@property(nonatomic,assign)NSInteger ficCount;
@end

@implementation InvestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ficCount = 0;
    
//    NetworkCenter *nc = [NetworkCenter new];
//    [nc getFICBalanceCompletion:^(FIC_NetworkResult result, NSDictionary * _Nonnull responseDic) {
//        
//    }];
    
    self.NaviStyle = DefaultNavi;
    self.navigationItem.title = @"投资";
//    //tableview 从屏幕顶部开始布局，而不是导航栏底部
//    self.extendedLayoutIncludesOpaqueBars = YES;
//    if (@available(iOS 11.0, *)) {
//
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        self.edgesForExtendedLayout = UIRectEdgeTop;//保证tableview底部不被tabbar遮挡
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
}
-(void)setData{
    _titles = @[@"投资数量(FIC)",@"投资占比(%)"];
    _subTitles = @[@"请输入投资数量",@"0%"];
    _isAgree = NO;
}

-(void)setTable{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
        self.tableView.backgroundColor = WhiteColor;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0);//设置分割线长度
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏分割线
    [self.tableView registerNib:[UINib nibWithNibName:Input2Cell_Name bundle:nil] forCellReuseIdentifier:Input2Cell_Identifier];
    //    [self.tableView registerClass:[FilmCell class] forCellReuseIdentifier:FilmCell_Identifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];//隐藏多余的cell
        self.tableView.scrollEnabled = NO;//table不能滚动
    self.tableView.tableHeaderView = [self createTableHeadView];
    //    self.tableView.bounces = NO;
}

-(UIView *)createTableHeadView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , ScreenWidth, 150)];
    
    
    // 余额的背景
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(DefaultMargin, 30 , ScreenWidth - DefaultMargin*2, 90)];
    bgView.userInteractionEnabled = YES;
    bgView.image = [UIImage imageNamed:@"bg_gerenzx"];
    bgView.layer.cornerRadius = ViewCorner;
    bgView.layer.masksToBounds = YES;
    [view addSubview:bgView];
    
    //FIC
    UIImageView *ficIcon = [[UIImageView alloc] initWithFrame:CGRectMake(DefaultMargin, DefaultMargin, 20, 20)];
    ficIcon.image = [UIImage imageNamed:@"icon_jinbi"];
    [bgView addSubview:ficIcon];
    
    UILabel *FICLbl = [[UILabel alloc] initWithFrame:CGRectMake(DefaultMargin + 20 + 8, DefaultMargin, bgView.frame.size.width, 20)];
    FICLbl.text = [NSString stringWithFormat:@"FIC余额"];
    FICLbl.font = [UIFont fontWithName:FontNameBold size:FontMax.pointSize];
    FICLbl.textAlignment = NSTextAlignmentLeft;
    FICLbl.textColor = WhiteColor;
    [bgView addSubview:FICLbl];
    
    UILabel *FICNumLbl = [[UILabel alloc] initWithFrame:CGRectMake(DefaultMargin + 20 + 8, FICLbl.frame.origin.y + FICLbl.frame.size.height, 50, 20)];
    FICNumLbl.text = [NSString stringWithFormat:@"0个"];
    FICNumLbl.textColor = WhiteColor;
    FICNumLbl.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:FICNumLbl];
    
    
    //折合人民币
    UILabel *priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(bgView.frame.size.width - 200 - DefaultMargin, bgView.frame.size.height/2 -44/2, 200, 44)];
    priceLbl.text = [NSString stringWithFormat:@"折合人民币≈0元"];
    priceLbl.textColor = WhiteColor;
    priceLbl.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:priceLbl];
    
    return view;
//    CGFloat heigth = 250;
//    CGFloat originY = 100;
//    if (ScreenWidth == 320) {
//        heigth = 200;
//        originY = 80;
//    }
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, heigth)];
//
//    UIColor *color3 = [UIColor colorWithHexString:@"#F9706D"];
//    UIColor *color2 = [UIColor colorWithHexString:@"#87489B"];
//    UIColor *color1 = [UIColor colorWithHexString:@"#58B7D7"];
//    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, heigth)];
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.colors = @[(__bridge id)color1.CGColor, (__bridge id)color2.CGColor, (__bridge id)color3.CGColor];
//    gradientLayer.locations = @[@0.3, @0.5, @1.0];
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1.0, 0);
//    gradientLayer.frame = backView.frame;
//    [view.layer addSublayer:gradientLayer];
//
////    CGFloat originX = ScreenWidth/2;
//    CGFloat width = ScreenWidth;
//    UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, originY, width, 30)];
//    titleLbl.text = @"FIC";
//    titleLbl.textColor = [UIColor whiteColor];
//    titleLbl.textAlignment = NSTextAlignmentCenter;
//    titleLbl.font = [UIFont systemFontOfSize:25];
//    [view addSubview:titleLbl];
//
////    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/2, originY, 0.5, 80)];
////    line.backgroundColor = [UIColor whiteColor];
////    [view addSubview:line];
////
////    UILabel *titleLbl2 = [[UILabel alloc]initWithFrame:CGRectMake(originX, originY, ScreenWidth/2, 30)];
////    titleLbl2.text = @"JF";
////    titleLbl2.textColor = [UIColor whiteColor];
////    titleLbl2.textAlignment = NSTextAlignmentCenter;
////    titleLbl2.font = [UIFont systemFontOfSize:25];
////    [view addSubview:titleLbl2];
//
//
//    originY += 30;
//    UILabel *countLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, originY, width, 20)];
//    countLbl.text = [NSString stringWithFormat:@"%ld",self.ficCount];
//    countLbl.textColor = [UIColor whiteColor];
//    countLbl.textAlignment = NSTextAlignmentCenter;
//    countLbl.font = [UIFont systemFontOfSize:20];
//    [view addSubview:countLbl];
//
////    UILabel *countLbl2 = [[UILabel alloc]initWithFrame:CGRectMake(originX, originY, ScreenWidth/2, 20)];
////    countLbl2.text = @"0";
////    countLbl2.textColor = [UIColor whiteColor];
////    countLbl2.textAlignment = NSTextAlignmentCenter;
////    countLbl2.font = [UIFont systemFontOfSize:20];
////    [view addSubview:countLbl2];
//
//
//
//    originY += 40;
//    UILabel *exchangeLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, originY, width, 30)];
//    exchangeLbl.text = [NSString stringWithFormat:@"折合人民币≈%.2f元",self.ficCount*DefaultPercent];
//    exchangeLbl.textColor = [UIColor whiteColor];
//    exchangeLbl.textAlignment = NSTextAlignmentCenter;
//    exchangeLbl.font = [UIFont systemFontOfSize:16];
//
//    [view addSubview:exchangeLbl];
//
////    UILabel *exchangeLbl2 = [[UILabel alloc]initWithFrame:CGRectMake(originX, originY, ScreenWidth/2, 30)];
////    exchangeLbl2.text = @"1积分=1CNY";
////    exchangeLbl2.textColor = [UIColor whiteColor];
////    exchangeLbl2.textAlignment = NSTextAlignmentCenter;
////    exchangeLbl2.font = [UIFont systemFontOfSize:16];
////
////    [view addSubview:exchangeLbl2];
//
//    return view;
}





-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titles.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return Input2Cell_Height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
//        cell.textLabel.text = _titles[indexPath.row];
////        cell.detailTextLabel.text = _subTitles[indexPath.row];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [rightBtn setTitle:@"FIC" forState:UIControlStateNormal];
//        [rightBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
//        [rightBtn setImage:[UIImage imageNamed:@"shouye_down"] forState:UIControlStateNormal];
//        rightBtn.frame = CGRectMake(ScreenWidth - DefaultMargin - 50, 0, 50, 44);
//        [rightBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleRight imageTitleSpace:5];
//        [rightBtn addTarget:self action:@selector(chooseCoin:) forControlEvents:UIControlEventTouchUpInside];
//        rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//        [cell.contentView addSubview:rightBtn];
//
//
//        return cell;
//
//
//    }else
    if (indexPath.row == 0 || indexPath.row == 0){
        Input2Cell *cell = [tableView dequeueReusableCellWithIdentifier:Input2Cell_Identifier forIndexPath:indexPath];
        cell.bgView.layer.cornerRadius = 5.0f;
        cell.bgView.layer.masksToBounds = YES;
        cell.titleLbl.text = _titles[indexPath.row];
        cell.textField.placeholder = _subTitles[indexPath.row];
        cell.textField.delegate = self;
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell3"];
        cell.textLabel.text = _titles[indexPath.row];
        cell.detailTextLabel.text = _subTitles[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    CGFloat percent = [textField.text integerValue]/([self.filmModel.openNum integerValue]*10000);
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f%%",100.0*percent*DefaultPercent];
    
    return YES;
}
-(void)chooseCoin:(UIButton *)button{
    [button setImage:[UIImage imageNamed:@"shouye_up"] forState:UIControlStateNormal];
    NSArray *titles = @[@"FIC",
                        @" JF"];
    ZWPullMenuView *menuView = [ZWPullMenuView pullMenuAnchorView:button titleArray:titles];
    menuView.zwPullMenuStyle = PullMenuLightStyle;
    menuView.blockSelectedMenu = ^(NSInteger menuRow) {
        [button setTitle:titles[menuRow] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"shouye_down"] forState:UIControlStateNormal];
        NSLog(@"action----->%ld",(long)menuRow);
    };
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    NSString *text = @"1.获得影片票房分红收益；\n2.授予电影荣誉投资人电子证书；\n3.有机会参加影片开机仪式、主演粉丝见面会、影片适应会首映典礼、庆功会和参与综艺节目录制；\n4.赠送该项目电影精品衍生品、联合出品人证书、电影签名纪念册、探班及明星合影机会。\n";
    CGFloat height = [ZZWTool getHeightWithFont:[UIFont systemFontOfSize:14] width:ScreenWidth -DefaultMargin*2 content:text];
    
    height += 108;
    return height;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    NSString *text = @"1.获得影片票房分红收益；\n\n2.授予电影荣誉投资人电子证书；\n\n3.有机会参加影片开机仪式、主演粉丝见面会、影片适应会首映典礼、庆功会和参与综艺节目录制；\n\n4.赠送该项目电影精品衍生品、联合出品人证书、电影签名纪念册、探班及明星合影机会。\n";
    CGFloat height = [ZZWTool getHeightWithFont:FontSmallest width:ScreenWidth -DefaultMargin*2 content:text];
    
    height += 108;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth, height)];
    
    CGFloat originY = 20;
    
    //同意协议按钮
    UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeBtn.selected = NO;
    [agreeBtn setFrame:CGRectMake(DefaultMargin -12,originY - 12, 40, 40)];
    [agreeBtn setImage:[UIImage imageNamed:@"yes_bg"] forState:UIControlStateNormal];
    [agreeBtn addTarget:self action:@selector(agreeProtocolAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview: agreeBtn];
    
    // 协议按钮
    UILabel *textLbl = [[UILabel alloc] initWithFrame:CGRectMake(agreeBtn.frame.size.width,originY , ScreenWidth, 20)];
    textLbl.text = @"我已阅读并接受版权声明、隐私保护条款和风险提醒";
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
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(DefaultMargin, 20 + 40, ScreenWidth -DefaultMargin*2, 44);
//    [button2 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    button2.backgroundColor = ButtonBg_red;
    [button2 setTitle:@"确定" forState:UIControlStateNormal];
    button2.layer.cornerRadius = 10;
    button2.layer.masksToBounds = YES;
    [button2 addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button2];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(DefaultMargin, 118, ScreenWidth - DefaultMargin*2, height - 108)];
    label.text = text;
    label.font = FontSmallest;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = TextGray;
    [view addSubview:label];
    return view;
}
-(void)agreeProtocolAction:(UIButton *)button{
    button.selected = !button.selected;
    _isAgree = button.selected;
    if (button.selected == YES) {
        [button setImage:[UIImage imageNamed:@"yes"] forState:UIControlStateNormal];
    }else{
        [button setImage:[UIImage imageNamed:@"yes_bg"] forState:UIControlStateNormal];
    }
    
}

-(void)checkProtocolAction:(UIButton *)button{
    ProtocolViewController *vc = [ProtocolViewController new];
    vc.title = @"置换协议";
    vc.content = @"1、置换方同意通过TAOYING平台与电影出品方置换其在电影项目拥有的票房收益权益，并取得相应的票房收益分红。\n\n2、置换方同意支付3%的撮合交易手续费给TAOYING平台做为报酬，TAOYING只做为撮合平台，不承担任何责任。\n\n3、置换方根据国家电影局或播出平台、协议等途径公示的数据获得分红，分红金额兑换成当时的FIC(1895)或JF价格数量分配到钱包地址。\n\n4、置换方同意当收益高于8%后，分红的20%转入矿池。";
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)sureAction:(UIButton *)button{
    InvestSuccessViewController *vc = [InvestSuccessViewController new];
    vc.filmModel = self.filmModel;
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    vc.transitioningDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
    
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    HSLeftPresentAnimation* leftPresentAnimation = [[HSLeftPresentAnimation alloc] init];
    leftPresentAnimation.isPresent = YES;
    return leftPresentAnimation;
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    HSLeftPresentAnimation* leftPresentAnimation = [[HSLeftPresentAnimation alloc] init];
    leftPresentAnimation.isPresent = NO;
    return leftPresentAnimation;
}

@end
