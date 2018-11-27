//
//  EMMallSectionView.h
//  chexun
//
//  Created by macrong on 15/5/27.
//  Copyright (c) 2015年 macrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMMallSectionView : UIView


@property NSUInteger section;

@property (nonatomic, weak) UITableView *tableView;

//- (EMMallSectionView *)viewForHeadFrame:(CGRect)frame withTableView:(UITableView *)tableView;
+ (EMMallSectionView *)setSectionWithFrame:(CGRect)sectionFrame;


+ (CGFloat)getSectionHeight;

@end
