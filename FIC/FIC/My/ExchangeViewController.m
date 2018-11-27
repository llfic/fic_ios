//
//  ExchangeViewController.m
//  FIC
//
//  Created by fic on 2018/10/26.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "ExchangeViewController.h"
#import "ExchangeInputCell.h"
#import "ZZWTool.h"
#import "SelectViewController.h"
@interface ExchangeViewController ()<UITableViewDelegate,UITableViewDataSource,ExchangeInputCellDelegate,SelectViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSArray *images;
@end

@implementation ExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}
-(void)setData{
    _titles = @[@"BTC",@"ETH",@"BCH",@"USDT",@"FIC"];
    _images = @[@"btc",@"eth",@"bch",@"usdt",@"fic"];
}
-(void)setNavi{
    
    self.navigationItem.title = @"兑换";
    [ZZWTool setBackgroudColorWithNavigation:self.navigationController];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem setNavigationBarBackGroundImgName:@"back" target:self selector:@selector(back)];//添加返回按钮
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:16]}];//设置导航栏标题颜色
}
-(void)setTable{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = DefaultBgColor;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0);//设置分割线长度
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏分割线
    [self.tableView registerNib:[UINib nibWithNibName:ExchangeInputCell_Name bundle:nil] forCellReuseIdentifier:ExchangeInputCell_Identifier];//注册cell
    //    [self.tableView registerClass:[FilmCell class] forCellReuseIdentifier:FilmCell_Identifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];//隐藏多余的cell
    //    self.tableView.scrollEnabled = NO;//table不能滚动
    //    self.tableView.tableHeaderView = [self createTableHeadView];
    //    self.tableView.bounces = NO;
}

- (void)back
{
    [self.tabBarController.navigationController popViewControllerAnimated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ExchangeInputCell_Height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExchangeInputCell *cell = [tableView dequeueReusableCellWithIdentifier:ExchangeInputCell_Identifier];
    [cell.firstBtn setImage:[UIImage imageNamed:@"btc"] forState:UIControlStateNormal];
    [cell.firstBtn setTitle:@"BTC" forState:UIControlStateNormal];
    
    [cell.secondBtn setImage:[UIImage imageNamed:@"fic"] forState:UIControlStateNormal];
    [cell.secondBtn setTitle:@"FIC" forState:UIControlStateNormal];
    cell.delegate = self;
    cell.des1.attributedText = [ZZWTool getAttributeStrWithFrontStr:@"汇率" frontColor:[UIColor colorWithHexString:@"aaaaaa"] behindStr:@"1BTC≈28.12624519ETH" behindColor:[UIColor blackColor]];
    cell.des2.attributedText = [ZZWTool getAttributeStrWithFrontStr:@"手续费(0.5%)" frontColor:[UIColor colorWithHexString:@"aaaaaa"] behindStr:@"≈0ETH" behindColor:[UIColor blackColor]];
    cell.backgroundColor = DefaultBgColor;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)cell:(ExchangeInputCell *)cell chooseAction:(ExchangeInputCellChooseType)type{
    switch (type) {
        case ExchageAction:
            {
                
            }
            break;
        case FirstAction:
        {
            SelectViewController *vc = [SelectViewController new];
            vc.leftSelectIndex = 0;
            vc.rightSelectIndex = 0;
            vc.delegate = self;
            [self presentViewController:vc animated:YES completion:nil];
        }
            break;
        case SecondAction:
        {
            SelectViewController *vc = [SelectViewController new];
            vc.leftSelectIndex = 1;
            vc.rightSelectIndex = 4;
            vc.delegate = self;
            [self presentViewController:vc animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;

}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(16, 10, ScreenWidth - 16*2, 20)];
    label.text = @"BTC最小卖出量：0.0012705";
    label.textColor = [UIColor colorWithHexString:@"aaaaaa"];
    label.font = [UIFont systemFontOfSize:14];
    [bgView addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"兑换" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(16, 20 + 20, ScreenWidth - 16*2, 44);
    [button addTarget:self action:@selector(exchageAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:button];
    return bgView;
}

-(void)exchageAction:(UIButton *)button{
    
}
-(void)controller:(SelectViewController *)controller selectType:(SelectViewController_selectType)type content:(NSString *)content{
    NSInteger index = 0;
    for (NSInteger i = 0; i < _titles.count; i++) {
        if ([content isEqualToString:_titles[i]]) {
            index = i;
            break;
        }
    }
    ExchangeInputCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    switch (type) {
        case SelectViewController_Up:
            {
                
                [cell.firstBtn setImage:[UIImage imageNamed:_images[index]] forState:UIControlStateNormal];
                [cell.firstBtn setTitle:_titles[index] forState:UIControlStateNormal];
            }
            break;
        case SelectViewController_Down:
        {
            [cell.secondBtn setImage:[UIImage imageNamed:_images[index]] forState:UIControlStateNormal];
            [cell.secondBtn setTitle:_titles[index] forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
}
@end
