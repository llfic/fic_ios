//
//  InvestActorViewController.m
//  FIC
//
//  Created by fic on 2018/10/30.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "InvestActorViewController.h"

@interface InvestActorViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation InvestActorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [super showErrorInfoWithType:ToBeOpen];
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
