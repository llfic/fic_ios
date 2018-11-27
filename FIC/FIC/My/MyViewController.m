//
//  MyViewController.m
//  FIC
//
//  Created by fic on 2018/11/12.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "MyViewController.h"
#import "ZZWDataSaver.h"
#import "ZZWTool.h"
#import "RechargeStyleViewController.h"
#import "UITableViewCell+SectionCorner.h"
#import "SettingViewController.h"
#import "CustomerServiceViewController.h"
//#import "GroupShadowTableView.h"
#import "MyInfoViewController.h"
#import "InvestRecordViewController.h"


@interface MyViewController ()<UITableViewDelegate, UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *sectionTitles;
@property(nonatomic,strong)NSArray *sectionImages;
@property(nonatomic,strong)UIImageView *headImgV;
@property(nonatomic,strong)UILabel *nicknameLbl;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.NaviStyle = DefaultNaviWithoutBack;
    //tableview 从屏幕顶部开始布局，而不是导航栏底部
//    self.extendedLayoutIncludesOpaqueBars = YES;
//    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        self.edgesForExtendedLayout = UIRectEdgeTop;//保证tableview底部不被tabbar遮挡
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   UIImage * image = [UIImage imageNamed:@"touxiang"];
    if ([ZZWTool getPictureWithPath:Head name:Head]) {
        image = [ZZWTool getPictureWithPath:Head name:Head];
    }
    
    self.headImgV.image = image;
    
    if ([ZZWDataSaver shareManager].nickname != nil) {
        _nicknameLbl.text = [ZZWDataSaver shareManager].nickname;
    }
}
-(void)setData{
//    NSArray *sectionArr = @[@"待付款",@"待发货",@"收货地址",@"退款"];
    NSArray *section2Arr = @[@"投资记录",@"客服",@"设置"];
//    NSArray *section3Arr = @[@"体验劵"];
    _sectionTitles = @[section2Arr];
    
//    NSArray *sectionImgArr = @[@"my_daifukuan",@"my_daifahuo",@"my_dizhi",@"my_tuikuan"];
    NSArray *sectionImg2Arr = @[@"icon_touzijil",@"icon_kefu",@"icon_shezhi"];
    _sectionImages = @[sectionImg2Arr];
}

-(void)setNavi{
//    //    self.view.backgroundColor = [UIColor blackColor];
//    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button2.frame = CGRectMake(0, 0, 40, 40);
//    [button2 setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
//    [button2 addTarget:self action:@selector(rightItemPress:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightItme = [[UIBarButtonItem alloc] initWithCustomView:button2];
//
//
//    self.navigationItem.rightBarButtonItem = rightItme;

}




-(void)setTable{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    _tableView.showSeparator = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0);//设置分割线长度
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏分割线
    //    [self.tableView registerNib:[UINib nibWithNibName:FilmCell_Name bundle:nil] forCellReuseIdentifier:FilmCell_Identifier];
    //    [self.tableView registerClass:[FilmCell class] forCellReuseIdentifier:FilmCell_Identifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];//隐藏多余的cell
    //    self.tableView.scrollEnabled = NO;//table不能滚动
    self.tableView.tableHeaderView = [self createTableHeadView];
    self.tableView.bounces = NO;
}
-(UIView *)createTableHeadView{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    CGFloat naviHeight =  44+[[UIApplication sharedApplication] statusBarFrame].size.height;
    if (ScreenHeight >= 812) {
        naviHeight = 68+[[UIApplication sharedApplication] statusBarFrame].size.height;
    }
    UIImage *image = [UIImage imageNamed:@"touxiang"];
    CGSize size = image.size;
    
    
//    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, size.height + naviHeight + 80)];
//    view.userInteractionEnabled = YES;
//    view.image = [UIImage imageNamed:@"my_headBg"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, size.height + 120 )];
//    view.backgroundColor = [UIColor redColor];
//    [view addSubview:view];
    
    CGFloat originY = 0;
    if (ScreenHeight >= 812) {
        originY = 100;
    }
    CGFloat originX = 16;
    CGFloat space = 8;
    
    UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, size.height)];
    [view addSubview:topBgView];
    //昵称
    _nicknameLbl = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY + 10, 200, 20)];
    _nicknameLbl.text = @"新手报到";
    if ([ZZWDataSaver shareManager].nickname != nil) {
        _nicknameLbl.text = [ZZWDataSaver shareManager].nickname;
    }
    _nicknameLbl.font = [UIFont fontWithName:FontNameBold size:FontMax.pointSize];
    _nicknameLbl.textColor = BlackColor;
    [topBgView addSubview:_nicknameLbl];
    
    ZZWDataSaver *saver = [ZZWDataSaver shareManager];
    //手机号
    UILabel *phoneLbl = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY + 40 , 200, 20)];
    NSString *phoneStr = [saver.phoneNumber stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    phoneLbl.text = [NSString stringWithFormat:@"%@",phoneStr];
    phoneLbl.font = FontSmall;
    phoneLbl.textColor = TextMidGray;
    [topBgView addSubview:phoneLbl];
    
    
    //右箭头
    UIImage * image2 = [UIImage imageNamed:@"icon_jiantou"];
    CGFloat originY2 = originY + image.size.height/2 - image2.size.height/2;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(ScreenWidth - originX -image2.size.width, originY2 , image2.size.width,image2.size.height);
//    [button setBackgroundImage:image2 forState:UIControlStateNormal];
    [button setImage:image2 forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pushPersonInfo:) forControlEvents:UIControlEventTouchUpInside];
    [topBgView addSubview:button];
    
    // 头像
    image = [UIImage imageNamed:@"touxiang"];
    size = image.size;
    if ([ZZWTool getPictureWithPath:Head name:Head]) {
        image = [ZZWTool getPictureWithPath:Head name:Head];
    }
    _headImgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-originX-image2.size.width - space - size.width, originY, size.width, size.height)];
    _headImgV.image = image;
    _headImgV.layer.cornerRadius = size.height/2;
    _headImgV.layer.masksToBounds = YES;
    [topBgView addSubview:_headImgV];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkPersonInfo)];
    [topBgView addGestureRecognizer:tap];
    
//    UIImageView *rightImgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - originX - image2.size.width, originY2 , image2.size.width, image2.size.height)];
//    rightImgV.image = image2;
//    [view addSubview:rightImgV];
    
    // 余额的背景
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY + size.height + space , ScreenWidth - originX*2, 80)];
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(originX, originY + size.height + space , ScreenWidth - originX*2, 90)];
    bgView.userInteractionEnabled = YES;
    bgView.image = [UIImage imageNamed:@"bg_gerenzx"];
        //阴影
//    bgView.layer.shadowColor = BlackColor.CGColor;
//    bgView.layer.shadowOffset = CGSizeZero;
//    bgView.layer.shadowOpacity = ShadowOpacity;
//    bgView.layer.shadowRadius = ViewCorner*2;
    bgView.layer.cornerRadius = ViewCorner;
    bgView.layer.masksToBounds = YES;
//    bgView.backgroundColor = WhiteColor;
//    bgView.layer.borderWidth = BorderWidth;
//    bgView.layer.borderColor = WhiteColor.CGColor;
    
    
    //FIC
    UIImageView *ficIcon = [[UIImageView alloc] initWithFrame:CGRectMake(DefaultMargin, DefaultMargin, 20, 20)];
    ficIcon.image = [UIImage imageNamed:@"icon_jinbi"];
    [bgView addSubview:ficIcon];
    
    UILabel *FICLbl = [[UILabel alloc] initWithFrame:CGRectMake(DefaultMargin + 20 + 8, DefaultMargin, bgView.frame.size.width, 20)];
    FICLbl.text = [NSString stringWithFormat:@"FIC余额"];
    FICLbl.font = [UIFont fontWithName:FontNameBold size:FontMax.pointSize];
    FICLbl.textAlignment = NSTextAlignmentLeft;
    FICLbl.textColor = WhiteColor;
    [bgView addSubview:FICLbl];
    
    UILabel *FICNumLbl = [[UILabel alloc] initWithFrame:CGRectMake(DefaultMargin + 20 + 8, FICLbl.frame.origin.y + FICLbl.frame.size.height, 50, 20)];
    FICNumLbl.text = [NSString stringWithFormat:@"0个"];
    FICNumLbl.textColor = WhiteColor;
    FICNumLbl.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:FICNumLbl];
    
    //立即充值
    UIButton *rechageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rechageBtn.frame = CGRectMake(bgView.frame.size.width - 100 - DefaultMargin, bgView.frame.size.height/2 -44/2, 100, 44);
    [rechageBtn setTitle:@"立即充值" forState:UIControlStateNormal];
    [rechageBtn setBackgroundImage:[UIImage imageNamed:@"nav_lijicz"] forState:UIControlStateNormal];
    rechageBtn.titleLabel.font = FontSmall;
    rechageBtn.layer.cornerRadius = rechageBtn.frame.size.height/2;
    [rechageBtn addTarget:self action:@selector(rechargeAction:) forControlEvents:UIControlEventTouchUpInside];
    rechageBtn.layer.masksToBounds = YES;
    [bgView addSubview:rechageBtn];
//    view.frame = CGRectMake(0, 0, ScreenWidth, headImage.frame.size.height + 80 + self.navigationController.navigationBar.frame.size.height);
    [view addSubview:bgView];
    
    return view;
}
-(void)checkPersonInfo{
    MyInfoViewController *vc = [MyInfoViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)pushPersonInfo:(UIButton *)button{
    MyInfoViewController *vc = [MyInfoViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)rechargeAction:(UIButton *)button{
    RechargeStyleViewController *vc = [RechargeStyleViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark delegate datasource


#pragma mark table
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sectionTitles.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *sectionArr = _sectionTitles[section];
    return sectionArr.count;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//        NSArray *arr = _sectionTitles[indexPath.section];
//        static NSString *identifier = @"reuseIdentifer";
//        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
////        CommodityModel *model = _likeArr[indexPath.row];
//
//        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
//        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//垂直流布局
//        //        layout.headerReferenceSize = CGSizeMake(10, model.size.height*2);
//        //        layout.footerReferenceSize = CGSizeMake(10, model.size.height*2);
//        layout.itemSize = CGSizeMake((ScreenWidth -20)/arr.count, 80);
//        layout.minimumLineSpacing = 5;
//        layout.minimumInteritemSpacing = 1;
//        UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth - 20, 80) collectionViewLayout:layout];
//        collect.backgroundColor = [UIColor whiteColor];
//        collect.tag = 200 + indexPath.row;
//        collect.delegate = self;
//        collect.dataSource = self;
//        collect.scrollEnabled = NO;//关闭滚动
//        collect.showsHorizontalScrollIndicator = NO;//隐藏水平滚动条
//        [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId3"];
//        [cell.contentView addSubview:collect];
//
//
//        return cell;
//
//    }else{

        static NSString *identifier = @"reuseIdentifer";
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.imageView.image = [UIImage imageNamed:_sectionImages[indexPath.section][indexPath.row]];
        cell.textLabel.text = _sectionTitles[indexPath.section][indexPath.row];
    //    cell.detailTextLabel.text = _sectionSubArr[indexPath.section][indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

//        [cell addSectionCornerWithTableView:tableView indexPath:indexPath cornerViewframe:CGRectMake(8, 0, self.view.frame.size.width - 8*2, 44) cornerRadius:5];
    //    UIImage *image = [UIImage imageNamed:@"my_cellBg"];
    //    cell.contentView.backgroundColor = [UIColor colorWithPatternImage:image];
        return cell;
//    }
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 15;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
//    bgView.backgroundColor = [UIColor clearColor];
//    return bgView;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        InvestRecordViewController *vc = [InvestRecordViewController new];
//        vc.title = @"FIC充值";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        CustomerServiceViewController *vc = [CustomerServiceViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 2){
        SettingViewController *vc = [SettingViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        [super showHudWithType:NotOpen];
    }

}

#pragma mark collection
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *arr = _sectionImages[0];
    return arr.count;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *images = _sectionImages[0];
    NSArray *titles = _sectionTitles[0];
    CGFloat width = (ScreenWidth -20 - 30)/images.count;
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId3" forIndexPath:indexPath];
    
    UIImage *image = [UIImage imageNamed:images[indexPath.item]];
    CGFloat imageWidth = 20;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width/2 - imageWidth/2, 10, imageWidth, imageWidth)];
    imageView.image = image;
    [cell.contentView addSubview:imageView];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0,10 + imageWidth  + 10, width, 20)];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.font = [UIFont systemFontOfSize:14];
    titleLbl.text = titles[indexPath.item];
    [cell.contentView addSubview:titleLbl];
    
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.item);
    [super showHudWithType:NotOpen];
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
