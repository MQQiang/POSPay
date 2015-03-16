//
//  bankCardInfo.h
//  POSPay
//
//  Created by 齐立洋 on 15/3/16.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface bankCardInfo : NSObject
@property (copy, nonatomic) NSString *backgroundImage;
@property (copy, nonatomic) NSString *bankImage;
@property (copy, nonatomic) NSString *bankName;
@property (copy, nonatomic) NSString *bankCardType;
@property (copy, nonatomic) NSString *bankNumber;

@end
