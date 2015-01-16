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
