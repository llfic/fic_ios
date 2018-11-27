//
//  EarningsReportViewController.m
//  FIC
//
//  Created by fic on 2018/11/1.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "EarningsReportViewController.h"
#import "ZZWTool.h"
#import "Input2Cell.h"
#import "FilmModel.h"


@interface EarningsReportViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSArray *subTitles;
@property(nonatomic,assign)CGFloat ficCount;//投资数量
@property(nonatomic,assign)NSInteger pfCount;//模拟票房
@end

@implementation EarningsReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _titles = @[@"投资数量(模拟1FIC=1CNY)",@"模拟预计总票房(万元)",@"模拟预计总收益率",@"模拟预计本金收益"];
    _subTitles = @[@"请输入投资数量",@"请输入预计总票房",@"0.00%",@"0"];
    
}
-(void)setData{
    _ficCount = 0.0f;
    _pfCount = 0;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"模拟收益计算";

}

-(void)setTable{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = DefaultBgColor;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);//设置分割线长度
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏分割线
    [self.tableView registerNib:[UINib nibWithNibName:Input2Cell_Name bundle:nil] forCellReuseIdentifier:Input2Cell_Identifier];
    //    [self.tableView registerClass:[FilmCell class] forCellReuseIdentifier:FilmCell_Identifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];//隐藏多余的cell
//    self.tableView.scrollEnabled = NO;//table不能滚动
//    self.tableView.tableHeaderView = [self createTableHeadView];
    //    self.tableView.bounces = NO;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return Input2Cell_Height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 2) {
        Input2Cell *cell = [tableView dequeueReusableCellWithIdentifier:Input2Cell_Identifier forIndexPath:indexPath];
        UIFont *font = FontDefault;
        if (ScreenWidth == 320) {
            font = FontSmallest;
        }
        cell.titleLbl.text = _titles[indexPath.row];
        cell.titleLbl.font = font;
        cell.bgView.layer.cornerRadius = ViewCorner;
        cell.bgView.layer.masksToBounds = YES;
        cell.textField.placeholder = _subTitles[indexPath.row];
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        cell.textField.tag = 100 + indexPath.row;
        cell.textField.delegate = self;
        cell.textField.font = font;
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        UIFont *font = FontDefault;
        if (ScreenWidth == 320) {
            font = FontSmallest;
        }
        cell.textLabel.text = _titles[indexPath.row];
        cell.textLabel.font = font;
        cell.detailTextLabel.text = _subTitles[indexPath.row];
        cell.detailTextLabel.font = font;
        if (indexPath.row == 2) {
            cell.textLabel.textColor = TextYellow;
            cell.detailTextLabel.textColor = TextYellow;
        }else{
            cell.textLabel.textColor = TextRed;
            cell.detailTextLabel.textColor = TextRed;
        }
        return cell;
    }
    
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField.tag == 100) {
        _ficCount = [textField.text integerValue]*0.98;
    }else{
        _pfCount = [textField.text integerValue];
    }
    if (_ficCount>0 && _pfCount>0) {
         CGFloat count = _pfCount*10000/3 - [self.filmModel.totalNum integerValue]*100000000;
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        CGFloat percent = count/([self.filmModel.totalNum integerValue]*100000000);
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f%%",100.0*percent];
        
        if (percent > 0.5) {
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
            
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f",0.8*_ficCount*percent + _ficCount];
        }else{
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f",(percent*_ficCount) + _ficCount];
        }
       
    }
    
    return YES;
}
-(NSString *)getContent{
    return  @"1.电影投资收益率\n=(电影出品方实际分得的票房收入-电影总投资)/电影总投资\n2.电影出品方实际分得的票房收入\n=实际票房总收入-税费-影院分成-所有和电影项目相关的费用(如制作团队鼓励、额外宣传费用等)\n3.一般情况下，电影出品方实际分得的票房收入约为实际票房总收入1/3\n4.制作团队奖励是当电影产生收益后，根据实际收益的大小，给制作团队相应的奖励\n5.电影总投资=拍摄制作费+宣传发行+行政管理费等\n6.平台收取投资手续费用2%\n7.进入矿池比例=\n\t7.1:0(当电影投资收益费≤50%时)\n\t7.2:20%(当电影投资收益费>50%时)\n8.计算结果仅作为参考，由于影视行业的特殊性，存在不可预测的因素可能导致电影制作、宣传等成本发生调整，淘影不对该计算结果承担任何责任，最终收益以实际分配为准。";
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    NSString *text = [self getContent];
    UIFont *font = FontSmall;
    if (ScreenWidth == 320) {
        font = FontSmallest;
    }
    CGFloat height = [ZZWTool getHeightWithFont:font width:ScreenWidth -DefaultMargin*2 content:text];
    
    height += 120;
    return height;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    NSString *text = [self getContent];
    UIFont *font = FontSmall;
    if (ScreenWidth == 320) {
        font = FontSmallest;
    }
    CGFloat height = [ZZWTool getHeightWithFont:font width:ScreenWidth -DefaultMargin*2 content:text] + 20;
    
    height += 100;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height + 20)];
//    view.backgroundColor = [UIColor colorWithHexString:@"f2e4eb"];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(DefaultMargin, 10, ScreenWidth -DefaultMargin*2, 44);
    //    [button2 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    button2.backgroundColor = ButtonBg_red;
    [button2 setTitle:@"确定" forState:UIControlStateNormal];
    button2.layer.cornerRadius = ButtonCorner;
    button2.layer.masksToBounds = YES;
    [button2 addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button2];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(DefaultMargin, 60, ScreenWidth -2*DefaultMargin, height -60)];
    bgView.backgroundColor =  [UIColor clearColor];
    [view addSubview:bgView];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - DefaultMargin*2, 20)];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.text = @"说明";
    titleLbl.font = FontDefault;
    titleLbl.backgroundColor = [UIColor clearColor];
    [bgView addSubview:titleLbl];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, ScreenWidth - DefaultMargin*2, height - 100)];
    label.text = text;
    label.font = font;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = TextMidGray;
    [bgView addSubview:label];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    bgView.backgroundColor = [UIColor clearColor];
    return bgView;
}

-(void)sureAction:(UIButton *)button{
    
}
@end
