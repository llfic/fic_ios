//
//  ZZWDataSaver.h
//  NEPWallet
//
//  Created by 周泽文 on 2018/9/20.
//  Copyright © 2018年 zhouzewen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ActorModel;
@class FilmModel;
@class FilmInfoModel;

@interface ZZWDataSaver : NSObject
+(instancetype)shareManager;
@property(nonatomic,strong)NSString *key;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *mnemonicWord;
@property(nonatomic,strong)NSString *phoneNumber;
@property(nonatomic,strong)NSString *isSigned;
@property(nonatomic,strong)NSString *gesture;
@property(nonatomic,assign)BOOL hadGesture;
@property(nonatomic,assign)BOOL hadExist;
@property(nonatomic,strong)NSString *head;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *inviteCode;//邀请码
@property(nonatomic,assign)NSInteger userId;//用户的id
@property(nonatomic,strong)NSString *tokenValue;//请求头token
-(void)clearData;

-(void)createActorDB;
-(BOOL)addActorModel:(ActorModel *)model;
-(NSArray *)queryActorsWithFilmName:(NSString *)filmName;

-(void)createFilmInfoDB;
-(BOOL)addFilmModel:(FilmModel *)model;
-(NSArray *)queryFilmInfosWithFilmNames:(NSArray *)filmNames;


-(void)createFilmDetailDB;
-(BOOL)addFilmInfoModel:(FilmInfoModel *)model;
-(NSArray *)queryFilmDetailWithFilmName:(NSString *)filmName;
@end
