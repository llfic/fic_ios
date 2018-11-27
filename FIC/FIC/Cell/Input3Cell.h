//
//  Input3Cell.h
//  FIC
//
//  Created by fic on 2018/11/23.
//  Copyright © 2018年 fic. All rights reserved.
//

#import <UIKit/UIKit.h>
#define Input3Cell_Name @"Input3Cell"
#define Input3Cell_Identifier @"Input3Cell_Identifier"
#define Input3Cell_Height 50
NS_ASSUME_NONNULL_BEGIN

@interface Input3Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *line;

@end

NS_ASSUME_NONNULL_END
