//
//  MovieDetailViewModel.h
//  FIC
//
//  Created by fic on 2018/11/1.
//  Copyright © 2018年 fic. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FilmInfoModel;
NS_ASSUME_NONNULL_BEGIN

@interface MovieDetailViewModel : NSObject

-(FilmInfoModel *)getMovieInfoWithName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
