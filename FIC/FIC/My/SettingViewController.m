//
//  SettingViewController.m
//  FIC
//
//  Created by fic on 2018/11/8.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "SettingViewController.h"
#import "ZZW_APPInfo.h"
#import "ZZWTool.h"
#import "ZZWButton.h"
#import "NetworkCenter.h"
#import "ZZWHudHelper.h"
#import "AppDelegate.h"
#import "ZZWDataSaver.h"
#import "LoginViewController.h"
#import "ProtocolViewController.h"
#import "AboutProjectViewController.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *sections;
@property(nonatomic,strong)NSArray *sectionSubArr;
@end

@implementation SettingViewController

-(void)setData{
    NSArray *sectionArr = @[@"置换协议",@"隐私政策"];
    NSArray *section2Arr = @[@"关于淘影"];
    NSArray *section3Arr = @[@"版本检测",@"清除缓存"];
    
    _sections = @[sectionArr,section2Arr,section3Arr];
    
    NSArray *sectionSubArr  = @[@" ",@" "];
    NSArray *section2SubArr = @[@" ",@" "];
    NSArray *section3SubArr = @[[NSString stringWithFormat:@"版本%@",[ZZW_APPInfo shareInstance].appVersion],@" "];
    
    _sectionSubArr = @[sectionSubArr,section2SubArr,section3SubArr];
}
- (void)setTable{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
        self.tableView.backgroundColor = DefaultBgColor;
    self.tableView.separatorInset = CellSeparatorLine;//设置分割线长度
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏分割线
    //    [self.tableView registerNib:[UINib nibWithNibName:CoinInfoCell_NAME bundle:nil] forCellReuseIdentifier:CoinInfoCell_IDNETIFIER];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifer"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];//隐藏多余的cell
    //    self.tableView.scrollEnabled = NO;//table不能滚动
//    self.tableView.contentOffset = CGPointMake(0, -self.navigationController.navigationBar.frame.size.height);
    self.tableView.bounces = NO;
    //    self.view.backgroundColor = DefaultBgColor;
}
-(void)setNavi{
    self.navigationItem.title = @"设置";

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    

}

#pragma mark table
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sections.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *sectionArr = _sections[section];
    return sectionArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"reuseIdentifer";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    cell.textLabel.text = _sections[indexPath.section][indexPath.row];
    cell.detailTextLabel.text = _sectionSubArr[indexPath.section][indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    bgView.backgroundColor = [UIColor clearColor];
    return bgView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 80;
    }else{
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 2) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
        view.backgroundColor = DefaultBgColor;//table背景色，默认灰色
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(DefaultMargin, 20, ScreenWidth - DefaultMargin*2, 44);
        button.layer.cornerRadius = ButtonCorner;
        button.layer.masksToBounds = YES;
        [button setTitle:@"退出登录" forState:UIControlStateNormal];
        button.backgroundColor = WhiteColor;
        [button setTitleColor:TextRed forState:UIControlStateNormal];
        [view addSubview:button];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        
        return view;
    }else{
        return nil;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        ProtocolViewController *vc = [ProtocolViewController new];
        vc.title = @"置换协议";
        vc.content = @"1、置换方同意通过TAOYING平台与电影出品方置换其在电影项目拥有的票房收益权益，并取得相应的票房收益分红。\n\n2、置换方同意支付3%的撮合交易手续费给TAOYING平台做为报酬，TAOYING只做为撮合平台，不承担任何责任。\n\n3、置换方根据国家电影局或播出平台、协议等途径公示的数据获得分红，分红金额兑换成当时的FIC(1895)或JF价格数量分配到钱包地址。\n\n4、置换方同意当收益高于8%后，分红的20%转入矿池。";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 0){
        AboutProjectViewController *vc = [AboutProjectViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)buttonAction{
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"退出"
                                              message:@"是否确定退出登录？"
                                              preferredStyle: UIAlertControllerStyleAlert];
    
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NetworkCenter *nc = [NetworkCenter new];
            [nc logoutCompletion:^(FIC_NetworkResult result, NSDictionary * _Nonnull responseDic) {
                if (result == FIC_NetworkResultSuccess) {
                    /**
                     清空所有数据
                     */
                    ZZWDataSaver *saver = [ZZWDataSaver shareManager];
                    [saver clearData];
                    ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
                    [hud showHudInSuperView:self.view withText:@"登出成功" withType:HudModeTitle];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                        [hud hideHudInSuperView:self.view];
                        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    
                        AppDelegate *ad = (AppDelegate *)[UIApplication sharedApplication].delegate;
                        ad.window.rootViewController =navi;
                    });
    
    
                }else{
                    ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
                    [hud showHudInSuperView:self.view withText:responseDic[@"reason"] withType:HudModeTitle];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                        [hud hideHudInSuperView:self.view];
                    });
                }
            }];
    
    
        }];
        [alertController addAction:OKAction];
    
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancel];
        [self presentViewController:alertController animated:YES completion:nil];
}
@end
