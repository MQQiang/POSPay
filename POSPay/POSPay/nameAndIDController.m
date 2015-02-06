//
//  nameAndIDController.m
//  POSPay
//
//  Created by 齐立洋 on 15/2/2.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "nameAndIDController.h"
#import "authenticationInfo.h"
#import "passwordController.h"

@interface nameAndIDController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *identifyingCodeField;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) authenticationInfo *userInfo;


- (IBAction)nextBtnClick;

@end


@implementation nameAndIDController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.identifyingCodeField];
    self.nextBtn.enabled = NO;
    [self.nameField becomeFirstResponder];
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
    if (self.nameField.text.length && self.identifyingCodeField.text.length) {
        self.nextBtn.enabled = YES;
    }
    else self.nextBtn.enabled = NO;
}

- (IBAction)nextBtnClick {
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    authenticationInfo *userInfo = [[authenticationInfo alloc]init];
    self.userInfo = userInfo;
    userInfo.name = self.nameField.text;
    userInfo.IDnumber = self.identifyingCodeField.text;
    passwordController *passwordController = segue.destinationViewController;
    passwordController.userInfo = userInfo;
}

@end
