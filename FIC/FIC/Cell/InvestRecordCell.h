//
//  InvestRecordCell.h
//  FIC
//
//  Created by fic on 2018/11/15.
//  Copyright © 2018年 fic. All rights reserved.
//

#import <UIKit/UIKit.h>
#define InvestRecordCell_Name @"InvestRecordCell"
#define InvestRecordCell_Identifier @"InvestRecordCell_Identifier"
#define InvestRecordCell_Height 100
NS_ASSUME_NONNULL_BEGIN

@interface InvestRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl2;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl2;

@end

NS_ASSUME_NONNULL_END
