//
//  RadioCountCell.h
//  NEPWallet
//
//  Created by 周泽文 on 2018/9/30.
//  Copyright © 2018年 zhouzewen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadioCountCell : UITableViewCell
@property(nonatomic,assign)CGFloat maxValue;
@property(nonatomic,assign)CGFloat minValue;
@property(nonatomic,strong)NSString * chooseValue;
@end
