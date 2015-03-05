//
//  UserInfo.m
//  POSPay
//
//  Created by mq on 15/1/16.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

+(UserInfo *)sharedUserinfo{
    
    static UserInfo *sharedAccountManagerInstance = nil;
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    
    sharedAccountManagerInstance.isUserLogin = false;
    
    return sharedAccountManagerInstance;
    
}

-(void)setUserInfoWithDic:(NSDictionary *)dic{
    
    _isUserLogin = YES;
    _phoneNum = dic[@"mobile"];
    
    NSString *code = dic[@"random_key"];
    
    
    _randomCode = code;
    
}
-(void)setDetailUserInfo:(NSDictionary *)dic{
    
    _cardNumber = dic[@"cred_no"];
    _name = dic[@"real_name"];
    _checkUrl = dic[@"bank_union_qry_url"];
    
}
@end
