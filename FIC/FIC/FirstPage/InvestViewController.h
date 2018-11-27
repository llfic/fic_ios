//
//  InvestViewController.h
//  FIC
//
//  Created by fic on 2018/11/1.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "BaseViewController.h"
@class FilmModel;
NS_ASSUME_NONNULL_BEGIN

@interface InvestViewController : BaseViewController
@property(nonatomic,strong)NSString *filmName;
@property(nonatomic,strong)FilmModel *filmModel;
@end

NS_ASSUME_NONNULL_END
