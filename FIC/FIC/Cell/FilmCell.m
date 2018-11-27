//
//  FilmCell.m
//  FIC
//
//  Created by fic on 2018/10/25.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "FilmCell.h"
#import <Masonry.h>

@implementation FilmCell
- (void)awakeFromNib{
    [super awakeFromNib];
    // Initialization code
    UIImage *image = [UIImage imageNamed:@"tangrenjie"];
    _imgV.frame = CGRectMake(DefaultMargin, 0, image.size.width, image.size.height);
    
//    [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top).offset(0);
//        make.left.equalTo(self.mas_left).offset(0);
//        make.size.mas_equalTo(image.size);
//    }];
    
    CGFloat width = ScreenWidth - 12 - 50 - 16 - image.size.width ;
//    CGFloat leftMargin = 10;
    // 电影名字
    _name.font = FontBig;
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.left.equalTo(self.imgV.mas_right).offset(16);
        make.size.mas_equalTo(CGSizeMake(width, 20));
    }];
    
    // 状态
    _status.font = FontSmall;
    _status.layer.borderWidth = 0.5f;
    _status.layer.cornerRadius = 5.0f;
    _status.layer.masksToBounds = YES;
    _status.textColor = TextMidGray;
    _status.textAlignment = NSTextAlignmentCenter;
    [_status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    
    // 电影类型
    _type.textColor = TextMidGray;
    _type.font = FontSmallest;
    [_type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name.mas_bottom).offset(8);
        make.left.equalTo(self.imgV.mas_right).offset(16);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth - image.size.width - 16*2, 15));
    }];
    
    // 总预算
    _totalCount.textAlignment = NSTextAlignmentLeft;
    _totalCount.textColor = TextMidGray;
    [_totalCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.type.mas_bottom).offset(8);
        make.left.equalTo(self.imgV.mas_right).offset(16);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth - image.size.width - 16*2, 15));
    }];
    
    //开放额度
    _openCount.textAlignment = NSTextAlignmentLeft;
    _openCount.textColor = TextMidGray;
    [_openCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.totalCount.mas_bottom).offset(8);
        make.left.equalTo(self.imgV.mas_right).offset(16);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth - image.size.width - 16*2, 15));
    }];
    
    // 投资保证
    _des1.textAlignment = NSTextAlignmentCenter;
//    _des1.backgroundColor = [UIColor colorWithHexString:@"ff9900"];
    _des2.textAlignment = NSTextAlignmentCenter;
//    _des2.backgroundColor = [UIColor colorWithHexString:@"57bad9"];
    _des3.textAlignment = NSTextAlignmentCenter;
//    _des3.backgroundColor = [UIColor colorWithHexString:@"da4b96"];
    NSArray *desArr = @[_des1,_des2,_des3];
    CGFloat space = 8;
    UIFont *font = FontSmallest;
    if (ScreenWidth == 320) {
        space = 3;
    
    }
    CGFloat tail = ScreenWidth - image.size.width - DefaultMargin*2 -space*(desArr.count-1) - 60*desArr.count;
//    [desArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:space leadSpacing:image.size.width + 16 tailSpacing:16];
    [desArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:60 leadSpacing:image.size.width + DefaultMargin*2 tailSpacing:tail];
    [desArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.openCount.mas_bottom).offset(8);
        make.height.mas_equalTo(@20);
    }];
    
    for (UILabel *label in desArr) {
//        label.backgroundColor = [UIColor redColor];
        label.textColor = TextRed;
        label.layer.cornerRadius = ViewCorner/2;
        label.layer.masksToBounds = YES;
        label.layer.borderWidth = BorderWidth;
        label.layer.borderColor = TextRed.CGColor;
        label.font = font;
    }
    
    
    
    
    // 百分比
    _percent.textAlignment = NSTextAlignmentRight;
    _percent.font = FontBig;
    _percent.textColor = TextRed;
    [_percent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.des3.mas_bottom).offset(5);
        make.right.equalTo(self.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(200, 15));
    }];
    
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.percent.mas_bottom).offset(5);
        make.left.equalTo(self.imgV.mas_right).offset(16);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth - image.size.width - DefaultMargin*3, 5));
    }];
    self.line.backgroundColor = ProgressBgGray;
    self.line.layer.cornerRadius = self.line.frame.size.height/2;
    self.line.layer.masksToBounds = YES;
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgV.mas_bottom).offset(0);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(@10);
    }];
//    _bottomView.backgroundColor = DefaultBgColor;//table背景色，默认灰色
    
}
-(void)setPercentNum:(CGFloat)percentNum{
//    if (_percentNum == 0) {
        _percentNum = percentNum;
        NSLog(@"%@ %f",self.name.text,self.percentNum);
        if (_percentNum == 0.0) {
            self.line.backgroundColor = ProgressBgGray;
        }else if (_percentNum == 100.0){
            _line.backgroundColor = ProgressBgRed;
        }else{
            
            CGFloat num = percentNum/100.0;
            CGFloat width = num*self.line.frame.size.width;
            CGRect frame = CGRectMake(0, 0, width, self.line.frame.size.height);
            UIView *view = [[UIView alloc] initWithFrame:frame];
            view.backgroundColor = ProgressBgRed;
            [self.line addSubview:view];
            
            view.layer.cornerRadius = view.frame.size.height/2;
            view.layer.masksToBounds = YES;
            
        }
//    }
    
}
-(void)setTotalNum:(CGFloat)totalNum{
    _totalNum = totalNum;
    NSString *text = [NSString stringWithFormat:@"%@%.2f亿元",self.totalCount.text,totalNum];
    self.totalCount.text = text;
}
-(void)setOpenNum:(CGFloat)openNum{
    _openNum = openNum;
    NSString *text = [NSString stringWithFormat:@"%@%.2f万元",self.openCount.text,openNum];
    self.openCount.text = text;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    UIImage *image = [UIImage imageNamed:@"tangrenjie"];
    _imgV.frame = CGRectMake(DefaultMargin, 0, image.size.width, image.size.height);
    
//    if (_percentNum == 0.0) {
//
//    }else if (_percentNum == 100.0){
//        _line.backgroundColor = [UIColor colorWithHexString:@"DA4B96"];
//    }else{
//
//    }
//    [_openNum mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.openCount.centerX);
//    }];

//    UILabel *label =  [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 15)];
//    label.text = self.status.text;
//    [label sizeToFit];
//    CGRect frame = label.frame;
//    frame = CGRectMake(_status.frame.origin.x, _status.frame.origin.y, frame.size.width, frame.size.height);
//    _status.frame = frame;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the view for the selected state
}

@end
