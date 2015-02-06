//
//  authenticationInfo.h
//  POSPay
//
//  Created by 齐立洋 on 15/2/6.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface authenticationInfo : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *IDnumber;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) UIImage *mainImage;
@property (strong, nonatomic) UIImage *frontImage;
@property (strong, nonatomic) UIImage *backImage;
@end
