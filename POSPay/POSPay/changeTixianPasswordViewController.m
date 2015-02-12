//
//  changeTixianPasswordViewController.m
//  POSPay
//
//  Created by 齐立洋 on 15/2/7.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "changeTixianPasswordViewController.h"
#import "sixNumberPasswordView.h"
@interface changeTixianPasswordViewController ()
@property (strong, nonatomic) sixNumberPasswordView *PreviousPasswordView;
@property (strong, nonatomic) sixNumberPasswordView *passwordView;
@property (strong, nonatomic) sixNumberPasswordView *passwordAgainView;
@property (strong, nonatomic) UIButton *confirmBtn;
@end

@implementation changeTixianPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addPreviousPasswordView];
    [self addNewPasswordView];
    [self addNewPasswordAgainView];
    [self addConfirmBtn];
    [self addLables];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)confirmBtnClick{
    
    NSString *previousPassword = self.PreviousPasswordView.passwordField.text;
    NSString *password = self.passwordView.passwordField.text;
    NSString *passwordAgain = self.passwordAgainView.passwordField.text;
    if (![password isEqualToString:passwordAgain]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提现密码不一致，请重新输入。" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    
}
- (void)addLables{
    UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 320, 10)];
    UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 140, 320, 10)];
    UILabel *lable3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 210, 320, 10)];
    //[lable1 setFont:[UIFont systemFontOfSize:5.0]];
    lable1.text = @"原提现密码";
    lable2.text = @"新提现密码";
    lable3.text = @"新提现密码";
    [self.view addSubview:lable1];
    [self.view addSubview:lable2];
    [self.view addSubview:lable3];
}
- (void)addPreviousPasswordView{
    sixNumberPasswordView *view = [sixNumberPasswordView sixNumberPasswordView];
    view.frame = CGRectMake(0, 80, 320, 60);
    [self.view addSubview:view];
    self.PreviousPasswordView = view;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.passwordView.passwordField];
}
- (void)addNewPasswordView{
    sixNumberPasswordView *view = [sixNumberPasswordView sixNumberPasswordView];
    view.frame = CGRectMake(0, 150, 320, 60);
    [self.view addSubview:view];
    self.passwordView = view;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.passwordView.passwordField];
}
- (void)addNewPasswordAgainView{
    sixNumberPasswordView *view = [sixNumberPasswordView sixNumberPasswordView];
    view.frame = CGRectMake(0, 220, 320, 60);
    [self.view addSubview:view];
    self.passwordAgainView = view;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.passwordView.passwordField];
}
- (void)addConfirmBtn{
    UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 280, 320, 50)];
    self.confirmBtn = confirmBtn;
    [confirmBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [self.view addSubview:confirmBtn];
    [confirmBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //[self.confirmBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //self.confirmBtn.enabled = NO;
}
- (void)textChange{
    if (self.PreviousPasswordView.passwordField.text.length >= 6 && self.passwordView.passwordField.text.length >= 6 && self.passwordAgainView.passwordField.text.length >= 6) {
        self.confirmBtn.enabled = YES;
    }
    else self.confirmBtn.enabled = NO;
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
