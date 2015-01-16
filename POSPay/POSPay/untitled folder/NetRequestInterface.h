//
//  NetRequestInterface.h
//  POSPay
//
//  Created by mq on 15/1/11.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetRequestInterface : NSObject

-(void)registerUser;
-(void)loginUser;
-(void)alterPasswordWithType:(NSInteger)type;
-(void)requestUserInfo;
-(void)consummateUserInfo;
-(void)requestRateWithType:(NSInteger)type;
-(void)paywithCard;
-(void)payInQuick;
-(void)slotCardToPayOrTurn;

-(void)turnWithSystemAccount;

-(void)addCashCard;

-(void)checkCashAccount;

-(void)turnCashWithType:(NSInteger)type;

-(void)requestPayRecords;

-(void)requestMyMessage;
@end
