

//
//  EMMallSectionView.m
//  chexun
//
//  Created by macrong on 15/5/27.
//  Copyright (c) 2015年 macrong. All rights reserved.
//

#import "EMMallSectionView.h"

#define APP_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width   // 屏幕的宽度

@interface EMMallSectionView()

@end

@implementation EMMallSectionView

+ (EMMallSectionView *)setSectionWithFrame:(CGRect)sectionFrame{
    EMMallSectionView  *sectionView = [[EMMallSectionView alloc]initWithFrame:sectionFrame];
    return sectionView;
}


+ (CGFloat)getSectionHeight
{
    return 15;
}

- (void)setFrame:(CGRect)frame{
    NSLog(@"_______ frame = %@",NSStringFromCGRect(frame));

    CGRect sectionRect = [self.tableView rectForSection:self.section];
    CGRect newFrame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(sectionRect), CGRectGetWidth(frame), CGRectGetHeight(frame)); [super setFrame:newFrame];
}




@end
