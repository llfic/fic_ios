//
//  FilmCollectionCell.h
//  FIC
//
//  Created by fic on 2018/11/19.
//  Copyright © 2018年 fic. All rights reserved.
//

#import <UIKit/UIKit.h>
#define FilmCollectionCell_Name @"FilmCollectionCell"
#define FilmCollectionCell_Identifier @"FilmCollectionCell_Identifier"
#define FilmCollectionCell_Height 180


NS_ASSUME_NONNULL_BEGIN

@interface FilmCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *typeLbl;
@property (weak, nonatomic) IBOutlet UILabel *costLbl;
@property (weak, nonatomic) IBOutlet UILabel *boxOfficeLbl;
@property (weak, nonatomic) IBOutlet UILabel *returnRadioLbl;
@property (weak, nonatomic) IBOutlet UIImageView *getMoneyImgV;
@end

NS_ASSUME_NONNULL_END
