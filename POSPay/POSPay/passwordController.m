//
//  passwordController.m
//  POSPay
//
//  Created by 齐立洋 on 15/2/2.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "passwordController.h"
#import "authenticationInfo.h"
#import "pictureController.h"

@interface passwordController ()
@property (weak, nonatomic) IBOutlet UITextField *withdrawMoneyPasswordField;
- (IBAction)nextBtnClick;


@end

@implementation passwordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackBtn];
    
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


- (IBAction)nextBtnClick {
}
//添加返回按钮
- (void)addBackBtn{
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"箭头（白）左.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backward) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}
- (void)backward{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    self.userInfo.password = self.withdrawMoneyPasswordField.text;
    pictureController *pictureController = segue.destinationViewController;
    pictureController.userInfo = self.userInfo;
}
@end
