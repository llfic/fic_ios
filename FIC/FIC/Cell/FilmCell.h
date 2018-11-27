//
//  FilmCell.h
//  FIC
//
//  Created by fic on 2018/10/25.
//  Copyright © 2018年 fic. All rights reserved.
//

#import <UIKit/UIKit.h>
#define FilmCell_Name @"FilmCell"
#define FilmCell_Identifier @"FilmCell_Identifier"
#define FilmCell_Height 180
NS_ASSUME_NONNULL_BEGIN

@interface FilmCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *totalCount;
@property (weak, nonatomic) IBOutlet UILabel *openCount;
@property (weak, nonatomic) IBOutlet UILabel *des1;
@property (weak, nonatomic) IBOutlet UILabel *des2;
@property (weak, nonatomic) IBOutlet UILabel *des3;
@property (weak, nonatomic) IBOutlet UILabel *percent;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property(nonatomic,assign)CGFloat percentNum;
@property(nonatomic,assign)CGFloat totalNum;
@property(nonatomic,assign)CGFloat openNum;
@end

NS_ASSUME_NONNULL_END
