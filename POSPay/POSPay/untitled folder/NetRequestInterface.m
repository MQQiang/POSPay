//
//  NetRequestInterface.m
//  POSPay
//
//  Created by mq on 15/1/11.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "NetRequestInterface.h"
#import "AFNetworking.h"

@implementation NetRequestInterface

-(void)registerUser{
    
    // 手机号
    // 登入密码
    // 提现密码
    // 手机验证码
    // 签名
    
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
//    
//    NSDictionary *parameters = @{@"type":@"shortIntro",@"id":[NSNumber numberWithUnsignedInteger:_journeyId ]};
//    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//       
//        
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"Error: %@", error);
//        
//    }];
    NSString *pw = [Util encodeStringWithMD5:@"mobile123456"];
    NSString *stPw = [Util encodeStringWithMD5:@"mobile123456"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];
    
    NSString *checkCode = [Util encodeStringWithMD5:[[[[[[[[Util appKey] stringByAppendingString:[Util appVersion] ]stringByAppendingString:@"phonepay.scl.pos.user.reg" ] stringByAppendingString:@"13656678405"] stringByAppendingString:pw] stringByAppendingString:stPw]stringByAppendingString:@"1234"] stringByAppendingString:[Util signSuffix]] ];
    //    NSString *sign = [checkCode stringByAppendingString:[Util signSuffix]];
    
    NSDictionary *parameters = @{@"app_key":[Util appKey],@"version":[Util appVersion],@"service_type":@"phonepay.scl.pos.user.reg",@"mobile":@"13656678405",@"login_pwd":pw,@"settle_pwd":stPw,@"sign":checkCode,@"phone_check_code":@"1234"};
    
    [manager POST:[Util baseServerUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if([dic[@"rsp_code"] isEqualToString:@"0000"]){
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"注册成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"立即登录", nil];
            [alertView show];
            
        }
        else{
            
            
            [[[UIAlertView  alloc] initWithTitle:@"注册失败" message:@"请检查用户名密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
            
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        NSLog(@"%@",operation.responseObject);
    }];
    

}
-(void)loginUser{
    // 手机号
    //登入密码
    // 签名
    
    //
    //    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    //
    //    NSDictionary *parameters = @{@"type":@"shortIntro",@"id":[NSNumber numberWithUnsignedInteger:_journeyId ]};
    //    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //
    //
    //
    //
    //
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //
    //        NSLog(@"Error: %@", error);
    //        
    //    }];
    
    
}

-(void)alterPasswordWithType:(NSInteger)type;{
    
    // 手机号
    // 密码类型
    // 旧密码
    // 新密码
    // 签名
    
    
}
-(void)requestUserInfo;{
    
    // 手机号
    // 签名
    
    
}
-(void)consummateUserInfo{
    
    //手机号
    //姓名
    // 身份证号
    // 正面照
    //背面照
    // 身份证与本人照
    // 签名
    
    
}

-(void)requestRateWithType:(NSInteger)type{
    //"费率类型分为：01:刷卡支付;
   // 02：快捷支付；03:转账汇款;04:系统转账;05:用户及时提现"
    
    // 手机号
    // 费率类型
    //签名
    

    
    
}

-(void)paywithCard{
    
    // 手机号
    // 设备id
    // 设备类型
    //二磁导信息
    //IC卡序列号
    //IC卡数据
    // 卡密信息
    // 消费金额
    // 费率类型

    // 费率id
    // 签名
    
    
}
-(void)payInQuick{
    
    // 设备id
    //设备类型
    //手机号
    //费率类型
    // 费率id
    //消费金额
    // 签名
    
    
}

-(void)slotCardToPayOrTurn{
    // 设备id
    //设备类型
    
    // 汇款人卡密信息
    //汇款人卡磁信息
    
    // 转账金额
    // 收款人姓名
    //收款行联航号
    
    //手机号
    //费率类型
    // 费率id
 
    
}
-(void)turnWithSystemAccount{
    
    // 设备id
    //设备类型
    //手机号
    
    // 提现密码
    // 转账金额
    
    // 收款人帐号
    // 收款人姓名
    // 收款行联行号
    
}

-(void)addCashCard{
    
    // 用户手机号
    //银行卡号
    // 银行名称
    //联行号
    
}

-(void)checkCashAccount{
    
    // 用户手机号
    
}

-(void)turnCashWithType:(NSInteger)type{
    
     // 用户手机号
    // 提现类型
    // 提现金额
    //提现密码
    // 手机验证码
    
}

-(void)requestPayRecords{
    
    // 手机号
    // 开始时间
    // 结束时间
    // 开始记录数
    // 偏移量
    
    
}

-(void)requestMyMessage{
    
    // 手机号
    // 公告类型
    // 开始记录数
    // 偏移量
    
    
}

@end
