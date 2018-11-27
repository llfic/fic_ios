//
//  UIColor+HexStringColor.h
//  NEPWallet
//
//  Created by 周泽文 on 2018/9/27.
//  Copyright © 2018年 zhouzewen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexStringColor)
// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) colorWithHexString: (NSString *)color;
@end
