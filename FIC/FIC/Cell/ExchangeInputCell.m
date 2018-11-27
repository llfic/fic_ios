//
//  ExchangeInputCell.m
//  FIC
//
//  Created by fic on 2018/10/29.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "ExchangeInputCell.h"

@implementation ExchangeInputCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.cornerRadius = 10;
    self.bgView.layer.borderWidth = 1.0f;
    self.bgView.layer.masksToBounds = YES;
    
    self.exchangeBtn.backgroundColor = [UIColor whiteColor];
    self.exchangeBtn.layer.borderWidth = 1.0f;
    self.exchangeBtn.layer.cornerRadius = self.exchangeBtn.width/2;
    self.exchangeBtn.layer.masksToBounds = YES;
    
    self.firstBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.secondBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the view for the selected state
}
- (IBAction)exchangeAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(cell:chooseAction:)]) {
        UIImage *image = self.firstBtn.imageView.image;
        NSString *name = self.firstBtn.titleLabel.text;
        [self.firstBtn setImage:self.secondBtn.imageView.image forState:UIControlStateNormal];
        [self.firstBtn setTitle:self.secondBtn.titleLabel.text forState:UIControlStateNormal];
        
        [self.secondBtn setTitle:name forState:UIControlStateNormal];
        [self.secondBtn setImage:image forState:UIControlStateNormal];
        
        [_delegate cell:self chooseAction:ExchageAction];
       
    }
}
- (IBAction)firstAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(cell:chooseAction:)]) {
         [_delegate cell:self chooseAction:FirstAction];
    }
}
- (IBAction)secondAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(cell:chooseAction:)]) {
        [_delegate cell:self chooseAction:SecondAction];
    }
}

@end
