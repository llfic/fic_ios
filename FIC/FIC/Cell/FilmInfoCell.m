//
//  FilmInfoCell.m
//  FIC
//
//  Created by fic on 2018/10/31.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "FilmInfoCell.h"
#import "ZZWTool.h"
@interface FilmInfoCell ()
@property(nonatomic,strong)UILabel *contentLbl;
@property(nonatomic,strong)UIImageView *pictureImgV;
@end

@implementation FilmInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentLbl = [[UILabel alloc] initWithFrame:CGRectMake(DefaultMargin, 0, ScreenWidth - DefaultMargin*2, 100)];
        self.contentLbl.numberOfLines = 0;
        self.contentLbl.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.contentLbl];
        
        self.pictureImgV = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.pictureImgV];
    }
    return self;
}
-(void)setContent:(NSString *)content{
    _content = content;
    self.contentLbl.text = content;
    CGFloat height = [ZZWTool getHeightWithFont:[UIFont systemFontOfSize:14] width:ScreenWidth - DefaultMargin*2 content:content];
    CGRect frame = self.contentLbl.frame;
    frame.size.height = height;
    self.contentLbl.frame = frame;
}

-(void)setImage:(UIImage *)image{
    _image = image;
    self.pictureImgV.image = image;
    CGFloat height = (image.size.height/image.size.width)*(ScreenWidth - DefaultMargin*2);
    CGRect frame = CGRectMake(DefaultMargin, self.contentLbl.frame.size.height, ScreenWidth - DefaultMargin*2, height);
    self.pictureImgV.frame = frame;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
