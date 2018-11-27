//
//  CopyrightViewController.m
//  FIC
//
//  Created by fic on 2018/10/30.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "CopyrightViewController.h"

@interface CopyrightViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CopyrightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [super showErrorInfoWithType:ToBeOpen];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
