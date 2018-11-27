//
//  TransactionViewController.h
//  FIC
//
//  Created by fic on 2018/10/27.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TransactionViewController : BaseViewController
@property(nonatomic,copy)NSString *titleText;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSDictionary *infoDic;
@end

NS_ASSUME_NONNULL_END
