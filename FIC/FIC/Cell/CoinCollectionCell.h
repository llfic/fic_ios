//
//  CoinCollectionCell.h
//  FIC
//
//  Created by fic on 2018/11/23.
//  Copyright © 2018年 fic. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CoinCollectionCell_Name @"CoinCollectionCell"
#define CoinCollectionCell_Identifier @"CoinCollectionCell_Identifier"
#define CoinCollectionCell_Height 77
NS_ASSUME_NONNULL_BEGIN

@interface CoinCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *detailLbl;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;

@end

NS_ASSUME_NONNULL_END
