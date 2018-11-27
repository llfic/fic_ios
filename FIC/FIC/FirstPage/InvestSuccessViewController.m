//
//  InvestSuccessViewController.m
//  FIC
//
//  Created by fic on 2018/11/14.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "InvestSuccessViewController.h"
#import "HSLeftPresentAnimation.h"
#import "ZZWTool.h"
#import "FilmModel.h"
@interface InvestSuccessViewController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition* interactiveTransition;
@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation InvestSuccessViewController
-(instancetype)init{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        //        self.parentViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
        //        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        //        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    CGFloat width = 265;
    CGFloat height = 350;
    CGFloat oringY = ScreenHeight/2 - height/2;
    
    CGFloat margin = (ScreenWidth - width)/2;
    UIImage *image = [UIImage imageNamed:@"first_奖牌与背景"];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(margin, oringY, width, height)];
    _imageView.layer.cornerRadius = 10;
    _imageView.layer.masksToBounds = YES;
    _imageView.image = image;
    [self.view addSubview:_imageView];
    
    CGFloat width2 = 112;
    CGFloat height2 = 112;
    CGFloat oringY2 = 80;
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(width/2 - width2/2, oringY2, width2, height2)];
    imageView2.image = [UIImage imageNamed:@"first_奖牌"];
    [_imageView addSubview:imageView2];
    
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width2/2 - 60/2, width2/2 - 60/2 - 2, 60, 60)];
    
    headImageView.image = [UIImage imageNamed:@"touxiang"];
    [imageView2 addSubview:headImageView];
    
    
    CGFloat height3 = 20;
    CGFloat oringY3 = oringY2 + height2;
    UILabel *nicknameLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, oringY3, width, height3)];
    nicknameLbl.text = @"雅诗兰黛";
    nicknameLbl.textAlignment = NSTextAlignmentCenter;
    nicknameLbl.font = [UIFont systemFontOfSize:18];
    nicknameLbl.textColor = [UIColor colorWithHexString:@"5da8d0"];
    [_imageView addSubview:nicknameLbl];
    
    
    CGFloat height4 = 20;
    CGFloat oringY4 = oringY3 + height3;
    UILabel *textLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, oringY4, width, height4)];
    textLbl.text = @"恭喜投资置换权益成功";
    textLbl.textAlignment = NSTextAlignmentCenter;
    [_imageView addSubview:textLbl];
    
    CGFloat height5 = 20;
    CGFloat oringY5 = oringY4 + height4;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"您已成为《%@》第%d位投资人",self.filmModel.name,888]];
    NSRange range1 = [[str string] rangeOfString:[NSString stringWithFormat:@"您已成为《%@》第",self.filmModel.name]];
    [str addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:12],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"666666"]} range:range1];
    NSRange range2 = [[str string] rangeOfString:@"888"];
    [str addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"d35d7b"]} range:range2];
    NSRange range3 = [[str string] rangeOfString:@"位投资人"];
    [str addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:12],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"666666"]} range:range3];
    
    UILabel *textLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(0, oringY5, width, height5)];
    textLbl2.attributedText = str;
    textLbl2.textAlignment = NSTextAlignmentCenter;
    [_imageView addSubview:textLbl2];
    
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(10, height - 10 - 50, 50, 50)];
    imageView3.image = [UIImage imageNamed:@"first_二维码"];
    [_imageView addSubview:imageView3];
    
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(60, height - 20 - 10 - 20, width - 70, 20)];
    label2.text = @"FIC(1985)淘影通证";
    label2.font = [UIFont systemFontOfSize:14];
    label2.textAlignment = NSTextAlignmentRight;
    [_imageView addSubview:label2];
    
    
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    //IOS 8 之后
    NSUInteger integer = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay;
    NSDateComponents *dataCom = [currentCalendar components:integer fromDate:currentDate];
    
    NSInteger year = [dataCom year];
    NSInteger month = [dataCom month];
    NSInteger day = [dataCom day];
    
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(60, height - 20 - 10 , width - 70, 20)];
    label3.text = [NSString stringWithFormat:@"日期：%ld年%ld月%ld日",year,month,day];
    label3.font = [UIFont systemFontOfSize:12];
    label3.textAlignment = NSTextAlignmentRight;
    [_imageView addSubview:label3];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"first_删除"] forState:UIControlStateNormal];
    button.frame = CGRectMake(ScreenWidth/2 - 40/2, ScreenHeight/2 + height/2 + 20, 40, 40);
    [button addTarget:self action:@selector(closeView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    HSLeftPresentAnimation* leftPresentAnimation = [[HSLeftPresentAnimation alloc] init];
    leftPresentAnimation.isPresent = NO;
    return leftPresentAnimation;
    
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.interactiveTransition;
}

- (void)closeView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
