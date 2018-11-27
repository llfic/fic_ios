//
//  FilmInfoModel.h
//  FIC
//
//  Created by fic on 2018/11/1.
//  Copyright © 2018年 fic. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FilmInfoModel : NSObject
@property(nonatomic,strong)NSString *image;//影片图
@property(nonatomic,strong)NSString *name;//影片名字
@property(nonatomic,strong)NSString *type;//影片类型
@property(nonatomic,strong)NSString *address;//上映地区
@property(nonatomic,strong)NSString *time;//影片时间长度
@property(nonatomic,strong)NSString *publishTime;//上映时间
@property(nonatomic,strong)NSString *wantSeeCount;//想看人数
@property(nonatomic,strong)NSString *totalFIC;//总FIC数目
@property(nonatomic,strong)NSString *investFIC;//已投资FIC数据
@property(nonatomic,strong)NSString *investPersonCount;//已投资人数
@property(nonatomic,strong)NSString *attentionCount;//关注人数
@property(nonatomic,strong)NSString *dianZanCount;//点赞人数

@property(nonatomic,strong)NSString *proejectBrief;//项目简介
@property(nonatomic,strong)NSString *synopsis;//剧情简介  多条简介用#号隔开
@property(nonatomic,strong)NSString *synopsisImages;//剧情简介 多张剧情图片用#号隔开
@end

NS_ASSUME_NONNULL_END
