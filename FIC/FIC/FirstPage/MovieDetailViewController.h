//
//  MovieDetailViewController.h
//  FIC
//
//  Created by fic on 2018/10/31.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "BaseViewController.h"
@class FilmModel;
@class FilmInfoModel;
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,MovieDetailViewController_type) {
    
    MovieDetailViewController_Normal,       //一般详情
    MovieDetailViewController_GetMoney       //挣钱了
    
};
@interface MovieDetailViewController : BaseViewController
@property(nonatomic,strong)FilmModel *filmModel;
@property(nonatomic,strong)NSString *filmName;
@property(nonatomic,assign)MovieDetailViewController_type type;
@property(nonatomic,assign)BOOL hiddenInvestBtn;//隐藏投资按钮
@end

NS_ASSUME_NONNULL_END
