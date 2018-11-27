//
//  PersonViewController.m
//  fic
//
//  Created by fic on 2018/10/24.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "PersonViewController.h"
#import "GestureLockViewController.h"
//#import "UINavigationBar+Awesome.h"
#import "SettingViewController.h"
#import "ZZWDataSaver.h"
#import "ZZWTool.h"
//#import "TabBarViewController.h"
#import "RechargeStyleViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "NetworkCenter.h"
#import "ZZWHudHelper.h"
#import "CustomerServiceViewController.h"


#define HoriztonalCount 3


@interface PersonViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate >
    @property (weak, nonatomic) IBOutlet UITableView *tableView;
    @property(nonatomic,strong)NSArray *titles;
    @property(nonatomic,strong)NSArray *subTitles;
    @property(nonatomic,strong)UIView *fuctionView;
    @property(nonatomic,strong)NSArray *images;
    @property(nonatomic,strong)UIView *headView;

@end

@implementation PersonViewController
-(void)setNavi{
    //    self.view.backgroundColor = [UIColor blackColor];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(0, 0, 40, 40);
    [button2 setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(rightItemPress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItme = [[UIBarButtonItem alloc] initWithCustomView:button2];
    //        UIBarButtonItem *rightItme = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"xiaoxi-ICON-shouye"] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemPress:)];
    //
    self.navigationItem.rightBarButtonItem = rightItme;
}
-(void)setData{
    _titles = @[@"FIC",@"积分",@"客服",@"体验卷",@"待付款",@"待发货",@"退款",@"收货地址"];
    _subTitles = @[@"FIC充值",@"我的积分",@"联系我们",@"我的体验卷",@"订单待付款",@"订单待发货",@"办理退款",@"我的地址"];
    _images = @[@"yu e",@"jifen",@"tiyanjuan",@"tiyanjuan",@"tiyanjuan",@"jifen",@"daifahuo",@"tuikuan",@"address"];
}
- (void)setTable{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //    self.tableView.backgroundColor = DefaultBgColor;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0);//设置分割线长度
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏分割线
    //    [self.tableView registerNib:[UINib nibWithNibName:CoinInfoCell_NAME bundle:nil] forCellReuseIdentifier:CoinInfoCell_IDNETIFIER];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];//隐藏多余的cell
    //    self.tableView.scrollEnabled = NO;//table不能滚动
    self.tableView.contentOffset = CGPointMake(0, -self.navigationController.navigationBar.frame.size.height);
    self.tableView.bounces = NO;
    //    self.view.backgroundColor = DefaultBgColor;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //tableview 从屏幕顶部开始布局，而不是导航栏底部
    self.extendedLayoutIncludesOpaqueBars = YES;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

-(void)rightItemPress:(UIButton *)button{
    SettingViewController *vc = [SettingViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
   
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor clearColor];
    
    /*
     self.navigationItem.title = @"my title"; sets navigation bar title.
     self.tabBarItem.title = @"my title"; sets tab bar title.
     self.title = @"my title"; sets both of these.
     [self.navigationController.navigationItem setTitle:@""]; 无用的
     */
    self.navigationItem.title = @"";// 去掉导航栏标题
    self.navigationController.navigationBar.hidden = NO;
    [ZZWTool setNavigation:self.navigationController clear:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [ZZWTool setNavigation:self.navigationController TitleHidden:NO];
}


-(UIView *)fuctionView{
    
    if (nil == _fuctionView) {
//        UIImage * headImage = [UIImage imageNamed:@"touxiang"];
        
        
        UIImage *image = [UIImage imageNamed:@"img"];
        CGSize size = image.size;
        CGFloat height = (size.height/size.width)*ScreenWidth;
        
        CGFloat margin = 16;
        CGFloat width = ScreenWidth - margin*2;
        _fuctionView = [[UIView alloc] initWithFrame:CGRectMake(margin, height - 50, width, 300)];
        _fuctionView.layer.cornerRadius = 10.0f;
        _fuctionView.layer.masksToBounds = YES;
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;//垂直流布局
        layout.itemSize = CGSizeMake(width/HoriztonalCount -1, 100);
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        CGRect frame = CGRectMake(0, 0, width, _fuctionView.frame.size.height);
        UICollectionView *collect = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        collect.backgroundColor = [UIColor whiteColor];
        collect.delegate = self;
        collect.dataSource = self;
        [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
        [_fuctionView addSubview:collect];

    }
    return _fuctionView;
}
    
-(UIView *)headView{
    if (nil == _headView) {
        
        CGFloat originY = self.navigationController.navigationBar.frame.size.height + 20;
        if (ScreenWidth == 320) {
            originY = self.navigationController.navigationBar.frame.size.height;
        }
        // 根据图片计算高度
        UIImage *image = [UIImage imageNamed:@"img"];
        CGSize size = image.size;
        CGFloat height = (image.size.height/image.size.width)*ScreenWidth;
        
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height)];
        
        UIImageView *bgImgV = [[UIImageView alloc] initWithFrame:_headView.bounds];
        bgImgV.image = image;
        [_headView addSubview:bgImgV];
        
        image = [UIImage imageNamed:@"touxiang"];
        size = image.size;
        UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2 - size.width/2, originY, size.width, size.height)];
        headImage.image = image;
        [_headView addSubview:headImage];
        
        ZZWDataSaver *saver = [ZZWDataSaver shareManager];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, headImage.frame.origin.y + headImage.frame.size.height + 20, ScreenWidth, 20)];
        label.text = saver.phoneNumber;
        label.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:label];
        
    }
    return _headView;
}
    

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return ScreenHeight;
    
}
    
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    //整个head背景
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, ScreenHeight)];
    view.backgroundColor = DefaultBgColor;
    
    [view addSubview:self.headView];
    [view addSubview:self.fuctionView];
    
    return view;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
    
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _titles.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = ScreenWidth - DefaultMargin*2;
    UIImage *image = [UIImage imageNamed:_images[indexPath.item]];
    CGSize size = image.size;
    
    //图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width/(HoriztonalCount*2) - size.width/2, 10, size.width, size.height)];
    imageView.image = image;
    [cell.contentView addSubview:imageView];
    
    // title
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width/(HoriztonalCount*2) - 100/2, imageView.frame.origin.y + imageView.frame.size.height + 10, 100, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.text = _titles[indexPath.item];
    [cell.contentView addSubview:label];
    
    // subtitle
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(width/(HoriztonalCount*2) - 100/2, label.frame.origin.y + label.frame.size.height + 10, 100, 20)];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:12];
    label2.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    label2.text = _subTitles[indexPath.item];
    [cell.contentView addSubview:label2];
    

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 0) {
//        /*
//         第一次设置收拾的时候，需要验证一次。此后除非退出app重新进入，否则不再需要验证手势锁
//         */
//        self.navigationController.navigationBar.hidden = YES;
//        ZZWDataSaver *saver = [ZZWDataSaver shareManager];
//        if (saver.gesture == nil) {
//            GestureLockViewController *vc = [GestureLockViewController new];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
//        }else{
//            if (saver.hadExist == YES) {
//                GestureLockViewController *vc = [GestureLockViewController new];
//                vc.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:vc animated:YES];
//            }else{
//                RechargeStyleViewController *vc = [RechargeStyleViewController new];
//                vc.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//        }
        RechargeStyleViewController *vc = [RechargeStyleViewController new];
        vc.title = @"FIC充值";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.item == 1){
        
    }
    else if (indexPath.item == 2){
        CustomerServiceViewController *vc = [CustomerServiceViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        [super showHudWithType:NotOpen];
    }
    NSLog(@"didSelectItemAtIndexPath");
    
}

@end
