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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addPreviousPasswordView{
    sixNumberPasswordView *view = [sixNumberPasswordView sixNumberPasswordView];
    view.frame = CGRectMake(0, 70, 320, 60);
    [self.view addSubview:view];
    self.PreviousPasswordView = view;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.passwordView.passwordField];
}
- (void)addNewPasswordView{
    sixNumberPasswordView *view = [sixNumberPasswordView sixNumberPasswordView];
    view.frame = CGRectMake(0, 140, 320, 60);
    [self.view addSubview:view];
    self.passwordView = view;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.passwordView.passwordField];
}
- (void)addNewPasswordAgainView{
    sixNumberPasswordView *view = [sixNumberPasswordView sixNumberPasswordView];
    view.frame = CGRectMake(0, 210, 320, 60);
    [self.view addSubview:view];
    self.passwordAgainView = view;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.passwordView.passwordField];
}
- (void)addConfirmBtn{
    UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 270, 320, 50)];
    self.confirmBtn = confirmBtn;
    [confirmBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [self.view addSubview:confirmBtn];
    [confirmBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
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
