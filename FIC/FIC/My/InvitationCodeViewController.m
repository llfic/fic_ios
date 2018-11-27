//
//  InvitationCodeViewController.m
//  FIC
//
//  Created by fic on 2018/11/12.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "InvitationCodeViewController.h"

@interface InvitationCodeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation InvitationCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)setTable{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //    self.tableView.backgroundColor = DefaultBgColor;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0);//设置分割线长度
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏分割线
    //    [self.tableView registerNib:[UINib nibWithNibName:FilmCell_Name bundle:nil] forCellReuseIdentifier:FilmCell_Identifier];
    //    [self.tableView registerClass:[FilmCell class] forCellReuseIdentifier:FilmCell_Identifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];//隐藏多余的cell
    //    self.tableView.scrollEnabled = NO;//table不能滚动
    self.tableView.tableHeaderView = [self createTableHeadView];
    //    self.tableView.bounces = NO;
}
-(UIView *)createTableHeadView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    
    UIImage *image = [UIImage imageNamed:@"mall_top_bg"];
    CGFloat height = (image.size.height/image.size.width)*ScreenWidth;
    
    // 顶部背景
    UIImageView *topImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height)];
    topImgV.image = image;
    [view addSubview:topImgV];
    
    
    // 四个 button
    NSArray *titles = @[@"手办",@"3C配件",@"生活",@"服饰",@"电影原著"];
    
    return view;
}

@end
