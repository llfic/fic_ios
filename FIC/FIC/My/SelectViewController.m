//
//  SelectViewController.m
//  FIC
//
//  Created by fic on 2018/10/30.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "SelectViewController.h"
#define Width (ScreenWidth-16*2)
#define heigth 390
@interface SelectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *leftTableView;
@property (strong, nonatomic) UITableView *rightTableView;
@property(nonatomic,strong)NSArray *leftTitles;
@property(nonatomic,strong)NSArray *leftImages;
@property(nonatomic,strong)NSArray *rightTitles;
@property(nonatomic,strong)NSArray *rightImages;
@property(nonatomic,strong)NSArray *rightSubTitles;
@property(nonatomic,assign)SelectViewController_selectType selectType;
@end

@implementation SelectViewController
-(instancetype)init{
    self = [super init];
    if (self) {
        self.view.backgroundColor = RGBA(0, 0, 0, 0.5);
        self.parentViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;

    }
    return self;
}
-(void)setData{
    _leftTitles = @[@"BTC",@"FIC",@" "];
    _leftImages = @[@"btc",@"fic",@"close"];
    
    _rightTitles = @[@"BTC",@"ETH",@"BCH",@"USDT",@"FIC"];
    _rightImages = @[@"btc",@"eth",@"bch",@"usdt",@"fic"];
    _rightSubTitles = @[@"Bitcoin",@"Ethereum",@"Bitcoin Cash",@"Tether",@"FilmChain(1895)"];
    
    _selectType = SelectViewController_Up;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    // Do any additional setup after loading the view from its nib.
}
-(UITableView *)leftTableView{
    if (nil == _leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(16, ScreenHeight/2-heigth/2, Width*0.4, heigth) style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏分割线
        _leftTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];//隐藏多余的cell
    }
    return _leftTableView;
}

-(UITableView *)rightTableView{
    if (nil == _rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(16 + Width*0.4, ScreenHeight/2-heigth/2, Width*0.6, heigth) style:UITableViewStylePlain];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏分割线
        _rightTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];//隐藏多余的cell
    }
    return _rightTableView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == _leftTableView) {
        return 0;
    }else{
        return 5;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTableView) {
        return 100;
    }else{
        return 60;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 5)];
    view.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    return view;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == _leftTableView) {
        return 1;
    }else{
        return _rightTitles.count;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _leftTableView) {
        return _leftImages.count;
    }else{
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTableView) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftCell"];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(tableView.frame.size.width/2 - 30/2, 50 - 30, 30, 30)];
        imageV.tag = 10;
        imageV.image = [UIImage imageNamed:_leftImages[indexPath.row]];
        [cell addSubview:imageV];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(tableView.frame.size.width/2 - 100/2, 50, 100, 20)];
        label.tag = 20;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = _leftTitles[indexPath.row];
        [cell addSubview:label];
        if (_leftSelectIndex == indexPath.row) {
            [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"rightCell"];
        cell.imageView.image = [UIImage imageNamed:_rightImages[indexPath.section]];
        cell.textLabel.text = _rightTitles[indexPath.section];
        cell.detailTextLabel.text = _rightSubTitles[indexPath.section];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        if (indexPath.section == self.rightSelectIndex) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTableView) {
        
        _leftSelectIndex = indexPath.row;
        if (indexPath.row == 0) {
            _selectType = SelectViewController_Up;
            _rightSelectIndex = 0;
            [self.rightTableView reloadData];
        }else if (indexPath.row == 1){
            _selectType = SelectViewController_Up;
            _rightSelectIndex = _rightTitles.count - 1;
            [self.rightTableView reloadData];
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }else{
        UITableViewCell *leftCell = [self.leftTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_leftSelectIndex inSection:0]];
        UIImageView *imageView = [leftCell viewWithTag:10];
        imageView.image = [UIImage imageNamed:_rightImages[indexPath.section]];
        UILabel *label = [leftCell viewWithTag:20];
        label.text = _rightTitles[indexPath.section];
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_rightSelectIndex]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        
        UITableViewCell *cell2 = [tableView cellForRowAtIndexPath:indexPath];
        cell2.accessoryType = UITableViewCellAccessoryCheckmark;
        
        _rightSelectIndex = indexPath.section;
        
        if (_delegate && [_delegate respondsToSelector:@selector(controller:selectType:content:)]) {
            [_delegate controller:self selectType:_selectType content:_rightTitles[indexPath.section]];
        }
        
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
