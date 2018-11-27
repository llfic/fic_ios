//
//  InputCell.h
//  FIC
//
//  Created by fic on 2018/10/25.
//  Copyright © 2018年 fic. All rights reserved.
//

#import <UIKit/UIKit.h>
#define InputCell_Name @"InputCell"
#define InputCell_Identifier @"InputCell_Identifier"
#define InputCell_Height 44

NS_ASSUME_NONNULL_BEGIN

@interface InputCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

NS_ASSUME_NONNULL_END
