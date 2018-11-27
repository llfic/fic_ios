//
//  CoinInfoCell.h
//  FIC
//
//  Created by fic on 2018/10/26.
//  Copyright © 2018年 fic. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CoinInfoCell_Name @"CoinInfoCell"
#define CoinInfoCell_Identifier @"CoinInfoCell_Identifier"
#define CoinInfoCell_Height 44

NS_ASSUME_NONNULL_BEGIN

@interface CoinInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;
@property (weak, nonatomic) IBOutlet UILabel *rotationLbl;

@end

NS_ASSUME_NONNULL_END
