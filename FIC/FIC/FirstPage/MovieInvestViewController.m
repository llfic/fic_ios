//
//  MovieInvestViewController.m
//  FIC
//
//  Created by fic on 2018/10/30.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "MovieInvestViewController.h"
#import "FilmCell.h"
#import "FilmModel.h"
#import "ZZWDataSaver.h"
#import "MovieDetailViewController.h"

@interface MovieInvestViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,assign)NSInteger selectIndex;
@property(nonatomic,strong)NSArray *filmInfoArr;
@property(nonatomic,strong)NSArray *cellImages;
@property(nonatomic,strong)NSArray *filmTypes;
@property(nonatomic,strong)NSArray *statusArr;
@end

@implementation MovieInvestViewController
-(void)setData{
    _selectIndex = 100;
    _titles = @[@"一出好戏",@"李茶的姑妈",@"人间-喜剧",@"疯狂的外星人",@"孤战"];
    
    
    ZZWDataSaver *saver = [ZZWDataSaver shareManager];
    [saver createFilmInfoDB];
    _filmInfoArr = [saver queryFilmInfosWithFilmNames:_titles.copy];
    if (_filmInfoArr.count < 9) {
        _cellImages = @[@"yichuhaoxi",@"licha",@"renjian",@"fengkuang",@"guzhan"];
        _filmTypes = @[@"类型：动作、情怀",@"类型：喜剧、搞笑",@"类型：动作、情怀",@"类型：喜剧、搞笑",@"类型：动作、情怀"];
        _statusArr = @[@"已上映",@"待上映",@"已杀青",@"已杀青",@"已杀青"];
        
        NSArray * totalCountArr = @[@"2",@"2",@"1.8",@"3",@"0.8"];
        NSArray * openCountArr = @[@"6000",@"1000",@"2000",@"1400",@"3000"];
        NSArray * percentArr = @[@"100",@"100",@"100",@"0",@"0"];
        for (NSInteger i = 0; i < _titles.count; i++) {
            FilmModel *model = [FilmModel new];
            model.name = _titles[i];
            model.image = _cellImages[i];
            model.status = _statusArr[i];
            model.type = _filmTypes[i];
            model.totalNum = totalCountArr[i];
            model.openNum = openCountArr[i];
            model.percent = percentArr[i];
            [saver addFilmModel:model];
        }
        
        _filmInfoArr = [saver queryFilmInfosWithFilmNames:_titles.copy];
    }
    
    
}

-(void)setTable{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //    self.tableView.backgroundColor = DefaultBgColor;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0);//设置分割线长度
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏分割线
    [self.tableView registerNib:[UINib nibWithNibName:FilmCell_Name bundle:nil] forCellReuseIdentifier:FilmCell_Identifier];
    //    [self.tableView registerClass:[FilmCell class] forCellReuseIdentifier:FilmCell_Identifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];//隐藏多余的cell
    //    self.tableView.scrollEnabled = NO;//table不能滚动
    self.tableView.tableHeaderView = [self createTableHeadView];
    //    self.tableView.bounces = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //tableview 从屏幕顶部开始布局，而不是导航栏底部
//    self.extendedLayoutIncludesOpaqueBars = YES;
//    if (@available(iOS 11.0, *)) {
//        
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
}

-(UIView *)createTableHeadView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    
    UIImage *image = [UIImage imageNamed:@"movieBanner-1"];
    CGFloat height = (image.size.height/image.size.width)*ScreenWidth;
    
    // 顶部背景
    UIImageView *topImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height)];
    topImgV.image = image;
    [view addSubview:topImgV];
    
    
    // 四个 button
    NSArray *titles = @[@"全部",@"正在进行",@"未上映",@"以上映",@"已完成"];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*(ScreenWidth/titles.count), height,ScreenWidth/titles.count,30);
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(actionType:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + i;
        button.titleLabel.font = FontSmall;
        if (ScreenWidth == 320) { // 适配ipod这种小屏幕
            button.titleLabel.font = FontSmallest;
        }
        if (button.tag == _selectIndex) {
            [button setTitleColor:ButtonBg_red forState:UIControlStateNormal];
        }
        [view addSubview:button];
        
    }
    
    
    view.frame = CGRectMake(0, 0, ScreenWidth, height + 30);
    return view;
}
-(void)actionType:(UIButton *)button{
    UIButton *lastBtn = [self.tableView.tableHeaderView viewWithTag:_selectIndex];
    [lastBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _selectIndex = button.tag;
    _titles = @[@"《人间-喜剧》",@"《疯狂外星人》",@"《孤战》"];
    _cellImages = @[@"movieInvestImage_3",@"movieInvestImage_4",@"movieInvestImage_5"];
    _filmTypes = @[@"类型：动作、情怀",@"类型：喜剧、搞笑",@"类型：动作、情怀",@"类型：喜剧、搞笑",@"类型：动作、情怀"];
    _statusArr = @[@"已杀青",@"已杀青",@"已杀青"];
    [self.tableView reloadData];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titles.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    FilmModel *model = _filmInfoArr[indexPath.row];
    UIImage *image = [UIImage imageNamed:model.image];
    
    return image.size.height + 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FilmCell *cell = [tableView dequeueReusableCellWithIdentifier:FilmCell_Identifier forIndexPath:indexPath];
    FilmModel *model = _filmInfoArr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:model.image];
    cell.name.text = [NSString stringWithFormat:@"《%@》",_titles[indexPath.row]];
    cell.status.text = model.status;
    cell.type.text = model.type;
    cell.des1.text = model.des1;
    cell.des2.text = model.des2;
    cell.des3.text = model.des3;
    cell.totalCount.text = model.totalCount;
    cell.openCount.text = model.openCount;
//    cell.sellCount.text = model.sellCount;
//    cell.totalNum.text = [NSString stringWithFormat:@"%@亿元",model.totalNum];
//    cell.openNum.text = [NSString stringWithFormat:@"%@万元",model.openNum];
    cell.percent.text = [NSString stringWithFormat:@"%@%%",model.percent];
    
    //    cell.textField.placeholder = _titles[indexPath.row];
//    cell.backgroundColor = DefaultBgColor;//table背景色，默认灰色
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieDetailViewController *vc = [MovieDetailViewController new];
    vc.filmName = _titles[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
