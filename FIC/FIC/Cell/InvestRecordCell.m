//
//  InvestRecordCell.m
//  FIC
//
//  Created by fic on 2018/11/15.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "InvestRecordCell.h"
#import <Masonry.h>
@implementation InvestRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.backgroundColor = DefaultBgColor;
    self.bgView.backgroundColor = [UIColor whiteColor];
//    self.bgView.layer.cornerRadius = 5;
//    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.shadowColor = BlackColor.CGColor;
    self.bgView.layer.shadowOffset = CGSizeZero;
    self.bgView.layer.shadowOpacity = ShadowOpacity;
    self.bgView.layer.shadowRadius = ViewCorner*2;
    self.bgView.layer.cornerRadius = ViewCorner;
    self.bgView.layer.borderWidth = BorderWidth;
    self.bgView.layer.borderColor = WhiteColor.CGColor;
    
    
    _nameLbl.textColor = TextBlack;
    _nameLbl.font = [UIFont fontWithName:FontNameBold size:FontDefault.pointSize];
    _rightBtn.hidden = YES;
    _titleLbl.font = FontSmallest;
    _titleLbl2.font = FontSmallest;
    _titleLbl.textColor = TextMidGray;
    _titleLbl2.textColor = TextMidGray;
    _contentLbl.font = FontSmallest;
    _contentLbl.textColor = TextMidGray;
    _contentLbl2.font = FontSmallest;
    _contentLbl2.textColor = TextRed;

//    CGFloat width = 30;
//
//    // 电影名字
//    [_nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.bgView.mas_top).offset(DefaultMargin);
//        make.left.equalTo(self.bgView.mas_left).offset(DefaultMargin);
//        make.size.mas_equalTo(CGSizeMake(ScreenWidth - width - DefaultMargin, 20));
//    }];
//
//    // 右箭头
//    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.bgView.mas_top).offset(5);
//        make.left.equalTo(self.bgView.mas_right).offset(-30);
//        make.size.mas_equalTo(CGSizeMake(width , 30));
//    }];
//
//    // 投资内容
//    _titleLbl.textAlignment = NSTextAlignmentLeft;
//    _titleLbl.text = @"投资状态";
//    _titleLbl2.textAlignment = NSTextAlignmentCenter;
//    _titleLbl2.text = @"投资金额(元)";
//    _titleLbl3.textAlignment = NSTextAlignmentRight;
//    _titleLbl3.text = @"投资日期";
//   NSArray * desArr = @[_titleLbl,_titleLbl2,_titleLbl3];
//    [desArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:DefaultMargin leadSpacing:DefaultMargin tailSpacing:DefaultMargin];
//    [desArr mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.nameLbl.mas_bottom).offset(5);
//        make.height.mas_equalTo(@20);
//    }];
//
//    // 投资内容
//    _contentLbl.textAlignment = NSTextAlignmentLeft;
//    _contentLbl2.textAlignment = NSTextAlignmentCenter;
//    _contentLbl3.textAlignment = NSTextAlignmentRight;
//    desArr = @[_contentLbl,_contentLbl2,_contentLbl3];
//    [desArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:DefaultMargin leadSpacing:DefaultMargin tailSpacing:DefaultMargin];
//    [desArr mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.titleLbl.mas_bottom).offset(5);
//        make.height.mas_equalTo(@20);
//    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
