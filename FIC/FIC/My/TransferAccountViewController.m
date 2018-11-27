//
//  TransferAccountViewController.m
//  FIC
//
//  Created by fic on 2018/10/27.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "TransferAccountViewController.h"
#import "InputCell.h"
#import "RadioCountCell.h"
@interface TransferAccountViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *titles;
@end

@implementation TransferAccountViewController
-(void)setData{
    _titles = @[@"输入金额",@"输入ETH地址",@"",@"15.1454gwei"];
}
-(void)setTable{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = DefaultBgColor;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0);//设置分割线长度
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏分割线
    [self.tableView registerNib:[UINib nibWithNibName:InputCell_Name bundle:nil] forCellReuseIdentifier:InputCell_Identifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];//隐藏多余的cell
    //    self.tableView.scrollEnabled = NO;//table不能滚动
    //    self.tableView.bounces = NO;
    //    self.view.backgroundColor = DefaultBgColor;
}
-(void)setNavi{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem setNavigationBarBackGroundImgName:@"back" target:self selector:@selector(back)];//添加返回按钮
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:16]}];//设置导航栏标题颜色
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    bgView.backgroundColor = DefaultBgColor;
    if (section == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 100, 44)];
        label.text = @"转账金额";
        label.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:label];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - 200 - 16, 0, 200, 44)];
        label2.text = @"转账金额0.00";
        label2.textAlignment = NSTextAlignmentRight;
        [bgView addSubview:label2];
    }else if (section == 1){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 100, 44)];
        label.text = @"接收地址";
        label.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:label];
    }else if (section == 2){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 100, 44)];
        label.text = @"发送地址";
        label.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:label];
    }else if (section == 3){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 100, 44)];
        label.text = @"手续费";
        label.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:label];
        
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - 200 - 16, 0, 200, 44)];
        label2.text = @"0.0003ETH≈￥0.4592";
        label2.textAlignment = NSTextAlignmentRight;
        [bgView addSubview:label2];
    }
    return bgView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return 80;
    }else{
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(16, 20, ScreenWidth - 16*2, 44);
    [button addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:button];
    return bgView;
}
-(void)sureAction:(UIButton *)button{
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _titles.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 3) {
        return InputCell_Height;
        
    }else{
        return 90;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 3) {
        InputCell *cell = [tableView dequeueReusableCellWithIdentifier:InputCell_Identifier];
        cell.textField.placeholder = _titles[indexPath.row];
        cell.backgroundColor = DefaultBgColor;//table背景色，默认灰色
        return cell;
    }else{
        RadioCountCell *cell = [RadioCountCell new];
        cell.maxValue = 1;
        cell.minValue = 0;
        return cell;
    }
    
    
}

@end
