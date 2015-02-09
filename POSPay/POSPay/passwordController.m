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
#import "sixNumberPasswordView.h"
@interface passwordController ()
@property (strong, nonatomic) sixNumberPasswordView *passwordView;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

- (IBAction)nextBtnClick;


@end

@implementation passwordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackBtn];
    sixNumberPasswordView *passwordView = [sixNumberPasswordView sixNumberPasswordView];
    self.passwordView = passwordView;
    passwordView.frame = CGRectMake(0, 90, 320, 60);
    [self.view addSubview:passwordView];
    self.nextBtn.enabled = NO;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.passwordView.passwordField];
    
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

- (void)textChange{
    if (self.passwordView.passwordField.text.length >= 6) {
        self.nextBtn.enabled = YES;
    }
    else self.nextBtn.enabled = NO;
}
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
    self.userInfo.password = self.passwordView.passwordField.text;
    pictureController *pictureController = segue.destinationViewController;
    pictureController.userInfo = self.userInfo;
}
@end
