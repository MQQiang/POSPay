//
//  Util.h
//  POSPay
//
//  Created by mq on 15/1/4.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <UIKit/UIKit.h>
#import <Security/Security.h>

@interface Util : NSObject

+(NSString *)encodeStringWithMD5:(NSString *)string;
+(NSString *)baseServerUrl;
+(NSString *)appKey;
+(NSString *)appVersion;
+(NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt;
+(NSString *)signSuffix;

+(void)alertNetworkError:(UIView *)view;
+(NSString *)passwordStringInMD5:(NSString *)pw;
+(BOOL)inputIsNull:(UITextField *)textField;
@end
