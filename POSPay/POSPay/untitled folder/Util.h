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
//#import
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

+ (NSString *)encryptWithText:(NSString *)sText;//加密
+ (NSString *)decryptWithText:(NSString *)sText;//解密


// 把一个byte数据转换为字符串
+(NSString *) parseByte2HexString:(Byte *) bytes;
// 把一个byte数组转换为字符串
+(NSString *) parseByteArray2HexString:(Byte[]) bytes;

+(NSString *)MD5WithStringArray:(NSMutableArray *)array;

// nsData 转16进制
+ (NSString*)stringWithHexBytes2:(NSData *)sender;



/****** 加密 ******/
+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key;
/****** 解密 ******/
+(NSString *) decryptUseDES:(NSString *)plainText key:(NSString *)key;


+(NSString *) encryptUseDESTwo:(NSString *)clearText key:(NSString *)key;
// 加密
+(NSString *)encodeStringWithThirdPartyCode:(NSString *)code;
// 解密

+(NSString *)decryptStringWithThirdPartyCode:(NSString *)code;

+ (NSString *)encodeToPercentEscapeString: (NSString *) input;


+ (NSString *)decodeFromPercentEscapeString: (NSString *) input;

+(NSData *)HexConvertToASCII:(NSString *)hexString;

+(NSString *)ConvertASCIIToHex:(NSString *)assicString;

+(NSString *)encodeASCIIToThirdParty3DES:(NSString *)code;

@end
