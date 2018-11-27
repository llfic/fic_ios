//
//  WCQRCodeVC.h
//  SGQRCodeExample
//
//  Created by kingsic on 17/3/20.
//  Copyright © 2017年 kingsic. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WCQRCodeVC;
@protocol WCQRCodeVCDelegate<NSObject>
-(void)WCQRCodeVC:(WCQRCodeVC *)vc scanResult:(NSString *)content;
@end

@interface WCQRCodeVC : UIViewController
@property(nonatomic,assign)id<WCQRCodeVCDelegate>delegate;
@end
