//
//  changeTixianPasswordViewController.m
//  POSPay
//
//  Created by 齐立洋 on 15/2/7.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "changeTixianPasswordViewController.h"
#import "sixNumberPasswordView.h"
#import "UserInfo.h"
@interface changeTixianPasswordViewController ()
@property (strong, nonatomic) IBOutlet UITextField *originPasswordTextField;
//@property (strong, nonatomic) IBOutlet UITextField *newPasswordTextField;
@property (strong, nonatomic) IBOutlet UITextField *againPasswordTextField;


- (IBAction)clickChangeButton:(id)sender;
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


-(void)changePasswordWithType:(NSInteger)type{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *pw = [Util encodeStringWithMD5:@"mobile123456"];
    NSString *new_pw = [Util encodeStringWithMD5:@"mobile123456"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];
    
    //    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    //   manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *checkCode = [Util encodeStringWithMD5:[[[[[[[[Util appKey] stringByAppendingString:[Util appVersion] ]stringByAppendingString:@"phonepay.scl.pos.user.mdy.pwd" ] stringByAppendingString:@"13656678405" ] stringByAppendingString:[[NSNumber numberWithInteger:type] stringValue]] stringByAppendingString:pw]  stringByAppendingString:new_pw ]  stringByAppendingString:[UserInfo sharedUserinfo].randomCode]];
    
    
    
    NSDictionary *parameters = @{@"app_key":[Util appKey],@"version":[Util appVersion],@"service_type":@"phonepay.scl.pos.user.mdy.pwd",@"mobile":@"13656678405",@"pwd_type":@"1",@"old_pwd":pw,@"new_pwd":new_pw,@"sign":checkCode};
    
    [manager POST:[Util baseServerUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        if([dic[@"rsp_code"] isEqualToString:@"0000"]){
            
            //            [[UserInfo sharedUserinfo] setUserInfoWithDic:dic];
            
            //            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [[[UIAlertView  alloc] initWithTitle:@"" message:@"密码修改成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
        }
        else{
            
            
            [[[UIAlertView  alloc] initWithTitle:@"修改密码失败" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
            
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        NSLog(@"operation: %@", operation.responseString);
        
        [Util alertNetworkError:self.view];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickChangeButton:(id)sender {
    
    [self changePasswordWithType:1];
}
@end
