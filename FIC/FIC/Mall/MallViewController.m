//
//  MallViewController.m
//  FIC
//
//  Created by fic on 2018/10/24.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "MallViewController.h"
#import "ZZWTool.h"
#import "UIButton+ImageTitleSpacing.h"
#import "CommodityModel.h"

@interface MallViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *adImges;
@property(nonatomic,strong)NSArray *topAdImages;
@property(nonatomic,strong)NSMutableArray *likeArr;
@property(nonatomic,strong)NSMutableArray *goodArr;
@end

@implementation MallViewController
-(void)setData{
    _likeArr = [NSMutableArray array];
    _goodArr = [NSMutableArray array];
    NSArray *images = @[@"mall_1_1",@"mall_1_2",@"mall_1_3",@"mall_1_4",@"mall_1_5",@"mall_1_6"];
    NSArray *titles = @[@"长草颜团子动物系列",@"福小喵充电宝",@"豆芽社长水产系列",@"美人鱼家族3代",@"比奇泡泡圈盲盒",@"新西游记秒汉公仔"];
    NSArray *prices = @[@"78JF",@"86JF",@"98JF",@"112JF",@"66JF",@"66JF"];
    for (NSInteger i = 0; i < images.count; i++) {
        CommodityModel *model = [CommodityModel new];
        model.image = images[i];
        model.name = titles[i];
        model.price = prices[i];
        [_likeArr addObject:model];
    }
    
    NSArray *images2 = @[@"mall_2_1",@"mall_2_2",@"mall_2_3",@"mall_2_4",@"mall_2_5",@"mall_2_6"];
    NSArray *titles2 = @[@"小黄人大眼萌手办",@"复仇者联盟3",@"秦雨田2和风穹",@"GSC春酱粘土人",@"绿巨人圆领T恤",@"十一宫千机伞"];
    NSArray *prices2 = @[@"69JF",@"139JF",@"209JF",@"222JF",@"55JF",@"79JF"];
    for (NSInteger i = 0; i < images2.count; i++) {
        CommodityModel *model = [CommodityModel new];
        model.image = images2[i];
        model.name = titles2[i];
        model.price = prices2[i];
        [_goodArr addObject:model];
    }
}
-(void)setNavi{
    UIButton *informationCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [informationCardBtn addTarget:self action:@selector(scanAction:) forControlEvents:UIControlEventTouchUpInside];
    [informationCardBtn setImage:[UIImage imageNamed:@"saomiao"] forState:UIControlStateNormal];
    
    [informationCardBtn sizeToFit];
    UIBarButtonItem *informationCardItem = [[UIBarButtonItem alloc] initWithCustomView:informationCardBtn];
    
    
    UIBarButtonItem *fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceBarButtonItem.width = 15;
    
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [settingBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [settingBtn sizeToFit];
    UIBarButtonItem *settingBtnItem = [[UIBarButtonItem alloc] initWithCustomView:settingBtn];
    
    //     self.navigationItem.rightBarButtonItems  = @[informationCardItem,settingBtnItem];
    self.navigationItem.rightBarButtonItems  = @[informationCardItem,fixedSpaceBarButtonItem,settingBtnItem];
    
    UIButton *settingBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn2 addTarget:self action:@selector(locationAction:) forControlEvents:UIControlEventTouchUpInside];
    [settingBtn2 setTitle:@"深圳" forState:UIControlStateNormal];
    //    [settingBtn2 setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
    [settingBtn2 setImage:[UIImage imageNamed:@"dingwei"] forState:UIControlStateNormal];
    [settingBtn2 sizeToFit];
    UIBarButtonItem *settingBtnItem2 = [[UIBarButtonItem alloc] initWithCustomView:settingBtn2];
    self.navigationItem.leftBarButtonItem = settingBtnItem2;
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
    NSArray *images = @[@"手办图标",@"配件图标",@"生活图标",@"服饰图标",@"原著图标"];
    image = [UIImage imageNamed:@"piaowu"];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((ScreenWidth/titles.count)*i + (ScreenWidth/titles.count -image.size.width)/2, height + 20, image.size.width, image.size.height);
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(actionType:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + i;
        [view addSubview:button];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth/titles.count)*i, button.frame.origin.y  + button.frame.size.height + 8, ScreenWidth/titles.count, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.text = titles[i];
        [view addSubview:label];
    }
    
    CGFloat originY = height + 20 + image.size.height + 20 + 20;
    
    _topAdImages = @[@"红包点击领取",@"限时特价点击进入"];
    image = [UIImage imageNamed:@"红包点击领取"];
    CGSize size = CGSizeMake(ScreenWidth/2 - 30/2, (ScreenWidth/2 - 30/2)*image.size.height/image.size.width);
    UICollectionViewFlowLayout *layout2 = [UICollectionViewFlowLayout new];
    layout2.scrollDirection = UICollectionViewScrollDirectionHorizontal;//垂直流布局
    layout2.headerReferenceSize = CGSizeMake(10, size.height + 10);//分区头
    layout2.footerReferenceSize = CGSizeMake(10, size.height + 10);//分区尾
    layout2.itemSize = CGSizeMake(size.width, size.height);
    layout2.minimumLineSpacing = 10;
    layout2.minimumInteritemSpacing = 1;
    UICollectionView *collect2 = [[UICollectionView alloc] initWithFrame:CGRectMake(0, originY, ScreenWidth, size.height + 10) collectionViewLayout:layout2];
    collect2.backgroundColor = [UIColor whiteColor];
    collect2.tag = 150;
    collect2.delegate = self;
    collect2.dataSource = self;
    collect2.showsHorizontalScrollIndicator = NO;//隐藏水平滚动条
    [collect2 registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId2"];
    [view addSubview:collect2];
    
    
    originY += size.height + 10;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, originY, ScreenWidth, 5)];
    line.backgroundColor = DefaultBgColor;//table背景色，默认灰色
    [view addSubview:line];
    
    originY = line.frame.size.height + line.frame.origin.y;
    _adImges = @[@"mall_adImage"];
    image = [UIImage imageNamed:@"mall_adImage"];
    size = CGSizeMake(ScreenWidth - 20/2, (ScreenWidth - 20/2)*image.size.height/image.size.width);
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//垂直流布局
    layout.headerReferenceSize = CGSizeMake(10, size.height*2 + 40);
    layout.footerReferenceSize = CGSizeMake(10, size.height*2 + 40);
    layout.itemSize = CGSizeMake(size.width, size.height);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 1;
    UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, originY, ScreenWidth, size.height + 20) collectionViewLayout:layout];
    collect.backgroundColor = [UIColor whiteColor];
    collect.tag = 151;
    collect.delegate = self;
    collect.dataSource = self;
    collect.showsHorizontalScrollIndicator = NO;//隐藏水平滚动条
    [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [view addSubview:collect];
    //    self.view.backgroundColor = [UIColor whiteColor];
    
    originY = collect.frame.size.height + collect.frame.origin.y + 10;
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, originY, ScreenWidth, 5)];
    line2.backgroundColor = DefaultBgColor;//table背景色，默认灰色
    [view addSubview:line2];
    
    view.frame = CGRectMake(0, 0, ScreenWidth, originY + 15);
    return view;
}
-(void)actionType:(UIButton *)button{
    if (button.tag == 100) {
//        MovieAreaViewController *vc = [MovieAreaViewController new];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //tableview 从屏幕顶部开始布局，而不是导航栏底部
    self.extendedLayoutIncludesOpaqueBars = YES;
    if (@available(iOS 11.0, *)) {
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.edgesForExtendedLayout = UIRectEdgeTop;//保证tableview底部不被tabbar遮挡
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [ZZWTool setNavigation:self.navigationController clear:YES];
    self.navigationItem.title = @"";
}
#pragma mark action
-(void)scanAction:(UIButton *)button{
    
}
-(void)searchAction:(UIButton *)button{
    
}
-(void)locationAction:(UIButton *)button{
    
}

#pragma mark table
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    
    UILabel *leftLbl = [[UILabel alloc] initWithFrame:CGRectMake(DefaultMargin, 10, 100, 24)];
    if (section == 0) {
        leftLbl.text = @"猜你喜欢";
    }else if (section == 1){
        leftLbl.text = @"新品上架";
    }
    leftLbl.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:leftLbl];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"更多" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"mall_right"] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(ScreenWidth - DefaultMargin - 100, 0, 100, 44);
    [rightBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleRight imageTitleSpace:5];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [bgView addSubview:rightBtn];
    
    return bgView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CommodityModel *model = _likeArr[0];
        return (_likeArr.count/3)*model.size.height + 20;
    }else{
        CommodityModel *model = _goodArr[0];
        return (_goodArr.count/3)*model.size.height + 20;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (indexPath.section == 0) {
        CommodityModel *model = _likeArr[indexPath.row];
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;//垂直流布局
//        layout.headerReferenceSize = CGSizeMake(10, model.size.height*2);
//        layout.footerReferenceSize = CGSizeMake(10, model.size.height*2);
        layout.itemSize = CGSizeMake(model.size.width, model.size.height);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 1;
        UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth - 20, model.size.height*2 + 20) collectionViewLayout:layout];
        collect.backgroundColor = [UIColor whiteColor];
        collect.tag = 200 + indexPath.row;
        collect.delegate = self;
        collect.dataSource = self;
        collect.scrollEnabled = NO;//关闭滚动
        collect.showsHorizontalScrollIndicator = NO;//隐藏水平滚动条
        [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId2"];
        [cell.contentView addSubview:collect];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, model.size.height*2 + 10, ScreenWidth, 10)];
        line.backgroundColor = DefaultBgColor;//table背景色，默认灰色
        [cell.contentView addSubview:line];
        
        
    }else{
        CommodityModel *model = _goodArr[indexPath.row];
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;//垂直流布局
//        layout.headerReferenceSize = CGSizeMake(10, model.size.height*2);
//        layout.footerReferenceSize = CGSizeMake(10, model.size.height*2);
        layout.itemSize = CGSizeMake(model.size.width, model.size.height);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 1;
        UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, model.size.height*2 + 20) collectionViewLayout:layout];
        collect.backgroundColor = [UIColor whiteColor];
        collect.tag = 300 + indexPath.row;
        collect.delegate = self;
        collect.dataSource = self;
        collect.scrollEnabled = NO;//关闭滚动
        collect.showsHorizontalScrollIndicator = NO;//隐藏水平滚动条
        [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId3"];
        [cell.contentView addSubview:collect];
    }
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark collection
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == 150) {
        return _topAdImages.count;
    }else if(collectionView.tag == 151){
        return _adImges.count;
    }else if (collectionView.tag >= 200 && collectionView.tag < 300){
        return _likeArr.count;
    }else{
        return _goodArr.count;
    }
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 150) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId2" forIndexPath:indexPath];
        
        UIImage *image = [UIImage imageNamed:_topAdImages[indexPath.item]];
        CGSize size = CGSizeMake(ScreenWidth/2 - 30/2, (ScreenWidth/2 - 30/2)*image.size.height/image.size.width);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        imageView.image = image;
        [cell.contentView addSubview:imageView];
        
        
        return cell;
    }else if(collectionView.tag == 151){
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
        
        UIImage *image = [UIImage imageNamed:_adImges[indexPath.item]];
        CGSize size = CGSizeMake(ScreenWidth - 20/2, (ScreenWidth - 20/2)*image.size.height/image.size.width);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        imageView.image = image;
        [cell.contentView addSubview:imageView];
        
        
        return cell;
    }else if (collectionView.tag >= 200 && collectionView.tag < 300){
        NSLog(@"%ld %ld %ld",indexPath.section,indexPath.row,indexPath.item);
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId2" forIndexPath:indexPath];
        CommodityModel *model = _likeArr[indexPath.item];
        UIImage *image = [UIImage imageNamed:model.image];
        CGSize size = CGSizeMake(model.size.width, model.size.height - 40);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        imageView.image = image;
        [cell.contentView addSubview:imageView];
        
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, size.height, size.width, 20)];
        titleLbl.text = model.name;
        [cell.contentView addSubview:titleLbl];
        
        UILabel *priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, size.height + 20, size.width, 20)];
        priceLbl.text = model.price;
        priceLbl.textAlignment = NSTextAlignmentCenter;
        priceLbl.textColor = [UIColor redColor];
        [cell.contentView addSubview:priceLbl];
        
        return cell;
    }else{
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId3" forIndexPath:indexPath];
        CommodityModel *model = _goodArr[indexPath.item];
        UIImage *image = [UIImage imageNamed:model.image];
        CGSize size = CGSizeMake(model.size.width, model.size.height - 40);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        imageView.image = image;
        [cell.contentView addSubview:imageView];
        
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, size.height, size.width, 20)];
        titleLbl.text = model.name;
        [cell.contentView addSubview:titleLbl];
        
        UILabel *priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, size.height + 20, size.width, 20)];
        priceLbl.text = model.price;
        priceLbl.textAlignment = NSTextAlignmentCenter;
        priceLbl.textColor = [UIColor redColor];
        [cell.contentView addSubview:priceLbl];
        
        
        return cell;
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 150) {
        
    }else{
        
    }
    //    [super showHudWithType:NotOpen];
}



@end
