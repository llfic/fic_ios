//
//  ExchangeInputCell.h
//  FIC
//
//  Created by fic on 2018/10/29.
//  Copyright © 2018年 fic. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ExchangeInputCell_Name @"ExchangeInputCell"
#define ExchangeInputCell_Identifier @"ExchangeInputCell_Identifier"
#define ExchangeInputCell_Height 250
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ExchangeInputCellChooseType) {
    ExchageAction,//交换按钮
    FirstAction,//点击了上面的n按钮
    SecondAction//点击了下面的按钮
};

@class ExchangeInputCell;
@protocol ExchangeInputCellDelegate<NSObject>
-(void)cell:(ExchangeInputCell *)cell chooseAction:(ExchangeInputCellChooseType)type;
@end
@interface ExchangeInputCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UITextField *firstTF;
@property (weak, nonatomic) IBOutlet UITextField *secondTF;
@property (weak, nonatomic) IBOutlet UILabel *des1;
@property (weak, nonatomic) IBOutlet UILabel *des2;
@property (weak, nonatomic) IBOutlet UIButton *exchangeBtn;
@property(nonatomic,weak)id<ExchangeInputCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
