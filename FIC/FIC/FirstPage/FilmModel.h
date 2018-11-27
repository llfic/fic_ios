//
//  FilmModel.h
//  FIC
//
//  Created by fic on 2018/10/25.
//  Copyright © 2018年 fic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface FilmModel : NSObject
@property(nonatomic,copy)NSString *image;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *des1;
@property(nonatomic,copy)NSString *des2;
@property(nonatomic,copy)NSString *des3;
@property(nonatomic,copy)NSString *totalCount;
@property(nonatomic,copy)NSString *openCount;
@property(nonatomic,copy)NSString *sellCount;
@property(nonatomic,copy)NSString *totalNum;
@property(nonatomic,copy)NSString *openNum;
@property(nonatomic,copy)NSString *percent;
@end

NS_ASSUME_NONNULL_END
