//
//  CustomNavigationController.h
//  FIC
//
//  Created by fic on 2018/11/21.
//  Copyright © 2018年 fic. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,CustomNavigationControllerStyle) {
    CustomNavigation_DefaultNavi,//默认的导航栏
    CustomNavigation_ClearNavi//透明的导航栏
};
@interface CustomNavigationController : UINavigationController
@property(nonatomic,assign)CustomNavigationControllerStyle style;
@end

NS_ASSUME_NONNULL_END
