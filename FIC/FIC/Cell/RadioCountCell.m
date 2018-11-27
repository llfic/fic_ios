//
//  RadioCountCell.m
//  NEPWallet
//
//  Created by 周泽文 on 2018/9/30.
//  Copyright © 2018年 zhouzewen. All rights reserved.
//

#import "RadioCountCell.h"
#import "SFDualWaySlider.h"
@implementation RadioCountCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

-(void)setMinValue:(CGFloat)minValue{
    _minValue = minValue;
    [self createSlider];
}
-(void)setMaxValue:(CGFloat)maxValue{
    _maxValue = maxValue;
    
}
-(void)createSlider{
    
    UILabel *minLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 20, 20)];
    minLbl.font = [UIFont systemFontOfSize:14];
    minLbl.text = @"慢";
    [self.contentView addSubview:minLbl];
    
    UILabel *maxLbl = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - 20, 70, 20, 20)];
    maxLbl.text = @"快";
    maxLbl.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:maxLbl];
    
    __block UILabel *valueLbl = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2 - 100/2, 70, 100, 20)];
    valueLbl.text = [NSString stringWithFormat:@"%.5f",self.minValue];
    valueLbl.font = [UIFont systemFontOfSize:14];
    valueLbl.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:valueLbl];
    
    CGFloat minValue = self.minValue;
    CGFloat maxValue = self.maxValue;
    SFDualWaySlider *slider = [[SFDualWaySlider alloc] initWithFrame:CGRectMake(16, 0, [UIScreen mainScreen].bounds.size.width - 16*2, 70) minValue:minValue maxValue:maxValue blockSpaceValue:0];
    slider.progressRadius = 5;
//    [slider.minIndicateView setTitle:@"不限"];
//    [slider.maxIndicateView setTitle:@"不限"];
    slider.lightColor = DefaultButtonColor;
    slider.maxIndicateView.hidden = YES;
    slider.minIndicateView.backIndicateColor = [UIColor greenColor];
    slider.maxIndicateView.backIndicateColor = [UIColor greenColor];
    
    slider.sliderValueChanged = ^(CGFloat minValue, CGFloat maxValue) {
        NSLog(@"%f",minValue);
        self.chooseValue = [NSString stringWithFormat:@"%.5f",minValue];
        valueLbl.text = [NSString stringWithFormat:@"%.5f",minValue];
    };
    
    //设置标题，如果需要设置默认值 最好先写这个，否则设置默认值后不会第一时间触发
    slider.getMinTitle = ^NSString *(CGFloat minValue) {
        if (floor(minValue) == 0.f) {
            return @"0";
        }else{
            return [NSString stringWithFormat:@"%.fNEP",floor(minValue)];
        }
        
    };
    
    
    slider.currentMinValue = minValue;
    slider.currentMaxValue = maxValue;
    //分段 表示前部分占比80%  所在值范围为[0,30]  即剩下的 20%滑动距离 值范围为[30，80]
    slider.frontScale = 1;
    slider.frontValue = maxValue;
    
    slider.spaceInBlocks = 0;//大小滑块间距
    slider.indicateViewOffset = 10;//滑块和指示视图之间的间距 默认 3
    slider.indicateViewWidth = 35;//指示视图宽度 默认 35
    
    [self.contentView addSubview:slider];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
self.selectionStyle = UITableViewCellSelectionStyleNone;//取消cell选中时变暗的效果
    // Configure the view for the selected state
}

@end
