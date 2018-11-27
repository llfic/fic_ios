//
//  Input2Cell.h
//  FIC
//
//  Created by fic on 2018/11/1.
//  Copyright © 2018年 fic. All rights reserved.
//

#import <UIKit/UIKit.h>
#define Input2Cell_Name @"Input2Cell"
#define Input2Cell_Identifier @"Input2Cell_Identifier"
#define Input2Cell_Height 44
NS_ASSUME_NONNULL_BEGIN

@interface Input2Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

NS_ASSUME_NONNULL_END
