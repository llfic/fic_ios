//
//  ActorModel.h
//  FIC
//
//  Created by fic on 2018/11/3.
//  Copyright © 2018年 fic. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActorModel : NSObject
@property(nonatomic,strong)NSString *filmName;//影片名字
@property(nonatomic,assign)NSInteger actorType;//艺人类型 1 导演 2 演员 3 编剧
@property(nonatomic,strong)NSString *actorName;//艺人名字
@property(nonatomic,strong)NSString *actorImage;//艺人头像
@end

NS_ASSUME_NONNULL_END
