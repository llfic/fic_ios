//
//  FilmModel.m
//  FIC
//
//  Created by fic on 2018/10/25.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "FilmModel.h"

@implementation FilmModel
-(instancetype)init{
    self = [super init];
    if (self) {
//        _type = @"待开机";
        _des1 = @"承诺上映";
        _des2 = @"完片担保";
        _des3 = @"亏损补偿";
        
        _totalCount = @"总预算";
        _openCount = @"开放额度";
        _sellCount = @"已认购";
    }
    return self;
}
@end
