//
//  TransactionViewController.m
//  FIC
//
//  Created by fic on 2018/10/27.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "TransactionViewController.h"
#import "ZZWTool.h"
#import "GatheringViewController.h"
#import "TransferAccountViewController.h"
#import <Masonry.h>

@interface TransactionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *trasferBtn;
@property (weak, nonatomic) IBOutlet UIButton *gatheringBtn;
@property (weak, nonatomic) IBOutlet UIButton *refreshBtn;
@property (weak, nonatomic) IBOutlet UIImageView *coinImgV;
@property (weak, nonatomic) IBOutlet UILabel *countNumLbl;

@end

@implementation TransactionViewController
-(void)setNavi{
    [ZZWTool setBackgroudColorWithNavigation:self.navigationController];//设置导航栏背景色为三种颜色混合
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem setNavigationBarBackGroundImgName:@"back" target:self selector:@selector(back)];//添加返回按钮
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:16]}];//设置导航栏标题颜色
    
    
}
-(void)setTable{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = DefaultBgColor;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0);//设置分割线长度
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏分割线
    //    [self.tableView registerNib:[UINib nibWithNibName:CoinInfoCell_NAME bundle:nil] forCellReuseIdentifier:CoinInfoCell_IDNETIFIER];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];//隐藏多余的cell
    //    self.tableView.scrollEnabled = NO;//table不能滚动
    self.tableView.contentOffset = CGPointMake(0, -self.navigationController.navigationBar.frame.size.height);
    self.tableView.bounces = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headView.backgroundColor = DefaultBgColor;
    
    

    
    
    CGPoint center = CGPointMake(ScreenWidth/2, self.headView.frame.size.height + 30 + 80);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    label.text = @"暂无交易记录";
    label.textAlignment = NSTextAlignmentCenter;
    label.center = center;
    [self.view addSubview:label];
    
    
    
    
    
    _trasferBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _gatheringBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _refreshBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    NSArray *desArr = @[_trasferBtn,_gatheringBtn,_refreshBtn];
    [desArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:16 tailSpacing:16];
    [desArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_bottom).offset(8);
        make.height.mas_equalTo(@44);
    }];
    
    for (NSInteger i = 0; i < desArr.count; i++) {
        UIButton *button = desArr[i];
        button.layer.cornerRadius = button.frame.size.height/2;
        button.layer.masksToBounds = YES;
    }
}
- (void)back
{
        [self.navigationController popViewControllerAnimated:YES];
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//    //整个head背景
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
//    view.backgroundColor = DefaultBgColor;
//
//    return view;
//}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    return cell;
}

- (IBAction)transferAccout:(id)sender {
    TransferAccountViewController *vc = [TransferAccountViewController new];
    vc.title = self.title;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)gathering:(id)sender {
    GatheringViewController *vc = [GatheringViewController new];
    vc.infoDic = self.infoDic;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)refresh:(id)sender {
    
}

- (IBAction)pasteAction:(id)sender {
}

@end
