//
//  InvestRecordViewController.m
//  FIC
//
//  Created by fic on 2018/11/15.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "InvestRecordViewController.h"
#import "InvestRecordCell.h"
#import "ZZWTool.h"
@interface InvestRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation InvestRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = DefaultBgColor;
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [super showErrorInfoWithType:NOData];
}
-(void)setTable{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
        self.tableView.backgroundColor = DefaultBgColor;
//    self.tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0);//设置分割线长度
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏分割线
    [self.tableView registerNib:[UINib nibWithNibName:InvestRecordCell_Name bundle:nil] forCellReuseIdentifier:InvestRecordCell_Identifier];
    //    [self.tableView registerClass:[FilmCell class] forCellReuseIdentifier:FilmCell_Identifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];//隐藏多余的cell
    //    self.tableView.scrollEnabled = NO;//table不能滚动
//    self.tableView.tableHeaderView = [self createTableHeadView];
    //    self.tableView.bounces = NO;
}

-(void)setNavi{
    self.navigationItem.title = @"投资记录";
    
    self.view.backgroundColor = [UIColor whiteColor];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return InvestRecordCell_Height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InvestRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:InvestRecordCell_Identifier forIndexPath:indexPath];
    cell.nameLbl.text = @"123";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //    cell.textField.placeholder = _titles[indexPath.row];
    //    cell.backgroundColor = DefaultBgColor;//table背景色，默认灰色
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
