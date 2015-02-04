//
//  LoginViewController.m
//  POSPay
//
//  Created by 齐立洋 on 15/1/16.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "LoginViewController.h"
#import "UserInfo.h"
@interface LoginViewController ()


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self loginUser];
    [self changePasswordWithType:0];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginUser{
//     手机号
//    登入密码
//     签名
    if ([_phoneNumber.text isEqualToString:@""]||[_password.text isEqualToString:@""]) {
        
         [[[UIAlertView  alloc] initWithTitle:@"登录失败" message:@"请检查用户名密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
        
    }
    
    NSString *phoneNumber = _phoneNumber.text;
    NSString *pw = [Util passwordStringInMD5:_password.text];

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];
    
    NSString *checkCode = [Util encodeStringWithMD5:[[[[[[Util appKey] stringByAppendingString:[Util appVersion] ]stringByAppendingString:@"phonepay.scl.pos.user.login" ] stringByAppendingString:phoneNumber] stringByAppendingString:pw]  stringByAppendingString:[Util signSuffix]] ];
    
    
    
    NSDictionary *parameters = @{@"app_key":[Util appKey],@"version":[Util appVersion],@"service_type":@"phonepay.scl.pos.user.login",@"mobile":@"13656678405",@"login_pwd":pw,@"sign":checkCode};
    
        [manager GET:[Util baseServerUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
            NSLog(@"%@",responseObject);
            NSDictionary *dic = (NSDictionary *)responseObject;
            if([dic[@"rsp_code"] isEqualToString:@"0000"]){
                
                [[UserInfo sharedUserinfo] setUserInfoWithDic:dic];
                
            }
            else{
                
                
                [[[UIAlertView  alloc] initWithTitle:@"登录失败" message:@"请检查用户名密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
                
                
            }
    
    
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
            NSLog(@"Error: %@", error);
    
            [Util alertNetworkError:self.view];
        }];
    
    
}

-(void)requestUserInfo;{
    
    // 手机号
    // 签名
    
    
}

-(void)changePasswordWithType:(NSInteger)type{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *pw = [Util encodeStringWithMD5:@"mobile123456"];
    NSString *new_pw = [Util encodeStringWithMD5:@"mobile12345"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];
    
//    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
   manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *checkCode = [Util encodeStringWithMD5:[[[[[[[[Util appKey] stringByAppendingString:[Util appVersion] ]stringByAppendingString:@"phonepay.scl.pos.user.mdy.pwd" ] stringByAppendingString:[[NSNumber numberWithInteger:type] stringValue] ] stringByAppendingString:@"13656678405"] stringByAppendingString:pw]  stringByAppendingString:new_pw ] stringByAppendingString:[Util signSuffix]]];
    
    
    
    NSDictionary *parameters = @{@"app_key":[Util appKey],@"version":[Util appVersion],@"service_type":@"phonepay.scl.pos.user.mdy.pwd",@"mobile":@"13656678405",@"pwd_type":@"0",@"old_pwd":pw,@"new_pwd":new_pw,@"sign":checkCode};
    
    [manager POST:[Util baseServerUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        if([dic[@"rsp_code"] isEqualToString:@"0000"]){
            
            [[UserInfo sharedUserinfo] setUserInfoWithDic:dic];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }
        else{
            
            
            [[[UIAlertView  alloc] initWithTitle:@"登录失败" message:@"请检查用户名密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
              [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        
        
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

@end
