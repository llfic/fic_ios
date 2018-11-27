//
//  CommodityModel.m
//  FIC
//
//  Created by fic on 2018/11/6.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "CommodityModel.h"

@implementation CommodityModel
-(instancetype)init{
    self = [super init];
    if (self) {
        UIImage *image = [UIImage imageNamed:@"mall_1_1"]; // 图片的宽高
        NSInteger count = 3;
        CGFloat space = 10 + 5*(count - 1) + 10;
        CGSize size = CGSizeMake((ScreenWidth - space)/count, (ScreenWidth - space)/count*image.size.height/image.size.width); // 对应屏幕的宽高
        size.height += 20 + 20; // 价格 + 名称的高度
        _size = size;
    }
    return self;
}
@end
