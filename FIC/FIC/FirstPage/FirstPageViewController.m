//
//  FirstPageViewController.m
//  FIC
//
//  Created by fic on 2018/10/24.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "FirstPageViewController.h"
#import "FilmCell.h"
#import "FilmModel.h"
#import "ZZWTool.h"
#import "EMMallSectionView.h"
#import "MovieAreaViewController.h"
#import "EMMallSectionView.h"
#import "MovieDetailViewController.h"
#import "FilmInfoModel.h"
#import "MovieDetailViewModel.h"
#import "ZZWDataSaver.h"
#import "FilmCollectionCell.h"

#import "WCQRCodeVC.h"
#import <AVFoundation/AVFoundation.h>

@interface FirstPageViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,WCQRCodeVCDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *titles;
//@property(nonatomic,strong)NSArray *filmTypes;
//@property(nonatomic,strong)NSArray *cellImages;
@property(nonatomic,strong)NSArray *adImges;
@property(nonatomic,strong)NSArray *filmInfoArr;
@end

@implementation FirstPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.NaviStyle = DefaultNaviWithoutBack;
    
    
//    //tableview 从屏幕顶部开始布局，而不是导航栏底部
//    self.extendedLayoutIncludesOpaqueBars = YES;
//    if (@available(iOS 11.0, *)) {
//
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        self.edgesForExtendedLayout = UIRectEdgeTop;//保证tableview底部不被tabbar遮挡
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
}

-(void)setData{
    
//    _titles = @[@"人间-喜剧",@"疯狂的外星人",@"孤战",@"唐人街探案3",@"灌篮高手的契约",@"紧急救援",@"没头脑和不高兴的奇妙之旅",@"猎魔行动",@"债囧之愤怒的小强",@"战狼3",@"索马里行动"].mutableCopy;
    _titles = @[@"人间-喜剧",@"疯狂的外星人",@"孤战",@"唐人街探案3",@"灌篮高手的契约",@"紧急救援",@"没头脑和不高兴的奇妙之旅",@"猎魔行动",@"债囧之愤怒的小强",@"战狼3",@"索马里行动",@"一出好戏",@"李茶的姑妈"].mutableCopy;
    
    ZZWDataSaver *saver = [ZZWDataSaver shareManager];
    [saver createFilmInfoDB];
    _filmInfoArr = [saver queryFilmInfosWithFilmNames:_titles.copy];
    if (_filmInfoArr.count == 0) {
        NSArray * cellImages = @[@"renjian",@"fengkuang",@"guzhan",@"tangrenjie",@"guanlangaoshou",@"jinjiyuanjiu",@"meitounao",@"liemo",@"zhaijiong",@"zhanlang",@"suomali",@"yichuhaoxi",@"licha"];
//        NSArray * cellImages = @[@"renjian",@"fengkuang",@"guzhan",@"tangrenjie",@"guanlangaoshou",@"jinjiyuanjiu",@"meitounao",@"liemo",@"zhaijiong",@"zhanlang",@"suomali"];
//        NSArray * filmTypes = @[@"类型：喜剧、搞笑",@"类型：动作、情怀",@"类型：喜剧、搞笑",@"类型：动作、情怀",@"类型：喜剧、动作、冒险",@"类型：青春、动作、冒险",@"类型：动作、冒险",@"类型：喜剧、搞笑",@"类型：喜剧、搞笑",@"类型：喜剧、搞笑",@"类型：动作、热血"];
        NSArray * filmTypes = @[@"类型：喜剧、搞笑",@"类型：动作、情怀",@"类型：喜剧、搞笑",@"类型：动作、情怀",@"类型：喜剧、动作、冒险",@"类型：青春、动作、冒险",@"类型：动作、冒险",@"类型：喜剧、搞笑",@"类型：喜剧、搞笑",@"类型：喜剧、搞笑",@"类型：动作、热血",@"类型：动作、冒险",@"类型：动作、情怀"];
//        NSArray * totalCountArr = @[@"2",@"3",@"0.8",@"4",@"1.5",@"5",@"1.5",@"3",@"1.5",@"5",@"5"];
        NSArray * totalCountArr = @[@"2",@"3",@"0.8",@"4",@"1.5",@"5",@"1.5",@"3",@"1.5",@"5",@"5",@"2",@"1.8"];
//        NSArray * openCountArr = @[@"600",@"1400",@"3000",@"5000",@"3000",@"5000",@"3000",@"3000",@"3000",@"5000",@"6000"];
        NSArray * openCountArr = @[@"600",@"1400",@"3000",@"5000",@"3000",@"5000",@"3000",@"3000",@"3000",@"5000",@"6000",@"1000",@"2000"];
//        NSArray * percentArr = @[@"100.0",@"0.0",@"0.0",@"0.0",@"0.0",@"0.0",@"0.0",@"0.0",@"0.0",@"0.0",@"0.0"];
        NSArray * percentArr = @[@"100.0",@"0.0",@"0.0",@"0.0",@"0.0",@"0.0",@"0.0",@"0.0",@"0.0",@"0.0",@"0.0",@"100.0",@"100.0"];
//        NSArray *statusArr = @[@"已杀青",@"已杀青",@"已杀青",@"待开机",@"待开机",@"待开机",@"待开机",@"待开机",@"待开机",@"待开机",@"待开机"];
        NSArray *statusArr = @[@"已杀青",@"已杀青",@"已杀青",@"待开机",@"待开机",@"待开机",@"待开机",@"待开机",@"待开机",@"待开机",@"待开机",@"已上映",@"已上映"];
        for (NSInteger i = 0; i < _titles.count; i++) {
            FilmModel *model = [FilmModel new];
            model.name = _titles[i];
            model.image = cellImages[i];
            model.status = statusArr[i];
            model.type = filmTypes[i];
            model.totalNum = totalCountArr[i];
            model.openNum = openCountArr[i];
            model.percent = percentArr[i];
            [saver addFilmModel:model];
        }
        _filmInfoArr = [saver queryFilmInfosWithFilmNames:_titles.copy];
    }
    

}
-(void)setNavi{
    UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanBtn addTarget:self action:@selector(scanAction:) forControlEvents:UIControlEventTouchUpInside];
    [scanBtn setImage:[UIImage imageNamed:@"icon_saoma_sy"] forState:UIControlStateNormal];
//    [scanBtn setTitle:@"扫描" forState:UIControlStateNormal];
    [scanBtn setTitleColor:BlackColor forState:UIControlStateNormal];
    
    [scanBtn sizeToFit];
    UIBarButtonItem *scanItem = [[UIBarButtonItem alloc] initWithCustomView:scanBtn];
    
    
//    UIBarButtonItem *fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    fixedSpaceBarButtonItem.width = 15;
//
//
//    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [settingBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
//    [settingBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
//    [settingBtn sizeToFit];
//    UIBarButtonItem *settingBtnItem = [[UIBarButtonItem alloc] initWithCustomView:settingBtn];
    
         self.navigationItem.rightBarButtonItems  = @[scanItem];
//    self.navigationItem.rightBarButtonItems  = @[informationCardItem,fixedSpaceBarButtonItem,settingBtnItem];
//
    UIButton *settingBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [settingBtn2 addTarget:self action:@selector(locationAction:) forControlEvents:UIControlEventTouchUpInside];
    [settingBtn2 setTitle:@"首页" forState:UIControlStateNormal];
    [settingBtn2 setTitleColor:TextBlack forState:UIControlStateNormal];
    //    [settingBtn2 setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
//    [settingBtn2 setImage:[UIImage imageNamed:@"dingwei"] forState:UIControlStateNormal];
    [settingBtn2 sizeToFit];
    UIBarButtonItem *settingBtnItem2 = [[UIBarButtonItem alloc] initWithCustomView:settingBtn2];
    self.navigationItem.leftBarButtonItem = settingBtnItem2;
}
-(void)setTable{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //    self.tableView.backgroundColor = DefaultBgColor;
//    self.tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0);//设置分割线长度
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏分割线
    [self.tableView registerNib:[UINib nibWithNibName:FilmCell_Name bundle:nil] forCellReuseIdentifier:FilmCell_Identifier];
    //    [self.tableView registerClass:[FilmCell class] forCellReuseIdentifier:FilmCell_Identifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];//隐藏多余的cell
    //    self.tableView.scrollEnabled = NO;//table不能滚动
    self.tableView.tableHeaderView = [self createTableHeadView];
    //    self.tableView.bounces = NO;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.NaviStyle = ClearNavi;
}

- (void)QRCodeScanVC:(UIViewController *)scanVC {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (status) {
            case AVAuthorizationStatusNotDetermined: {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [self.navigationController pushViewController:scanVC animated:YES];
                        });
                        NSLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);
                    } else {
                        NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                    }
                }];
                break;
            }
            case AVAuthorizationStatusAuthorized: {
                [self.navigationController pushViewController:scanVC animated:YES];
                break;
            }
            case AVAuthorizationStatusDenied: {
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertC addAction:alertA];
                [self presentViewController:alertC animated:YES completion:nil];
                break;
            }
            case AVAuthorizationStatusRestricted: {
                NSLog(@"因为系统原因, 无法访问相册");
                break;
            }
                
            default:
                break;
        }
        return;
    }
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:alertA];
    [self presentViewController:alertC animated:YES completion:nil];
}
-(UIView *)createTableHeadView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    
    UIImage *image = [UIImage imageNamed:@"topBg"];
    CGFloat height = (image.size.height/image.size.width)*(ScreenWidth -DefaultMargin*2);
    
    // 顶部背景
    UIImageView *topImgV = [[UIImageView alloc] initWithFrame:CGRectMake(DefaultMargin, 0, ScreenWidth -DefaultMargin*2, height)];
    topImgV.layer.cornerRadius = ViewCorner;
    topImgV.layer.masksToBounds = YES;
    topImgV.image = image;
    [view addSubview:topImgV];
    
    
//    // 四个 button
//    NSArray *titles = @[@"影视专区",@"票务",@"打赏专区",@"开心一刻"];
//    NSArray *images = @[@"icon-yingshi",@"piaowu",@"dashang",@"kaixin"];
//    image = [UIImage imageNamed:@"piaowu"];
//    for (NSInteger i = 0; i < titles.count; i++) {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake((ScreenWidth/titles.count)*i + (ScreenWidth/titles.count -image.size.width)/2, height + 20, image.size.width, image.size.height);
//        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(actionType:) forControlEvents:UIControlEventTouchUpInside];
//        button.tag = 100 + i;
//        [view addSubview:button];
//
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth/titles.count)*i, button.frame.origin.y  + button.frame.size.height + 8, ScreenWidth/titles.count, 20)];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.font = [UIFont systemFontOfSize:14];
//        label.text = titles[i];
//        [view addSubview:label];
//    }
    
//    CGFloat originY = height + 20 + image.size.height + 20 + 20;
    CGFloat originY = height +10;
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, originY, ScreenWidth, 5)];
//    line.backgroundColor = DefaultBgColor;//table背景色，默认灰色
//    [view addSubview:line];
//
//    originY = line.frame.size.height + line.frame.origin.y;
    _adImges = @[@"yichuhaoxi",@"licha"];
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//垂直流布局
    layout.headerReferenceSize = CGSizeMake(DefaultMargin, 150);
    layout.footerReferenceSize = CGSizeMake(DefaultMargin, 150);
    layout.itemSize = CGSizeMake(280, 130);
    layout.minimumLineSpacing = DefaultMargin;
    layout.minimumInteritemSpacing = 1;
    UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, originY, ScreenWidth, 150) collectionViewLayout:layout];
    collect.backgroundColor = [UIColor whiteColor];
    collect.delegate = self;
    collect.dataSource = self;
    collect.showsHorizontalScrollIndicator = NO;//隐藏水平滚动条
//    [collect registerClass:[FilmCollectionCell class] forCellWithReuseIdentifier:@"FilmCollectionCell_Identifier"];
    [collect registerNib:[UINib nibWithNibName:FilmCollectionCell_Name bundle:nil] forCellWithReuseIdentifier:FilmCollectionCell_Identifier];
    [view addSubview:collect];
//    self.view.backgroundColor = [UIColor whiteColor];
    
    originY = originY + collect.frame.size.height;
    
//    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, originY, ScreenWidth, 5)];
//    line2.backgroundColor = DefaultBgColor;//table背景色，默认灰色
//    [view addSubview:line2];
    
    view.frame = CGRectMake(0, 0, ScreenWidth, originY);
    return view;
}
-(void)actionType:(UIButton *)button{
    if (button.tag == 100) {
        MovieAreaViewController *vc = [MovieAreaViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
-(void)scanAction:(UIButton *)button{
    WCQRCodeVC *WCVC = [[WCQRCodeVC alloc] init];
    WCVC.delegate = self;
    WCVC.hidesBottomBarWhenPushed = YES;
    [self QRCodeScanVC:WCVC];
}
-(void)searchAction:(UIButton *)button{
    
}
-(void)locationAction:(UIButton *)button{
    
}

#pragma mark collection
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _adImges.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FilmCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FilmCollectionCell_Identifier forIndexPath:indexPath];
    if (indexPath.item == 0) {
        FilmModel *model = _filmInfoArr[indexPath.item + 11];
        cell.nameLbl.text = model.name;
        cell.imageView.image = [UIImage imageNamed:_adImges[indexPath.item]];
        cell.costLbl.text = @"成本：2亿元";
        cell.boxOfficeLbl.text = @"票房：13.5亿元";
        cell.returnRadioLbl.text = @"125%";
        cell.statusLbl.text = @"已分红";
        NSLog(@"%ld %ld",indexPath.section,indexPath.row);
    }else if (indexPath.item == 1){
        FilmModel *model = _filmInfoArr[indexPath.item + 11];
        cell.nameLbl.text = model.name;
        cell.imageView.image = [UIImage imageNamed:_adImges[indexPath.item]];
        cell.costLbl.text = @"成本：1.8亿元";
        cell.boxOfficeLbl.text = @"票房：待定";
        cell.returnRadioLbl.text = @"待定";
        cell.statusLbl.text = @"待分红";
        cell.getMoneyImgV.image = nil;
        NSLog(@"%ld %ld",indexPath.section,indexPath.row);
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MovieDetailViewController *vc = [MovieDetailViewController new];
    FilmModel *model = _filmInfoArr[indexPath.item + 11];
    vc.filmName = model.name;
    vc.filmModel = model;
    vc.type = MovieDetailViewController_GetMoney;
    vc.hiddenInvestBtn = YES;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //head不会固定在顶部
    EMMallSectionView *sectionView = [EMMallSectionView setSectionWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    sectionView.tableView = tableView;
    sectionView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(DefaultMargin, 10, ScreenWidth, 20)];
    label.text = @"影视投资";
    label.textAlignment = NSTextAlignmentLeft;
    [sectionView addSubview:label];
    return sectionView;
    
//    // head 会固定在顶部
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
//    view.backgroundColor = DefaultBgColor;//table背景色，默认灰色
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth, 20)];
//    label.text = @"影视投资";
//    label.textAlignment = NSTextAlignmentLeft;
//    [view addSubview:label];
//
//    return view;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titles.count - 2;
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
    cell.name.text = [NSString stringWithFormat:@"%@",_titles[indexPath.row]];
    cell.status.text = model.status;
    cell.type.text = model.type;
    cell.des1.text = model.des1;
    cell.des2.text = model.des2;
    cell.des3.text = model.des3;
    cell.totalCount.text = model.totalCount;
    cell.openCount.text = model.openCount;
    cell.totalNum = [model.totalNum floatValue];
    cell.openNum = [model.openNum floatValue];
//    cell.sellCount.text = model.sellCount;
//    cell.totalNum.text = [NSString stringWithFormat:@"%@亿元",model.totalNum];
//    cell.openNum.text = [NSString stringWithFormat:@"%@万元",model.openNum];
    cell.percent.text = [NSString stringWithFormat:@"%@%%",model.percent];
    cell.percentNum = [model.percent floatValue];
//    cell.textField.placeholder = _titles[indexPath.row];
//    cell.backgroundColor = DefaultBgColor;//table背景色，默认灰色
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieDetailViewController *vc = [MovieDetailViewController new];
    FilmModel *model = _filmInfoArr[indexPath.row];
    vc.filmName = model.name;
    vc.filmModel = model;
    vc.type = MovieDetailViewController_Normal;
    vc.hiddenInvestBtn = NO;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


//-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    if (velocity.y> 0) {
//        self.navigationController.navigationBar.hidden = YES;
//    }else{
//        self.navigationController.navigationBar.hidden = NO;
//    }
//
//}
@end
