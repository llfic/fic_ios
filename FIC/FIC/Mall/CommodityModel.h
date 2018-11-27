//
//  CommodityModel.h
//  FIC
//
//  Created by fic on 2018/11/6.
//  Copyright © 2018年 fic. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommodityModel : NSObject
@property(nonatomic,strong)NSString *image;//图片
@property(nonatomic,assign)CGSize size;//宽高
@property(nonatomic,strong)NSString *name;// 名字
@property(nonatomic,strong)NSString *price;// 价格
@end

NS_ASSUME_NONNULL_END
