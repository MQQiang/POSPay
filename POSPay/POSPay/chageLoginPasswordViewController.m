//
//  chageLoginPasswordViewController.m
//  POSPay
//
//  Created by 齐立洋 on 15/2/7.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "chageLoginPasswordViewController.h"
#import "UserInfo.h"
@interface chageLoginPasswordViewController ()
@property (strong, nonatomic) IBOutlet UITextField *originPasswordTextField;
//@property (strong, nonatomic) IBOutlet UITextField *newPasswordTextField;
@property (strong, nonatomic) IBOutlet UITextField *againPasswordTextField;
- (IBAction)clickChangeButton:(id)sender;

@end

@implementation chageLoginPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)clickChangeButton:(id)sender {
    
    [self changePasswordWithType:0];
}

-(void)changePasswordWithType:(NSInteger)type{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *pw = [Util encodeStringWithMD5:@"mobile123456"];
    NSString *new_pw = [Util encodeStringWithMD5:@"mobile123456"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];
    
    //    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    //   manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *checkCode = [Util encodeStringWithMD5:[[[[[[[[Util appKey] stringByAppendingString:[Util appVersion] ]stringByAppendingString:@"phonepay.scl.pos.user.mdy.pwd" ] stringByAppendingString:[UserInfo sharedUserinfo].phoneNum ] stringByAppendingString:[[NSNumber numberWithInteger:type] stringValue]] stringByAppendingString:pw]  stringByAppendingString:new_pw ]  stringByAppendingString:[UserInfo sharedUserinfo].randomCode]];
    
    
    
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
@end
