//
//  ZZWTool.h
//  NEPWallet
//
//  Created by 周泽文 on 2018/9/20.
//  Copyright © 2018年 zhouzewen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZWTool : NSObject

/**
 字典转json

 @param dict 字典
 @return json字符串
 */
+(NSString *)getJsonStrWithDictionary:(NSDictionary *)dict;


/**
 字典转json 包含空格

 @param dict 字典
 @return json字符串
 */
+(NSString *)getJsonStrContainSpaceWithDictionary:(NSDictionary *)dict;


/**
 对字符串进行UTF-8编码：输出str字符串的UTF-8格式

 @param string 需要编码的字符串
 @return utf8编码后的字符串
 */
+(NSString *)getUtf8EncodeWithString:(NSString *)string;



/**
 判断手机号码格式是否正确

 @param phoneNum 手机号
 @return 是否有效的结果
 */
+ (BOOL)isValidPhoneNumber:(NSString *)phoneNum;

/**
 将一个数组的元素随机重新排序

 @param arr 目标数组
 @return 目的数组
 */
+(NSArray *)getRandomArrayWithArray:(NSArray *)arr;

/**
 根据内容和字体大小，计算出宽度

 @param string 内容字符串
 @param num 字体大小，传0表示使用默认大小14
 @return 计算得到的宽度
 */
+(CGFloat)getFitWithWithContent:(NSString *)string fontSize:(NSInteger)num;


/**
 根据给定的内容生成二维码

 @param content 字符串内容
 @param width 宽度
 @return 二维码对象
 */
+(UIImage *)createQRCodeImageWithContent:(NSString *)content withWidth:(CGFloat)width;


/**
 判断字符串中的内容是否全部都是数字

 @param content 字符串
 @return 结果
 */
+(BOOL)isAllNumbersWithContent:(NSString *)content;


/**
 判断是否是合法的邮箱格式

 @param email 邮箱字符串
 @return 结果
 */
+(BOOL)isValidEmail:(NSString *)email;


/**
 获取 相册 或者 沙盒中文件的大小(M)
 
 @param url url路径
 @return 文件大小，单位M
 */
+(CGFloat)getSizeWithFilePath:(NSURL *)url;


/**
 根据图片对象 获取其Base64字符串

 @param image 图片对象
 @return base64字符串内容
 */
+(NSString *)getBase64StringWithImage:(UIImage *)image;

/**
 根据Base64字符串 获取其 图片对象

 @param base64String base64字符串内容
 @return 图片对象
 */
+(UIImage *)getImageWithBase64String:(NSString *)base64String;

/**
 保存图片到沙盒Document目录下 指定文件夹
 
 @param image 图片
 @param path 文件夹名字
 @param name 图片名
 */
+(void)savePicture:(UIImage *)image toDocumentPath:(NSString *)path withName:(NSString *)name;

/**
 从Document目录 指定文件夹 删除图片
 
 @param name 图片名
 @param path 文件夹名
 */
+(void)delePicture:(NSString *)name fromDocumentPath:(NSString *)path;


/**
 获取用户头像

 @return 头像
 */

/**
 从Document目录获取图片

 @param path 文件路径
 @param name 图片名
 @return 图片
 */
+(UIImage *)getPictureWithPath:(NSString *)path name:(NSString *)name;

/**
 时间戳转成年月日

 @param timeStamp 时间戳字符串
 @return 年月日字符串
 */
+(NSString *)getDateWithTimeStamp:(NSString *)timeStamp;

/**
 根据日期得到星期

 @param inputDate 日期
 @return 星期
 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;


/**
 根据内容、字体、固定宽度 计算高度

 @param font 字体
 @param width 宽度
 @param content 内容
 @return 高度
 */
+(CGFloat)getHeightWithFont:(UIFont *)font width:(CGFloat )width content:(NSString *)content;


/**
 设置导航栏背景色

 @param controller 导航栏控制器
 */
+(void)setBackgroudColorWithNavigation:(UINavigationController *)controller;


/**
 设置导航栏标题隐藏
 @param controller 导航栏
 @param hidden 是否隐藏
 */
+(void)setNavigation:(UINavigationController *)controller TitleHidden:(BOOL)hidden;


/**
 设置导航栏透明的效果

 @param controller 导航栏
 @param isClear 是否透明
 */
+(void)setNavigation:(UINavigationController *)controller clear:(BOOL)isClear;


/**
 获取内容颜色不同的字符串

 @param frontString 前半部分内容
 @param frontColor 前半部分颜色
 @param behindString 后半部分内容
 @param behindColor 后半部分颜色
 @return 需要的字符内容
 */
+(NSMutableAttributedString *)getAttributeStrWithFrontStr:(NSString *)frontString frontColor:(UIColor *)frontColor behindStr:(NSString *)behindString behindColor:(UIColor *)behindColor;


/**
 获取一个随机数字

 @param length 随机数字的长度
 @return 想得到的随机数字
 */
+(NSInteger)getRandomNumWithLength:(NSInteger)length;
@end

NS_ASSUME_NONNULL_END
