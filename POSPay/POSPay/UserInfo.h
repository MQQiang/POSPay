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

// 联行号查询地址；
@property(nonatomic,strong)NSString *checkUrl;


//0 未审核 1 通过 2 驳回 // 审核状态
@property(nonatomic,strong)NSString *checkStatus;

// 账户金额
@property(nonatomic,strong)NSNumber *myAssets;
@property(nonatomic,assign)BOOL isUserLogin;

// 可提现金额
@property(nonatomic,strong)NSNumber *canExtractAmount;


-(void)setUserInfoWithDic:(NSDictionary *)dic;


-(void)setDetailUserInfo:(NSDictionary *)dic;
@end
