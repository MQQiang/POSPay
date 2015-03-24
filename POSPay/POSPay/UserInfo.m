//
//  UserInfo.m
//  POSPay
//
//  Created by mq on 15/1/16.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "UserInfo.h"
#import "Util.h"


@implementation UserInfo

+(UserInfo *)sharedUserinfo{
    
    static UserInfo *sharedAccountManagerInstance = nil;
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
        sharedAccountManagerInstance.isUserLogin = false;
        sharedAccountManagerInstance.hasDetailInfo = false;
    });
    
    return sharedAccountManagerInstance;
    
}

-(void)setUserInfoWithDic:(NSDictionary *)dic{
    
    _isUserLogin = YES;
    _phoneNum = dic[@"mobile"];
    
    NSString *code = dic[@"random_key"];
    
    
    _randomCode = [Util decryptStringWithThirdPartyCode:code];
    
}
-(void)setDetailUserInfo:(NSDictionary *)dic{
    
    _hasDetailInfo = true;
    _checkStatus = dic[@"verify_status"];
    _cardNumber = dic[@"cred_no"];
    _name = dic[@"real_name"];
    _checkUrl = dic[@"bank_union_qry_url"];
    _myAssets = dic[@"my_assets"];
    _canExtractAmount = dic[@"extract_amount"];
    
    
    if ([_checkStatus isEqualToString:@"0"]) {
        _checkDetailString = @"未认证";
    }
    else if([_checkStatus isEqualToString:@"1"]){
        
        _checkDetailString = @"审核通过";
    }
    else if([_checkStatus isEqualToString:@"2"]){
        
        _checkDetailString = @"驳回";
    }
    
    _cannotExtractAmount = @0;

}
@end
