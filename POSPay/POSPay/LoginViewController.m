//
//  LoginViewController.m
//  POSPay
//
//  Created by 齐立洋 on 15/1/16.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "LoginViewController.h"
#import "UserInfo.h"
#import "POSPaintViewController.h"

@interface LoginViewController ()
- (IBAction)cancel:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loginUser];
    
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
//    if ([_phoneNumber.text isEqualToString:@""]||[_password.text isEqualToString:@""]) {
//        
//         [[[UIAlertView  alloc] initWithTitle:@"登录失败" message:@"请检查用户名密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
//        
//    }
//    
//    NSString *phoneNumber = _phoneNumber.text;
//    NSString *pw = [Util passwordStringInMD5:_password.text];
    NSString *phoneNumber = @"13656678406";
    NSString *pw = @"123456";
    
    pw = [Util passwordStringInMD5:pw];
    
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];
    
    NSString *checkCode = [Util encodeStringWithMD5:[[[[[[Util appKey] stringByAppendingString:[Util appVersion] ]stringByAppendingString:@"phonepay.scl.pos.user.login" ] stringByAppendingString:phoneNumber] stringByAppendingString:pw]  stringByAppendingString:[Util signSuffix]] ];
    
    
    
    NSDictionary *parameters = @{@"app_key":[Util appKey],@"version":[Util appVersion],@"service_type":@"phonepay.scl.pos.user.login",@"mobile":phoneNumber,@"login_pwd":pw,@"sign":checkCode};
    
        [manager GET:[Util baseServerUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
            NSLog(@"%@",responseObject);
            NSDictionary *dic = (NSDictionary *)responseObject;
            if([dic[@"rsp_code"] isEqualToString:@"0000"]){
                
                [[UserInfo sharedUserinfo] setUserInfoWithDic:dic];
//                  [self cancel:nil];
//                [self changePasswordWithType:1];
//                [self requestUserInfo];
                
//                [self perfectUserInfo];
                
            }else if([dic[@"rsp_code"] isEqualToString:@"6010"]){
                
                  [[[UIAlertView  alloc] initWithTitle:@"登录失败" message:@"密码错误次数超限" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
                
            }
            
            else{
                
                
                [[[UIAlertView  alloc] initWithTitle:@"登录失败" message:@"请检查用户名密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
                
                
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
    
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSLog(@"Error: %@", error);
    
            [Util alertNetworkError:self.view];
        }];
    
    
}

-(void)requestUserInfo;{
    
    // 手机号
    // 签名
    
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];
    
    
    NSString *checkCode = [Util encodeStringWithMD5:[[[[[Util appKey] stringByAppendingString:[Util appVersion] ]stringByAppendingString:@"phonepay.scl.pos.user.qry"] stringByAppendingString: [UserInfo sharedUserinfo].phoneNum]   stringByAppendingString:[UserInfo sharedUserinfo].randomCode]];
    
    
    
    NSDictionary *parameters = @{@"app_key":[Util appKey],@"version":[Util appVersion],@"service_type":@"phonepay.scl.pos.user.qry",@"mobile":[UserInfo sharedUserinfo].phoneNum,@"sign":checkCode};
    
    [manager POST:[Util baseServerUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        if([dic[@"rsp_code"] isEqualToString:@"0000"]){
            
                        [[UserInfo sharedUserinfo] setDetailUserInfo:dic];

            
        }
        else{
            
            
            [[[UIAlertView  alloc] initWithTitle:@"查询用户信息失败" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
            
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        NSLog(@"operation: %@", operation.responseString);
        
        [Util alertNetworkError:self.view];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    

    
    
    
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

-(void)requesPayFeiWithType:(NSInteger)type{
    
    // 手机号
    // 签名
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];
    

    
    NSString *checkCode = [Util encodeStringWithMD5:[[[[[[Util appKey] stringByAppendingString:[Util appVersion] ]stringByAppendingString:@"phonepay.scl.pos.settle.qryrate"] stringByAppendingString:@"13656678405" ]   stringByAppendingString:[[NSNumber numberWithInteger:type] stringValue]]stringByAppendingString:[UserInfo sharedUserinfo].randomCode]];
    
    
    
    NSDictionary *parameters = @{@"app_key":[Util appKey],@"version":[Util appVersion],@"service_type":@"phonepay.scl.pos.settle.qryrate",@"mobile":@"13656678405",@"rate_type":[[NSNumber numberWithInteger:type] stringValue],@"sign":checkCode};
    
    [manager POST:[Util baseServerUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        if([dic[@"rsp_code"] isEqualToString:@"0000"]){
            
            //            [[UserInfo sharedUserinfo] setUserInfoWithDic:dic];
            
            //            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [[[UIAlertView  alloc] initWithTitle:@"" message:@"密码修改成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
        }
        else{
            
            
            [[[UIAlertView  alloc] initWithTitle:@"查询用户信息失败" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
            
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        NSLog(@"operation: %@", operation.responseString);
        
        [Util alertNetworkError:self.view];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}


-(void)payByCard{
    
    // 手机号
    // 签名
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];
    
    NSString *checkCode = [Util encodeStringWithMD5:[[[[[[[Util appKey] stringByAppendingString:[Util appVersion] ]stringByAppendingString:@"phonepay.scl.pos.user.edite"] stringByAppendingString:@"13656678405"]   stringByAppendingString:@"MQ"]stringByAppendingString:@"210521198910181071"] stringByAppendingString: [UserInfo sharedUserinfo].randomCode]];
    
    
    UIImage *image  = [UIImage imageNamed:@"1_1280x800"];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    
    
    NSDictionary *parameters = @{@"app_key":[Util appKey],@"version":[Util appVersion],@"service_type":@"phonepay.scl.pos.settle.qryrate",@"mobile":@"13656678405",@"real_name":@"MQ",@"idcard_no":@"210521198910181071",@"cred_img_a":imageData,@"cred_img_b":imageData,@"cred_img_c":imageData,@"sign":checkCode};
    
    [manager POST:[Util baseServerUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        if([dic[@"rsp_code"] isEqualToString:@"0000"]){
            
            //            [[UserInfo sharedUserinfo] setUserInfoWithDic:dic];
            
            //            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [[[UIAlertView  alloc] initWithTitle:@"" message:@"密码修改成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
        }
        else{
            
            
            [[[UIAlertView  alloc] initWithTitle:@"查询用户信息失败" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
            
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        NSLog(@"operation: %@", operation.responseString);
        
        [Util alertNetworkError:self.view];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    
    
    
    
}

-(void)payByQuickWay{
    // 快捷支付
    // 手机号
    // 签名
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];
    
    NSString *checkCode = [Util encodeStringWithMD5:[[[[[[[Util appKey] stringByAppendingString:[Util appVersion] ]stringByAppendingString:@"phonepay.scl.pos.user.edite"] stringByAppendingString:@"13656678405"]   stringByAppendingString:@"MQ"]stringByAppendingString:@"210521198910181071"] stringByAppendingString: [UserInfo sharedUserinfo].randomCode]];
    
    
    UIImage *image  = [UIImage imageNamed:@"1_1280x800"];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    
    
    NSDictionary *parameters = @{@"app_key":[Util appKey],@"version":[Util appVersion],@"service_type":@"phonepay.scl.pos.settle.qryrate",@"mobile":@"13656678405",@"real_name":@"MQ",@"idcard_no":@"210521198910181071",@"cred_img_a":imageData,@"cred_img_b":imageData,@"cred_img_c":imageData,@"sign":checkCode};
    
    [manager POST:[Util baseServerUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        if([dic[@"rsp_code"] isEqualToString:@"0000"]){
            
            //            [[UserInfo sharedUserinfo] setUserInfoWithDic:dic];
            
            //            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [[[UIAlertView  alloc] initWithTitle:@"" message:@"密码修改成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
        }
        else{
            
            
            [[[UIAlertView  alloc] initWithTitle:@"查询用户信息失败" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
            
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        NSLog(@"operation: %@", operation.responseString);
        
        [Util alertNetworkError:self.view];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    
    
    
    
}

-(void)perfectUserInfo{
    
    
    UIImage * image = [UIImage imageNamed:@"14"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];
    
 
    
    NSString *checkCode = [Util encodeStringWithMD5:[[[[[[Util appKey] stringByAppendingString:[Util appVersion] ]stringByAppendingString:@"phonepay.scl.pos.user.edite"] stringByAppendingString:[UserInfo sharedUserinfo].phoneNum] stringByAppendingString:@"210521198910181071"] stringByAppendingString: [UserInfo sharedUserinfo].randomCode]];
    
    NSDictionary *parameters = @{@"app_key":[Util appKey],@"version":[Util appVersion],@"service_type":@"phonepay.scl.pos.user.edite",@"mobile":[UserInfo sharedUserinfo].phoneNum,@"real_name":@"孟强",@"idcard_no":@"210521198910181071",@"sign":checkCode};
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:[Util baseServerUrl] parameters: parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSData *fontImage = UIImageJPEGRepresentation(image, 1.0);
        
        NSData *backImage = UIImageJPEGRepresentation(image, 1.0);
        
        NSData *mainImage = UIImageJPEGRepresentation(image, 1.0);
        
        [formData appendPartWithFileData:fontImage name:@"cred_img_a" fileName:@"1.png" mimeType:@"image/jpg"];
        
        [formData appendPartWithFileData:backImage name:@"cred_img_b" fileName:@"1.png" mimeType:@"image/jpg"];
        
        [formData appendPartWithFileData:mainImage name:@"cred_img_c" fileName:@"1.png" mimeType:@"image/jpg"];
        
        
    } error:nil];
    
    AFHTTPRequestOperation *opration = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    opration.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript", nil];
    
    [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSDictionary * dic = (NSDictionary *)responseObject;
        
        NSLog(@"%@",dic);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [[[UIAlertView  alloc] initWithTitle:@"信息上传成功" message:@"请耐心等待审核" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"%@",error);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        [[[UIAlertView  alloc] initWithTitle:@"上传信息失败" message:@"请检查网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
    }];
    
    [manager.operationQueue addOperation:opration];

    
    
}

-(void)payToOtherAccount{
    
    // 快捷支付
    // 手机号
    // 签名
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];
    
    NSMutableArray *stringArray = [NSMutableArray arrayWithObjects:[Util appKey], [Util appVersion],[UserInfo sharedUserinfo].phoneNum,@"13656678405",[Util passwordStringInMD5:@"123456"],@"1234",@"20000",[Util signSuffix],nil];
    
    
    NSString *checkCode = [Util MD5WithStringArray:stringArray];

    
    
    NSDictionary *parameters = @{@"app_key":[Util appKey],@"version":[Util appVersion],@"service_type":@"phonepay.scl.pos.settle.qryrate",@"mobile":[UserInfo sharedUserinfo].phoneNum,@"to_mobile":@"13656678405",@"login_pwd":[Util passwordStringInMD5:@"123456"],@"phone_check_code":@"1234",@"trans_amt":@"20000",@"sign":checkCode};
    
    [manager POST:[Util baseServerUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        if([dic[@"rsp_code"] isEqualToString:@"0000"]){
            
            //            [[UserInfo sharedUserinfo] setUserInfoWithDic:dic];
            
            //            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [[[UIAlertView  alloc] initWithTitle:@"" message:@"转账成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
        }
        else{
            
            
            [[[UIAlertView  alloc] initWithTitle:@"转账失败" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
            
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        NSLog(@"operation: %@", operation.responseString);
        
        [Util alertNetworkError:self.view];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    
    
    
    
}


-(void)addBackCardInfo{

    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];
    
    NSMutableArray *stringArray = [NSMutableArray arrayWithObjects:[Util appKey], [Util appVersion],[UserInfo sharedUserinfo].phoneNum,@"123456789065445678900987654",[UserInfo sharedUserinfo].checkUrl,[Util signSuffix],nil];
    
    
    NSString *checkCode = [Util MD5WithStringArray:stringArray];
    
    
    
    NSDictionary *parameters = @{@"app_key":[Util appKey],@"version":[Util appVersion],@"service_type":@"phonepay.scl.pos.card.addcard",@"mobile":[UserInfo sharedUserinfo].phoneNum,@"card_user_name":@"孟强",@"card_no":@"123456789065445678900987654",@"bank_name":@"中国银行",@"bank_union_code":[UserInfo sharedUserinfo].checkUrl,@"sign":checkCode};
    
    [manager POST:[Util baseServerUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        if([dic[@"rsp_code"] isEqualToString:@"0000"]){
            
            //            [[UserInfo sharedUserinfo] setUserInfoWithDic:dic];
            
            //            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [[[UIAlertView  alloc] initWithTitle:@"" message:@"转账成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
        }
        else{
            
            
            [[[UIAlertView  alloc] initWithTitle:@"转账失败" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
            
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        NSLog(@"operation: %@", operation.responseString);
        
        [Util alertNetworkError:self.view];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    
    
    
    
}


-(void)requestReceiverAcount{
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];
    
    NSMutableArray *stringArray = [NSMutableArray arrayWithObjects:[Util appKey], [Util appVersion],@"phonepay.scl.pos.bankcard.qry",[UserInfo sharedUserinfo].phoneNum,@"2567890876543678900876",@"01",@"20",[Util passwordStringInMD5:@"123456"],@"1234",[Util signSuffix],nil];
    
    
    NSString *checkCode = [Util MD5WithStringArray:stringArray];
    
    
    
    NSDictionary *parameters = @{@"app_key":[Util appKey],@"version":[Util appVersion],@"service_type":@"phonepay.scl.pos.bankcard.qry",@"mobile":[UserInfo sharedUserinfo].phoneNum,@"card_no":@"2567890876543678900876",@"settle_type":@"01",@"settle_amt":@"20",@"login_pwd":[Util passwordStringInMD5:@"123456"],@"phone_check_code":@"1234",@"sign":checkCode};
    
    [manager POST:[Util baseServerUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        if([dic[@"rsp_code"] isEqualToString:@"0000"]){
            
            //            [[UserInfo sharedUserinfo] setUserInfoWithDic:dic];
            
            //            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [[[UIAlertView  alloc] initWithTitle:@"" message:@"转账成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
        }
        else{
            
            
            [[[UIAlertView  alloc] initWithTitle:@"转账失败" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
            
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        NSLog(@"operation: %@", operation.responseString);
        
        [Util alertNetworkError:self.view];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    
    
    
    
}

-(void)requestTradeRecords{
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];
    
    NSMutableArray *stringArray = [NSMutableArray arrayWithObjects:[Util appKey], [Util appVersion],@"phonepay.scl.pos.settle.qry",[UserInfo sharedUserinfo].phoneNum,@"1",@"20",[Util signSuffix],nil];
    
    
    NSString *checkCode = [Util MD5WithStringArray:stringArray];
    
    
    
    NSDictionary *parameters = @{@"app_key":[Util appKey],@"version":[Util appVersion],@"service_type":@"phonepay.scl.pos.settle.qry",@"mobile":[UserInfo sharedUserinfo].phoneNum,@"create_date":@"20150301000000",@"end_date":@"20150302000000",@"start_rows":@"1",@"offset":@"20",@"sign":checkCode};
    
    [manager POST:[Util baseServerUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        if([dic[@"rsp_code"] isEqualToString:@"0000"]){
            
            //            [[UserInfo sharedUserinfo] setUserInfoWithDic:dic];
            
            //            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [[[UIAlertView  alloc] initWithTitle:@"" message:@"转账成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
        }
        else{
            
            
            [[[UIAlertView  alloc] initWithTitle:@"转账失败" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
            
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        NSLog(@"operation: %@", operation.responseString);
        
        [Util alertNetworkError:self.view];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    
    
    
    
}

-(void)userBringUpMoney{
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];
    
    NSMutableArray *stringArray = [NSMutableArray arrayWithObjects:[Util appKey], [Util appVersion],[UserInfo sharedUserinfo].phoneNum,@"1",@"20",[Util signSuffix],nil];
    
    
    NSString *checkCode = [Util MD5WithStringArray:stringArray];
    
    
    
    NSDictionary *parameters = @{@"app_key":[Util appKey],@"version":[Util appVersion],@"service_type":@"phonepay.scl.pos.bankcard.qry",@"mobile":[UserInfo sharedUserinfo].phoneNum,@"create_date":@"20150301000000",@"end_date":@"20150302000000",@"start_rows":@"1",@"offset":@"20",@"sign":checkCode};
    
    [manager POST:[Util baseServerUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        if([dic[@"rsp_code"] isEqualToString:@"0000"]){
            
            //            [[UserInfo sharedUserinfo] setUserInfoWithDic:dic];
            
            //            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [[[UIAlertView  alloc] initWithTitle:@"" message:@"转账成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
        }
        else{
            
            
            [[[UIAlertView  alloc] initWithTitle:@"转账失败" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
            
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        NSLog(@"operation: %@", operation.responseString);
        
        [Util alertNetworkError:self.view];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

-(void)userShounldKnow{
    
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];
    
    NSMutableArray *stringArray = [NSMutableArray arrayWithObjects:[Util appKey], [Util appVersion],@"phonepay.scl.pos.msg.qry",[UserInfo sharedUserinfo].phoneNum,@"01",[Util signSuffix],nil];
    
    
    NSString *checkCode = [Util MD5WithStringArray:stringArray];
    
    
    
    NSDictionary *parameters = @{@"app_key":[Util appKey],@"version":[Util appVersion],@"service_type":@"phonepay.scl.pos.msg.qry",@"mobile":[UserInfo sharedUserinfo].phoneNum,@"notice_type":@"01",@"sign":checkCode};
    
    [manager POST:[Util baseServerUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        if([dic[@"rsp_code"] isEqualToString:@"0000"]){
            
            //            [[UserInfo sharedUserinfo] setUserInfoWithDic:dic];
            
            //            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [[[UIAlertView  alloc] initWithTitle:@"" message:@"转账成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
        }
        else{
            
            
            [[[UIAlertView  alloc] initWithTitle:@"转账失败" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
            
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

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
    
//    POSPaintViewController *vc = [[POSPaintViewController alloc] init];
//    
//    [self presentViewController:vc animated:YES completion:^{}];
    
    
}
@end
