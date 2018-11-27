//
//  CoinCollectionCell.m
//  FIC
//
//  Created by fic on 2018/11/23.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "CoinCollectionCell.h"

@implementation CoinCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.layer.masksToBounds = NO;// 设置为NO 才会有阴影的效果
    self.backgroundColor = [UIColor whiteColor];
    
    self.layer.shadowColor = BlackColor.CGColor;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowOpacity = ShadowOpacity;
    self.layer.shadowRadius = ViewCorner*2;
    self.layer.cornerRadius = ViewCorner;
    self.layer.borderWidth = BorderWidth;
    self.layer.borderColor = WhiteColor.CGColor;
}

@end
