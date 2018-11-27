//
//  MyInfoViewController.m
//  FIC
//
//  Created by fic on 2018/11/13.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "MyInfoViewController.h"
#import "ZZWTool.h"
#import "QRCodeViewController.h"
#import <TZImagePickerController.h>
#import "ZZWDataSaver.h"
#import "ZZWHudHelper.h"

@interface MyInfoViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *sections;
@property(nonatomic,strong)NSArray *sectionSubArr;
@end

@implementation MyInfoViewController

-(void)setData{
    
    NSArray *sectionArr = @[@"头像",@"昵称",@"手机号"];
    NSArray *section2Arr = @[@"我的邀请码",@"FIC收款码"];
    
    _sections = @[sectionArr,section2Arr];
    
    NSArray *sectionSubArr = @[@"touxiang",@"新手报到",@"18820180447"];
    if ([ZZWDataSaver shareManager].head != nil) {
        sectionSubArr = @[[ZZWDataSaver shareManager].head,@"天天",@"18820180447"];
    }
    if ([ZZWDataSaver shareManager].nickname != nil) {
        sectionSubArr = @[[ZZWDataSaver shareManager].head,[ZZWDataSaver shareManager].nickname,@"18820180447"];
    }
    NSArray *section2SubArr = @[@"这里写邀请码",@"fic币的地址"];
    
    _sectionSubArr = @[sectionSubArr,section2SubArr];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)setTable{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = DefaultBgColor;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, DefaultMargin, 0, DefaultMargin);//设置分割线长度
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏分割线
    //    [self.tableView registerNib:[UINib nibWithNibName:CoinInfoCell_NAME bundle:nil] forCellReuseIdentifier:CoinInfoCell_IDNETIFIER];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifer"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];//隐藏多余的cell
    //    self.tableView.scrollEnabled = NO;//table不能滚动
    //    self.tableView.contentOffset = CGPointMake(0, -self.navigationController.navigationBar.frame.size.height);
    self.tableView.bounces = NO;
    //    self.view.backgroundColor = DefaultBgColor;
}

-(void)setNavi{
    self.navigationItem.title = @"个人中心";
}

#pragma mark table
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sections.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *sectionArr = _sections[section];
    return sectionArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80;
    }else{
        return 44;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        static NSString *identifier = @"reuseIdentifer";
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.textLabel.text = _sections[indexPath.section][indexPath.row];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - DefaultMargin*2 - 60, 10, 60, 60)];
        imageView.tag = 500;
        imageView.image = [UIImage imageNamed:_sectionSubArr[indexPath.section][indexPath.row]];
        if ([ZZWTool getPictureWithPath:Head name:Head]) {
            imageView.image = [ZZWTool getPictureWithPath:Head name:Head];
        }
        imageView.layer.cornerRadius = 60/2;
        imageView.layer.masksToBounds = YES;
        [cell.contentView addSubview:imageView];
//        cell.detailTextLabel.text = _sectionSubArr[indexPath.section][indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
//    else if (indexPath.section == 0 && indexPath.row == 1){
//        static NSString *identifier = @"reuseIdentifer2";
//        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
//        cell.textLabel.text = _sections[indexPath.section][indexPath.row];
//        CGSize size = CGSizeMake(200, 30);
//        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(ScreenWidth - DefaultMargin*2 - size.width, 44/2 - size.height/2, size.width, size.height)];
//        tf.delegate = self;
//        tf.placeholder = _sectionSubArr[indexPath.section][indexPath.row];
//        tf.font = FontSmall;
//        tf.textColor = TextMidGray;
//        tf.textAlignment = NSTextAlignmentRight;
//        tf.tag = 600;
//
//        [cell.contentView addSubview:tf];
//        //        cell.detailTextLabel.text = _sectionSubArr[indexPath.section][indexPath.row];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }
    else{
        static NSString *identifier = @"reuseIdentifer";
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.textLabel.text = _sections[indexPath.section][indexPath.row];
        cell.detailTextLabel.text = _sectionSubArr[indexPath.section][indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    bgView.backgroundColor = [UIColor clearColor];
    return bgView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];

            imagePickerVc.naviBgColor = WhiteColor;
            imagePickerVc.naviTitleColor = TextBlack;
            imagePickerVc.barItemTextColor = TextBlack;
            imagePickerVc.needShowStatusBar = YES;
//            imagePickerVc.cropRect = CGRectMake(10, [[UIScreen mainScreen] bounds].size.height/2 - [[UIScreen mainScreen] bounds].size.width/2 - 10, [[UIScreen mainScreen] bounds].size.width-20, [[UIScreen mainScreen] bounds].size.width - 20);

            
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photo, NSArray *asset, BOOL isSelectOriginalPhoto) {
                NSLog(@"%@",photo);
                [ZZWDataSaver shareManager].head = Head;
                [ZZWTool savePicture:photo.firstObject toDocumentPath:Head withName:Head];
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0i inSection:0]];
                UIImageView *imgV = [cell viewWithTag:500];
                imgV.image = photo.firstObject;
            }];
            
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }else if (indexPath.row == 1){
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"修改昵称" preferredStyle:UIAlertControllerStyleAlert];
            
            //增加取消按钮；
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
            
            //增加确定按钮；
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //获取第1个输入框；
                UITextField *userNameTextField = alertController.textFields.firstObject;
            
                NSLog(@"昵称 = %@",userNameTextField.text);
                if (userNameTextField.text && ![userNameTextField.text isEqualToString:@""]) {
                    [ZZWDataSaver shareManager].nickname = userNameTextField.text;
                    [self setData];
                    
                }
                
                ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
                [hud showHudInSuperView:self.view withText:@"修改成功" withType:HudModeTitle];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [hud hideHudInSuperView:self.view];
                    [self.tableView reloadData];
                });
            }]];
            
            
            
            //定义第一个输入框；
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = @"请输入新的昵称";
            }];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            QRCodeViewController *vc = [QRCodeViewController new];
            vc.qrcodeContent = @"22";
            vc.title = @"我的邀请码";
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            QRCodeViewController *vc = [QRCodeViewController new];
            vc.qrcodeContent = @"22";
            vc.title = @"我的收款码";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@""
                                          message:@"确定修改昵称？"
                                          preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NetworkCenter *nc = [NetworkCenter new];
//        [nc logoutCompletion:^(FIC_NetworkResult result, NSDictionary * _Nonnull responseDic) {
//            if (result == FIC_NetworkResultSuccess) {
//                /**
//                 清空所有数据
//                 */
//                ZZWDataSaver *saver = [ZZWDataSaver shareManager];
//                [saver clearData];
//                ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
//                [hud showHudInSuperView:self.view withText:@"登出成功" withType:HudModeTitle];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//                    [hud hideHudInSuperView:self.view];
//                    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
//
//                    AppDelegate *ad = (AppDelegate *)[UIApplication sharedApplication].delegate;
//                    ad.window.rootViewController =navi;
//                });
//
//
//            }else{
//                ZZWHudHelper *hud = [ZZWHudHelper shareInstance];
//                [hud showHudInSuperView:self.view withText:responseDic[@"reason"] withType:HudModeTitle];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW,HudDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//                    [hud hideHudInSuperView:self.view];
//                });
//            }
//        }];
        
        
    }];
    [alertController addAction:OKAction];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
