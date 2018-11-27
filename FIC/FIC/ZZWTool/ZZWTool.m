//
//  ZZWTool.m
//  NEPWallet
//
//  Created by 周泽文 on 2018/9/20.
//  Copyright © 2018年 zhouzewen. All rights reserved.
//

#import "ZZWTool.h"

@implementation ZZWTool
+(NSString *)getJsonStrWithDictionary:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];

    NSRange range = {0,jsonString.length};

    //去掉字符串中的空格

    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];

    NSRange range2 = {0,mutStr.length};

    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
    
}

+(NSString *)getJsonStrContainSpaceWithDictionary:(NSDictionary *)dict{
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
//    NSRange range = {0,jsonString.length};
    
//    //去掉字符串中的空格
//
//    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
//
    NSRange range2 = {0,mutStr.length};
//
//    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}
+(NSString *)getUtf8EncodeWithString:(NSString *)string{
    NSString *result = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

//判断手机号码格式是否正确
+ (BOOL)isValidPhoneNumber:(NSString *)phoneNum;
{
    phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (phoneNum.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:phoneNum];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:phoneNum];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:phoneNum];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

+(NSArray *)getRandomArrayWithArray:(NSArray *)arr{
    arr = [arr sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [str1 compare:str2];
        } else {
            return [str2 compare:str1];
        }
    }];
    return arr;
}

+(CGFloat)getFitWithWithContent:(NSString *)string fontSize:(NSInteger)num{
    /**
     后期要增加 是否超过屏幕宽度的判断
     */
    CGFloat width = 0;
    if (num == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
        label.text = string;
        label.font = [UIFont systemFontOfSize:DefaultFontSize];
        [label sizeToFit];
        width = label.frame.size.width;
    }else{
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
        label.text = string;
        label.font = [UIFont systemFontOfSize:num];
        [label sizeToFit];
        width = label.frame.size.width;
    }
    return width;
}

+(UIImage *)createQRCodeImageWithContent:(NSString *)content withWidth:(CGFloat)width{
    //1. 实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2. 恢复滤镜的默认属性
    [filter setDefaults];
    // 3. 将字符串转换成NSData
    NSString *urlStr = content;
    NSData *data = [urlStr dataUsingEncoding:NSUTF8StringEncoding];
    // 4. 通过KVO设置滤镜inputMessage数据
    [filter setValue:data forKey:@"inputMessage"];
    // 5. 获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    // 6. 将CIImage转换成UIImage，并显示于imageView上 (此时获取到的二维码比较模糊,所以需要用下面的createNonInterpolatedUIImageFormCIImage方法重绘二维码)
    
    UIImage *image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:width];//重绘二维码,使其显示清晰
    return image;
}

/**
 * 根据CIImage生成指定大小的UIImage
 *
 * @param image CIImage
 * @param size 图片宽度
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

+(BOOL)isAllNumbersWithContent:(NSString *)content{
    //方式一
//    content = [content stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
//    if(content.length > 0) {
//        return NO;
//    }
//    return YES;
    //方式二 正则
    if (content.length == 0) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:content]) {
        return YES;
    }
    return NO;

}

+(BOOL)isValidEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL result = [emailTest evaluateWithObject:email];
    return result;
}
+(CGFloat)getSizeWithFilePath:(NSURL *)url{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDictionary *dic = [fm attributesOfItemAtPath:url.path error:nil];
    unsigned long long size = [[dic objectForKey:NSFileSize] longLongValue];
    float fileSize = 1.0*size/1024;
    NSLog(@"%fM",fileSize/1024);
    return fileSize/1024;
}

+(NSString *)getBase64StringWithImage:(UIImage *)image{
    NSData *data = UIImageJPEGRepresentation(image,1.0f);
    NSString *base64String = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return base64String;
}

+(UIImage *)getImageWithBase64String:(NSString *)base64String{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}


+(void)savePicture:(UIImage *)image toDocumentPath:(NSString *)path withName:(NSString *)name{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExsit = [fm  fileExistsAtPath:[documentPath stringByAppendingPathComponent:path] isDirectory:&isDir];
    if (!(isDir && isExsit)) {
        [fm createDirectoryAtPath:[documentPath stringByAppendingPathComponent:path] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    [UIImagePNGRepresentation(image) writeToFile:[documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",path,name]] atomically:YES];
}

+(void)delePicture:(NSString *)name fromDocumentPath:(NSString *)path{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *dirPath = [documentPath stringByAppendingPathComponent:path];
    if (name) {
        NSString *filePath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",path,name]];
        NSFileManager *fm = [NSFileManager defaultManager];
        BOOL isFileExsit = [fm fileExistsAtPath:filePath];
        if (isFileExsit) {
            [fm removeItemAtPath:path error:nil];
        }else{
            NSLog(@"找不到要删除的文件");
        }
    }else{
        NSFileManager *fm = [NSFileManager defaultManager];
        BOOL isFileExsit = [fm fileExistsAtPath:dirPath];
        if (isFileExsit) {
            [fm removeItemAtPath:dirPath error:nil];
        }else{
            NSLog(@"找不到要删除的文件");
        }
    }
    
}
+(UIImage *)getPictureWithPath:(NSString *)path name:(NSString *)name{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",path,name]];
    return [UIImage imageWithContentsOfFile:filePath];
}

+(NSString *)getDateWithTimeStamp:(NSString *)timeStamp{
    // timeStamp 是服务器返回的13位时间戳

    
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[timeStamp doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString       = [formatter stringFromDate: date];
    NSLog(@"服务器返回的时间戳对应的时间是:%@",dateString);
    return dateString;
}

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
//    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"6", @"0", @"1", @"2", @"3", @"4", @"5", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

+(CGFloat)getHeightWithFont:(UIFont *)font width:(CGFloat )width content:(NSString *)content
{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary * attributes = @{
                                  NSFontAttributeName:font,
                                  NSParagraphStyleAttributeName: paragraphStyle
                                  };
    CGSize textRect = CGSizeMake(width, MAXFLOAT);
    CGFloat textHeight = [content boundingRectWithSize: textRect
                                               options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                            attributes:attributes
                                               context:nil].size.height;
    return textHeight;
}

-(NSMutableAttributedString*) changeLabelWithText:(NSString*)needText
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:needText];
    UIFont *font = [UIFont systemFontOfSize:20];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,4)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(4,needText.length-4)];
    return attrString;
}

+(void)setBackgroudColorWithNavigation:(UINavigationController *)controller{
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = WhiteColor;
    }
    
    // 去掉导航栏下部的分割线
    [controller.navigationBar setShadowImage:[UIImage new]];
    [controller.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    controller.navigationBar.backgroundColor = WhiteColor;
    
    //设置导航栏标题颜色 黑色 粗体
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : BlackColor, NSFontAttributeName : FontDefault}];
    [controller.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:FontNameBold size:FontDefault.pointSize], NSForegroundColorAttributeName:BlackColor}];
    
//    UIColor *color3 = [UIColor colorWithHexString:@"#F9706D"];
//    UIColor *color2 = [UIColor colorWithHexString:@"#87489B"];
//    UIColor *color1 = [UIColor colorWithHexString:@"#58B7D7"];
//    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.colors = @[(__bridge id)color1.CGColor, (__bridge id)color2.CGColor, (__bridge id)color3.CGColor];
//    gradientLayer.locations = @[@0.3, @0.5, @1.0];
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1.0, 0);
//    gradientLayer.frame = backView.frame;
//    [backView.layer addSublayer:gradientLayer];
//
//    [controller.navigationBar setBackgroundImage:[self convertViewToImage:backView] forBarMetrics:UIBarMetricsDefault];
}

+(UIImage*)convertViewToImage:(UIView*)v{
    CGSize s = v.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需  要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, YES, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(void)setNavigation:(UINavigationController *)controller TitleHidden:(BOOL)hidden{
    for (UIView *view in controller.navigationBar.subviews) {
        
        if ([NSStringFromClass([view class]) containsString:@"ContentView"]) {
            
            for (UIView *subView in view.subviews) {
                if ([subView isKindOfClass:[UILabel class]]) {
                    subView.hidden = hidden;
                }
            }
            
        }
    }
}

+(void)setNavigation:(UINavigationController *)controller clear:(BOOL)isClear{
    /*
     设置背景图延伸到屏幕顶部，导航栏透明的步骤
     1 xib 关闭safeArea
     2 重新设置tableview的布局 顶部起点
     3 将导航栏设置为透明的
     */
    controller.navigationBar.translucent = isClear;
    [controller.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor colorWithWhite:1 alpha:0]] forBarMetrics:UIBarMetricsDefault];
    [controller.navigationBar setShadowImage:[self createImageWithColor:[UIColor colorWithWhite:1 alpha:0]]];
    
    //    //导航栏设置透明
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"TransparentNavBar"] forBarMetrics:UIBarMetricsDefault];
    //    //设置导航栏分割线:透明
    //    if ([self.navigationController.navigationBar respondsToSelector:@selector(shadowImage)]) {
    //        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    //    }
    //    //显示导航栏
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //    [self.navigationController.navigationBar setTranslucent:YES];
}

+(UIImage*)createImageWithColor:(UIColor*)color

{
    
    CGRect rect=CGRectMake(0.0f,0.0f,1.0f,1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context,[color CGColor]);
    
    CGContextFillRect(context,rect);
    
    UIImage *theImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
    
}

+(NSMutableAttributedString *)getAttributeStrWithFrontStr:(NSString *)frontString frontColor:(UIColor *)frontColor behindStr:(NSString *)behindString behindColor:(UIColor *)behindColor{
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",frontString,behindString]];
    NSRange rangel = [[attriStr string] rangeOfString:frontString];
    NSRange range2 = [[attriStr string] rangeOfString:behindString];
    
    [attriStr addAttribute:NSForegroundColorAttributeName value:frontColor range:rangel];
    [attriStr addAttribute:NSForegroundColorAttributeName value:behindColor range:range2];
//    [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] range:rangel];//999999
  //    [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] range:range2];//666666
    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:rangel];
    [attriStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:16] range:range2];//加粗
    return attriStr;
}

+(NSInteger)getRandomNumWithLength:(NSInteger)length{
//    1、获取一个随机整数范围在：[0,100)包括0，不包括100
//   int x = arc4random() % 100;
    
//    2、  获取一个随机数范围在：[500,1000），包括500，不包括1000
//    int y = (arc4random() % 501) + 500;
    
//    4、获取一个随机整数，范围在[from,to），包括from，不包括to
//     -(int)getRandomNumber:(int)from to:(int)to
//    {
//            return (int)(from + (arc4random() % (to – from + 1)));
//    }

    
    NSInteger count = 1;
    for (NSInteger i = 0; i < length; i++) {
        count = count*10;
    }
    NSInteger randomNum = (arc4random()%count);
    return randomNum;
}
@end
