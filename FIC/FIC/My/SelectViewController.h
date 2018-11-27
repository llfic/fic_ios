//
//  SelectViewController.h
//  FIC
//
//  Created by fic on 2018/10/30.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "BaseViewController.h"
@class SelectViewController;
typedef NS_ENUM(NSInteger,SelectViewController_selectType) {
    SelectViewController_Up,//左边第一行
    SelectViewController_Down// 左边第二行
};

NS_ASSUME_NONNULL_BEGIN
@protocol SelectViewControllerDelegate <NSObject>
-(void)controller:(SelectViewController *)controller selectType:(SelectViewController_selectType)type content:(NSString *)content;

@end
@interface SelectViewController : BaseViewController
@property(nonatomic,assign)NSInteger leftSelectIndex;
@property(nonatomic,assign)NSInteger rightSelectIndex;
@property(nonatomic,weak)id<SelectViewControllerDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
