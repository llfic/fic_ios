//
//  VideoViewController.m
//  FIC
//
//  Created by fic on 2018/10/24.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "VideoViewController.h"
#import "ZZWTool.h"

@interface VideoViewController ()
@property(nonatomic,strong)UIView *lineV;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [super showErrorInfoWithType:ToBeOpen];
}

-(void)setNavi{
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSArray *naviTitles = @[@"全部",@"好莱坞",@"华语电影",@"网大",@"综艺",@"电视剧"];
    UIFont *font = [UIFont systemFontOfSize:14];
    if (ScreenWidth == 320) {
        font = [UIFont systemFontOfSize:12];
    }
    NSMutableArray *widths = [NSMutableArray arrayWithCapacity:naviTitles.count];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    label.font = font;
    for (NSInteger i = 0; i < naviTitles.count ; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        label.text = naviTitles[i];
        [label sizeToFit];
        [widths addObject:[NSNumber numberWithFloat:label.frame.size.width]];
    }
    CGFloat space = 0;
    for (NSInteger i = 0; i < widths.count; i++) {
        space += [widths[i] floatValue];
    }
    space = (ScreenWidth - space)/(widths.count + 1);
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0 ,0, ScreenWidth, 30)];
    CGFloat originX = space;
    for (NSInteger i = 0; i < naviTitles.count ; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100 + i;
        button.frame = CGRectMake( originX, 0, [widths[i] floatValue], 30);
        originX += [widths[i] floatValue] + space;
        [button setTitle:naviTitles[i] forState:UIControlStateNormal];
        button.titleLabel.font = font;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [button addTarget:self action:@selector(naviAction:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
        if (i == 0) {
            CGPoint center = button.center;
            center.y = 30 ;
            _lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 2)];
            _lineV.backgroundColor = [UIColor whiteColor];
            [titleView addSubview:_lineV];
            _lineV.center = center;
        }
    }
    
    self.navigationItem.titleView = titleView;
    
    
    [ZZWTool setBackgroudColorWithNavigation:self.navigationController];
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem setNavigationBarBackGroundImgName:@"back" target:self selector:@selector(back)];//添加返回按钮
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:16]}];//设置导航栏标题颜色
}
-(void)naviAction:(UIButton *)button{
    CGPoint center = button.center;
    center.y = 30 ;
    self.lineV.center = center;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
