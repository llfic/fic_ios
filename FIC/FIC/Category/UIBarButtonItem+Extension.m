//
//  UIBarButtonItem+Extension.m
//  TattooMan
//
//  Created by 吴迪 on 15/10/19.
//  Copyright © 2015年 HB. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)setNavigationBarBackGroundImgName:(NSString*)imageName target : (UIViewController *)target selector: (SEL)selector
{
    UIButton * rightButton= [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [rightButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//    CGSize size = rightButton.imageView.image.size;
    rightButton.size = CGSizeMake(40, 40);
//    rightButton.size = CGSizeMake(size.width*2, size.height*2); //如果图片给的太小，这样可以保证小屏幕手机更加容易点击到返回按钮
    [rightButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    return rightBarBtnItem;
}

@end
