//
//  UserInfo.h
//  POSPay
//
//  Created by mq on 15/1/16.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

+(UserInfo *)sharedUserinfo;
@property(nonatomic,strong)NSString *randomCode;
@property(nonatomic,strong)NSString *phoneNum;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *settlePassword;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *cardNumber;
@property(nonatomic,strong)NSString *checkUrl;
@property(nonatomic,assign)BOOL isUserLogin;
-(void)setUserInfoWithDic:(NSDictionary *)dic;
-(void)setDetailUserInfo:(NSDictionary *)dic;
@end
