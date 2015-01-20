//
//  Util.h
//  POSPay
//
//  Created by mq on 15/1/4.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

+(NSString *)encodeStringWithMD5:(NSString *)string;
+(NSString *)baseServerUrl;
+(NSString *)appKey;
+(NSString *)appVersion;
@end
