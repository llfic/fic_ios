//
//  FilmCollectionCell.m
//  FIC
//
//  Created by fic on 2018/11/19.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "FilmCollectionCell.h"

@implementation FilmCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.contentView.layer.cornerRadius = ViewCorner;
    self.layer.masksToBounds = NO;// 设置为NO 才会有阴影的效果
    self.backgroundColor = [UIColor whiteColor];
    
    self.layer.shadowColor = BlackColor.CGColor;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowOpacity = ShadowOpacity;
    self.layer.shadowRadius = ViewCorner*2;
    self.layer.cornerRadius = ViewCorner;
    self.layer.borderWidth = BorderWidth;
    self.layer.borderColor = WhiteColor.CGColor;
    
    self.bgView.backgroundColor = TextRed;
    self.bgView.layer.cornerRadius = ViewCorner/2;
    self.bgView.layer.masksToBounds = YES;
    self.statusLbl.backgroundColor = [UIColor clearColor];
    self.statusLbl.textColor = WhiteColor;
    
    self.returnRadioLbl.textColor = TextRed;
    self.returnRadioLbl.font = FontBig;
}

@end
