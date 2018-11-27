//
//  ZZWDataSaver.m
//  NEPWallet
//
//  Created by 周泽文 on 2018/9/20.
//  Copyright © 2018年 zhouzewen. All rights reserved.
//

#import "ZZWDataSaver.h"
#import <FMDB.h>
#import "ActorModel.h"
#import "FilmModel.h"
#import "FilmInfoModel.h"

#define OBJECT_KEY @"FIC"
NSString *kPublicKey = @"publicKey";
NSString *kKey = @"key";
NSString *kPassword = @"password";
NSString *kPrivateKey = @"privateKey";
NSString *kmnemonicWord = @"mnemonicWord";
NSString *kPhoneNumber = @"phoneNumber";
NSString *kSigned = @"signed";
NSString *kHadGesture = @"hadGesture";
NSString *kGesture = @"gesture";
NSString *kHadExist = @"hadExist";
NSString *kHead = @"head";
NSString *kNickname = @"nickname";
NSString *kInviteCode = @"inviteCode";
NSString *kUserId = @"userId";
NSString *kTokenValue = @"tokenValue";

static ZZWDataSaver *_saver = nil;

@interface ZZWDataSaver()
@property(nonatomic,strong)FMDatabase *db;
@end

@implementation ZZWDataSaver
+ (instancetype)shareManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _saver = [ZZWDataSaver new];
    });
    return _saver;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        
    }
    return self;
}
-(void)setTokenValue:(NSString *)tokenValue{
    [self setObject:tokenValue forKey:kTokenValue];
}
-(NSString *)tokenValue{
    return [self objectForKey:kTokenValue];
}
-(void)setUserId:(NSInteger)userId{
    [self setObject:[NSNumber numberWithInteger:userId] forKey:kUserId];
}
-(NSInteger)userId{
    return [[self objectForKey:kUserId] integerValue];
}

-(void)setInviteCode:(NSString *)inviteCode{
    [self setObject:inviteCode forKey:kInviteCode];
}
-(NSString *)inviteCode{
    return [self objectForKey:kInviteCode];
}
-(void)setNickname:(NSString *)nickname{
    [self setObject:nickname forKey:kNickname];
}
-(NSString *)nickname{
    return [self objectForKey:kNickname];
}
-(void)setHead:(NSString *)head{
    [self setObject:head forKey:kHead];
}
-(NSString *)head{
    return [self objectForKey:kHead];
}
-(void)setHadExist:(BOOL)hadExist{
    [self setObject:[NSNumber numberWithBool:hadExist] forKey:kHadExist];
}
-(BOOL)hadExist{
    return [[self objectForKey:kHadExist] boolValue];
}

-(void)setHadGesture:(BOOL)hadGesture{
    [self setObject:[NSNumber numberWithBool:hadGesture] forKey:kHadGesture];
}
-(BOOL)hadGesture{
    return [[self objectForKey:kHadGesture] boolValue];
}


-(void)setGesture:(NSString *)gesture{
    [self setObject:gesture forKey:kGesture];
}
-(NSString *)gesture{
    return [self objectForKey:kGesture];
}
-(void)setIsSigned:(NSString *)isSigned{
    [self setObject:isSigned forKey:kSigned];
}
-(NSString *)isSigned{
    return [self objectForKey:kSigned];
}

-(void)setPhoneNumber:(NSString *)phoneNumber{
    [self setObject:phoneNumber forKey:kPhoneNumber];
}
-(NSString *)phoneNumber{
    return [self objectForKey:kPhoneNumber];
}

-(void)setKey:(NSString *)key{
    [self setObject:key forKey:kKey];
}
-(NSString *)key{
   return [self objectForKey:kKey];
}

-(void)setPassword:(NSString *)password{
    [self setObject:password forKey:kPassword];
}
-(NSString *)password{
   return [self objectForKey:kPassword];
}
-(void)setPrivateKey:(NSString *)privateKey{
    [self setObject:privateKey forKey:kPrivateKey];
}
-(NSString *)privateKey{
    return [self objectForKey:kPrivateKey];
}
-(void)setMnemonicWord:(NSString *)mnemonicWord{
    [self setObject:mnemonicWord forKey:kmnemonicWord];
}
-(NSString *)mnemonicWord{
    return [self objectForKey:kmnemonicWord];
}
- (void)setObject:(id)object forKey:(NSString *)key {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dict = [userDefault objectForKey:OBJECT_KEY];
    NSMutableDictionary *saveDict = nil;
    
    if (!dict) {
        saveDict = [NSMutableDictionary new];
    }else {
        saveDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    }
    
    if (!object) {
        [saveDict removeObjectForKey:key];
    }else {
        
        [saveDict setObject:object forKey:key];
    }
    [userDefault setObject:saveDict forKey:OBJECT_KEY];
    [userDefault synchronize];
}

- (id)objectForKey:(NSString *)key {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dict = [userDefault objectForKey:OBJECT_KEY];
    return [dict objectForKey:key];
}

-(void)clearData{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:OBJECT_KEY];
    [userDefault synchronize];
}

-(void)createActorDB{
    //1.创建database路径
    NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSString *dbPath = [docuPath stringByAppendingPathComponent:@"actor"];
    NSLog(@"!!!dbPath = %@",dbPath);
    
    //2.创建对应路径下数据库
    _db = [FMDatabase databaseWithPath:dbPath];
    
    
    //3.在数据库中进行增删改查操作时，需要判断数据库是否open，如果open失败，可能是权限或者资源不足，数据库操作完成通常使用close关闭数据库
    [_db open];
    if (![_db open]) {
        NSLog(@"db open fail");
        return;
    }
    //4.数据库中创建表（可创建多张）
    NSString *sql = @"create table if not exists actor ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,'filmName' TEXT NOT NULL, 'actorType' INTEGER NOT NULL,'actorName' TEXT NOT NULL,'actorImage' TEXT NOT NULL)";
    //5.执行更新操作 此处database直接操作，不考虑多线程问题，多线程问题，用FMDatabaseQueue 每次数据库操作之后都会返回bool数值，YES，表示success，NO，表示fail,可以通过 @see lastError @see lastErrorCode @see lastErrorMessage
    BOOL result = [_db executeUpdate:sql];
    if (result) {
        NSLog(@"create table success");
        
    }
    [_db close];
}

-(BOOL)addActorModel:(ActorModel *)model{
    [_db open];
    BOOL result = [_db executeUpdate:@"insert into 'actor'(filmName,actorType,actorName,actorImage) values(?,?,?,?)" withArgumentsInArray:@[model.filmName,[NSNumber numberWithInteger:model.actorType],model.actorName,model.actorImage]];
    [_db close];
    if (result) {
        NSLog(@"insert into 'actor' success");
        return YES;
        
    } else {
        NSLog(@"insert into 'actor' fail %@",[_db lastError].description);
        return NO;
        
    }
}

-(NSArray *)queryActorsWithFilmName:(NSString *)filmName{
    [_db open];
    //0.直接sql语句
    FMResultSet *result = [_db executeQuery:@"select * from 'actor' where filmName = ?" withArgumentsInArray:@[filmName]];
    
    NSMutableArray *arr = [NSMutableArray array];
    while ([result next]) {
        ActorModel *model = [ActorModel new];
        model.actorType = [result intForColumn:@"actorType"];
        model.filmName = [result stringForColumn:@"filmName"];
        model.actorName = [result stringForColumn:@"actorName"];
        model.actorImage = [result stringForColumn:@"actorImage"];
        if (model.actorType == 1) {
            [arr insertObject:model atIndex:0];
        }else{
            [arr addObject:model];
        }
        
        NSLog(@"从数据库查询到的人员 %@",model.actorName);
        
    }
    return arr.copy;
}

-(void)createFilmInfoDB{
    //1.创建database路径
    NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSString *dbPath = [docuPath stringByAppendingPathComponent:@"filmInfo"];
    NSLog(@"!!!dbPath = %@",dbPath);
    
    //2.创建对应路径下数据库
    _db = [FMDatabase databaseWithPath:dbPath];
    
    
    //3.在数据库中进行增删改查操作时，需要判断数据库是否open，如果open失败，可能是权限或者资源不足，数据库操作完成通常使用close关闭数据库
    [_db open];
    if (![_db open]) {
        NSLog(@"db open fail");
        return;
    }
    //4.数据库中创建表（可创建多张）
    NSString *sql = @"create table if not exists filmInfo ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,'filmName' TEXT NOT NULL, 'filmImage' TEXT NOT NULL, 'filmType' TEXT NOT NULL,'filmStatus' TEXT NOT NULL,'generalBudget' TEXT NOT NULL,'openCount' TEXT NOT NULL,'percentCount' TEXT NOT NULL)";
    //5.执行更新操作 此处database直接操作，不考虑多线程问题，多线程问题，用FMDatabaseQueue 每次数据库操作之后都会返回bool数值，YES，表示success，NO，表示fail,可以通过 @see lastError @see lastErrorCode @see lastErrorMessage
    BOOL result = [_db executeUpdate:sql];
    if (result) {
        NSLog(@"create table success");
        
    }
    [_db close];
}

-(BOOL)addFilmModel:(FilmModel *)model{
    [_db open];
    BOOL result = [_db executeUpdate:@"insert into 'filmInfo'(filmName,filmImage,filmType,filmStatus,generalBudget,openCount,percentCount) values(?,?,?,?,?,?,?)" withArgumentsInArray:@[model.name,model.image,model.type,model.status,model.totalNum,model.openNum,model.percent]];
    [_db close];
    if (result) {
        NSLog(@"insert into 'actor' success");
        return YES;
        
    } else {
        NSLog(@"insert into 'actor' fail %@",[_db lastError].description);
        return NO;
        
    }
}
-(NSArray *)queryFilmInfosWithFilmNames:(NSArray *)filmNames{
    
    [_db open];
    NSMutableArray *dataArr = [NSMutableArray arrayWithCapacity:filmNames.count];
    for (NSInteger i = 0; i < filmNames.count; i++) {
        //0.直接sql语句
        FMResultSet *result = [_db executeQuery:@"select * from 'filmInfo' where filmName = ?" withArgumentsInArray:@[filmNames[i]]];
        
        NSMutableArray *arr = [NSMutableArray array];
        while ([result next]) {
            FilmModel *model = [FilmModel new];
            model.name = [result stringForColumn:@"filmName"];
            model.image = [result stringForColumn:@"filmImage"];
            model.type = [result stringForColumn:@"filmType"];
            model.status = [result stringForColumn:@"filmStatus"];
            model.totalNum = [result stringForColumn:@"generalBudget"];
            model.openNum = [result stringForColumn:@"openCount"];
            model.percent = [result stringForColumn:@"percentCount"];
            
            [arr addObject:model];
            
            NSLog(@"从数据库查询到 %@",model.name);
            
        }
        if (arr.count > 0) {
            [dataArr addObject:arr.firstObject];
        }
        
    }
    [_db close];
    return dataArr.copy;
}


-(void)createFilmDetailDB{
    //1.创建database路径
    NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSString *dbPath = [docuPath stringByAppendingPathComponent:@"filmDetail"];
    NSLog(@"!!!dbPath = %@",dbPath);
    
    //2.创建对应路径下数据库
    _db = [FMDatabase databaseWithPath:dbPath];
    
    
    //3.在数据库中进行增删改查操作时，需要判断数据库是否open，如果open失败，可能是权限或者资源不足，数据库操作完成通常使用close关闭数据库
    [_db open];
    if (![_db open]) {
        NSLog(@"db open fail");
        return;
    }
    //4.数据库中创建表（可创建多张）
    NSString *sql = @"create table if not exists filmDetail ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,'filmName' TEXT NOT NULL, 'filmImage' TEXT NOT NULL, 'filmType' TEXT NOT NULL,'address' TEXT NOT NULL,'time' TEXT NOT NULL,'publishTime' TEXT NOT NULL,'wantSeeCount' TEXT NOT NULL,'totalFIC' TEXT NOT NULL,'investFIC' TEXT NOT NULL,'investPersonCount' TEXT NOT NULL,'attentionCount' TEXT NOT NULL,'dianZanCount' TEXT NOT NULL,'proejectBrief' TEXT NOT NULL,'synopsis' TEXT NOT NULL,'synopsisImages' TEXT NOT NULL)";
    //5.执行更新操作 此处database直接操作，不考虑多线程问题，多线程问题，用FMDatabaseQueue 每次数据库操作之后都会返回bool数值，YES，表示success，NO，表示fail,可以通过 @see lastError @see lastErrorCode @see lastErrorMessage
    BOOL result = [_db executeUpdate:sql];
    if (result) {
        NSLog(@"create table success");
        
    }
    [_db close];
}

-(BOOL)addFilmInfoModel:(FilmInfoModel *)model{
    [_db open];
    BOOL result = [_db executeUpdate:@"insert into 'filmDetail'(filmName,filmImage,filmType,address,time,publishTime,wantSeeCount,totalFIC,investFIC,investPersonCount,attentionCount,dianZanCount,proejectBrief,synopsis,synopsisImages) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)" withArgumentsInArray:@[model.name,model.image,model.type,model.address,model.time,model.publishTime,model.wantSeeCount,model.totalFIC,model.investFIC,model.investPersonCount,model.attentionCount,model.dianZanCount,model.proejectBrief,model.synopsis,model.synopsisImages]];
    [_db close];
    if (result) {
        NSLog(@"insert into 'actor' success");
        return YES;
        
    } else {
        NSLog(@"insert into 'actor' fail %@",[_db lastError].description);
        return NO;
        
    }
}

-(NSArray *)queryFilmDetailWithFilmName:(NSString *)filmName{
    
    [_db open];
    
    //0.直接sql语句
    FMResultSet *result = [_db executeQuery:@"select * from 'filmDetail' where filmName = ?" withArgumentsInArray:@[filmName]];
    
    NSMutableArray *arr = [NSMutableArray array];
    while ([result next]) {
        FilmInfoModel *model = [FilmInfoModel new];
        model.name = [result stringForColumn:@"filmName"];
        model.image = [result stringForColumn:@"filmImage"];
        model.type = [result stringForColumn:@"filmType"];
        model.time = [result stringForColumn:@"time"];
        model.address = [result stringForColumn:@"address"];
        model.publishTime = [result stringForColumn:@"publishTime"];
        model.wantSeeCount = [result stringForColumn:@"wantSeeCount"];
        model.totalFIC = [result stringForColumn:@"totalFIC"];
        model.investFIC = [result stringForColumn:@"investFIC"];
        model.investPersonCount = [result stringForColumn:@"investPersonCount"];
        model.attentionCount = [result stringForColumn:@"attentionCount"];
        model.dianZanCount = [result stringForColumn:@"dianZanCount"];
        model.proejectBrief = [result stringForColumn:@"proejectBrief"];
        model.synopsis = [result stringForColumn:@"synopsis"];
        model.synopsisImages = [result stringForColumn:@"synopsisImages"];
        [arr addObject:model];
        
        NSLog(@"从数据库查询到的人员 %@",model.name);
        
    }
    
    [_db close];
    return arr.copy;

    
   
}
@end
