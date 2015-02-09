//
//  confirmController.m
//  POSPay
//
//  Created by 齐立洋 on 15/2/2.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "confirmController.h"
#import "authenticationInfo.h"
@interface confirmController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *typeLable;
@property (weak, nonatomic) IBOutlet UILabel *IDNumberLable;
@property (weak, nonatomic) IBOutlet UILabel *stateLable;

@end

@implementation confirmController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackBtn];
    [self addCompleteBtn];
    self.nameLable.text = self.userInfo.name;
    self.typeLable.text = @"身份证";
    self.IDNumberLable.text = self.userInfo.IDnumber;
    self.stateLable.text = @"待审核";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//添加返回按钮
- (void)addBackBtn{
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"箭头（白）左.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backward) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}
- (void)addCompleteBtn{
    UIButton *completeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 32)];
    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [completeBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *completeBtnItem = [[UIBarButtonItem alloc]initWithCustomView:completeBtn];
    self.navigationItem.rightBarButtonItem = completeBtnItem;
}
- (void)backward{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)completeBtnClick{
    //[self performSegueWithIdentifier:@"authentication2account" sender:nil];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

@end
