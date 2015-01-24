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
    
    return sharedAccountManagerInstance;
    
}

-(void)setUserInfoWithDic:(NSDictionary *)dic{
    
    _phoneNum = dic[@"mobile"];
    _randomCode = dic[@"random_key"];
    
}

@end
