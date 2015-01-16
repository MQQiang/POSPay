//
//  AppConstants.m
//  POSPay
//
//  Created by mq on 15/1/11.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "AppConstants.h"
@implementation AppConstants
+(NSString *)HttpAddressPrex{
    
     NSString * retString = @"http://scl.phonepay.com/scl_pos";
    
    return retString;
}

+(NSString *)AppVersion{
    
    NSString * retString = @"1.0";
    return retString;
    
}
@end
