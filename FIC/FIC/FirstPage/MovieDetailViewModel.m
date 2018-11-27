//
//  MovieDetailViewModel.m
//  FIC
//
//  Created by fic on 2018/11/1.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "MovieDetailViewModel.h"
#import "FilmInfoModel.h"
@interface MovieDetailViewModel()
@property(nonatomic,strong)NSMutableDictionary *dic;
@end
@implementation MovieDetailViewModel
-(instancetype)init{
    self = [super init];
    if (self) {
        _dic = [NSMutableDictionary dictionary];
        NSArray * cellImages = @[@"tangrenjie",@"guanlangaoshou",@"jinjiyuanjiu",@"meitounao",@"liemo",@"zhaijiong",@"zhanlang",@"suomali"];
        NSArray * filmTypes = @[@"类型：喜剧、动作、冒险",@"类型：青春、动作、冒险",@"类型：动作、冒险",@"类型：喜剧、搞笑",@"类型：喜剧、搞笑",@"类型：喜剧、搞笑",@"类型：动作、热血",@"类型：动作、冒险"];
        NSArray * titles = @[@"《唐人街探案3》",@"《灌篮高手的契约》",@"《紧急救援》",@"《没头脑和不高兴的奇妙旅程》",@"《猎魔行动》",@"《债囧之愤怒的小强》",@"《战狼3》",@"《索马里行动》"].mutableCopy;
        for (NSInteger i = 0; i < cellImages.count; i++) {
            FilmInfoModel *model = [FilmInfoModel new];
            model.image = [UIImage imageNamed:cellImages[i]];
            model.name = titles[i];
            model.type = filmTypes[i];
            model.address = @"中国大陆";
            model.time = @"100-110分钟";
            model.publishTime = @"预计2019-10上映";
//            model.wantSeeCount = 93884;
//            model.totalFIC = 5000000;
            model.investFIC = 0;
//            model.investPersonCount = 1024;
//            model.attentionCount = 90493;
            NSDictionary *dic1 = @{@"image":@"",@"type":@"导演",@"name":@"宋晓飞"};
            NSDictionary *dic2 = @{@"image":@"",@"type":@"演员",@"name":@"王宝强"};
//            model.actorArr = @[dic1,dic2];
            model.proejectBrief = @"“囧”系列巨作，延续 大热IP,引爆观影热潮。一线实力派明星出演，续写票房神话。";
            model.synopsis = @"影片主要讲述了伊黛在宾馆将提包取错意外发现丝绸之路藏宝图，在生活所迫下将图换钱生存，由于迷失落入沙漠魔鬼城堡过着原始生活，伊黛带领部落致富；易路艰辛找到妹妹并挖出盗图人，一路囧途上不断发生啼笑皆非的故事。";
            
            [_dic setObject:model forKey:cellImages[i]];
        }
        
    }
    return self;
}
-(FilmInfoModel *)getMovieInfoWithName:(NSString *)name{
    return [_dic objectForKey:name];
}
@end
