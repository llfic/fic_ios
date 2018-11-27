//
//  RechargeStyleViewController.m
//  FIC
//
//  Created by fic on 2018/10/26.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "RechargeStyleViewController.h"
//#import "CoinInfoCell.h"
#import "ZZWTool.h"
#import "GatheringViewController.h"
#import "CoinCollectionCell.h"
//#import "TransactionViewController.h"
#import "ZZWHudHelper.h"

@interface RechargeStyleViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate >
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSArray *subtitles;
@property(nonatomic,strong)NSArray *images;
@property(nonatomic,strong)NSArray *infoArr;

@end

@implementation RechargeStyleViewController
-(void)setData{
//    _titles = @[@"BTC",@"ETH",@"BCH",@"USDT",@"EOS",@"FIC"];
//    _subtitles = @[@"Bitcoin",@"Ethereum",@"Bitcoin Cash",@"Tether",@"EOS",@"FilmChain(1895)"];
//    _images = @[@"btc",@"eth",@"bch",@"usdt",@"eos",@"fic"];
    _titles = @[@"BTC",@"ETH",@"BCH",@"USDT",@"FIC",@"OTHER"];
    _subtitles = @[@"Bitcoin",@"Ethereum",@"Bitcoin Cash",@"Tether",@"FilmChain(1895)",@"人民币"];
    _images = @[@"btc",@"eth",@"bch",@"usdt",@"fic",@"OTHER"];
    
    
    //暂时只有这四种的key
    NSDictionary *btcDic = @{@"name":@"BTC",@"key":@"3KNkvzZHzqeNnpfVBcmysXygZuTeEQPEkJ"};
    NSDictionary *ethDic = @{@"name":@"ETH",@"key":@"0xdba3ff443e3df1a1f1f0885b28565b8e847fb970"};
    NSDictionary *bchDic = @{@"name":@"BCH",@"key":@"3NxcJJ9vTCmCLc56SGPuwYALytWf5zDFPT"};
    NSDictionary *usdtcDic = @{@"name":@"USDT",@"key":@"36TEED8Y97uL6xjxigWKyrR5ZfJaa44nw9"};
    NSDictionary *ficDic = @{@"name":@"FIC",@"key":@"0xdba3ff443e3df1a1f1f0885b28565b8e847fb970"};
    NSDictionary *rmbDic = @{@"name":@"RMB",@"key":@"0xdba3ff443e3df1a1f1f0885b28565b8e847fb970"};//代购协议
    _infoArr = @[btcDic,ethDic,bchDic,usdtcDic,ficDic,rmbDic];
    
    
    //设置collection
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;//垂直流布局
    layout.headerReferenceSize = CGSizeMake(10, 150);
    layout.footerReferenceSize = CGSizeMake(10, 10);
    
    layout.itemSize = CGSizeMake((ScreenWidth - DefaultMargin*3)/2, CoinCollectionCell_Height);
//    layout.itemSize = CGSizeMake(100, 77);
    layout.sectionInset = UIEdgeInsetsMake(0, DefaultMargin, 0, DefaultMargin);
    layout.minimumLineSpacing = DefaultMargin;
    layout.minimumInteritemSpacing = DefaultMargin;
    UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:layout];
    collect.backgroundColor = DefaultBgColor;
    collect.delegate = self;
    collect.dataSource = self;
    [collect registerNib:[UINib nibWithNibName:CoinCollectionCell_Name bundle:nil] forCellWithReuseIdentifier:CoinCollectionCell_Identifier];
    [self.view addSubview:collect];
    
    
    
    // 余额的背景
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(DefaultMargin, 30 , ScreenWidth - DefaultMargin*2, 90)];
    bgView.userInteractionEnabled = YES;
    bgView.image = [UIImage imageNamed:@"bg_gerenzx"];
    bgView.layer.cornerRadius = ViewCorner;
    bgView.layer.masksToBounds = YES;

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


    //折合人民币
    UILabel *priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(bgView.frame.size.width - 200 - DefaultMargin, bgView.frame.size.height/2 -44/2, 200, 44)];
    priceLbl.text = [NSString stringWithFormat:@"折合人民币≈0元"];
    priceLbl.textColor = WhiteColor;
    priceLbl.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:priceLbl];

    
    //提醒文字
    UILabel *remindLbl = [[UILabel alloc] initWithFrame:CGRectMake(0,ScreenHeight - 100,ScreenWidth, 20)];
    remindLbl.text = [self getRemindText];
    remindLbl.textColor = TextGray;
    remindLbl.font = FontSmall;
    remindLbl.textAlignment = NSTextAlignmentRight;
    [collect addSubview:remindLbl];
    
    [collect addSubview:bgView];
}


-(void)setNavi{
    self.NaviStyle = DefaultNavi;
    self.navigationItem.title = @"选择充值方式";
}

-(void)setTable{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [ZZWTool setNavigation:self.navigationController clear:YES];
}
-(NSString *)getRemindText{
    return [NSString stringWithFormat:@"您可以用这%lu种数字货币，给FIC充值。",(unsigned long)_titles.count];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _infoArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CoinCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CoinCollectionCell_Identifier forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:_images[indexPath.item]];
    cell.nameLbl.text = _titles[indexPath.item];
    cell.detailLbl.text = _subtitles[indexPath.item];
    cell.countLbl.text = @"0.00";
    cell.priceLbl.text = @"≈￥0";
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GatheringViewController *vc = [GatheringViewController new];
    vc.infoDic = _infoArr[indexPath.item];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
