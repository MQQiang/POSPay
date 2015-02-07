//
//  Util.m
//  POSPay
//
//  Created by mq on 15/1/4.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "Util.h"
#import "GTMBase64.h"
#import "AFNetworking.h"

#define kChosenDigestLength		CC_SHA1_DIGEST_LENGTH

#define DESKEY @"D6D2402F1C98E208FF2E863AA29334BD65AE1932A821502D9E5673CDE3C713ACFE53E2103CD40ED6BEBB101B484CAE83D537806C6CB611AEE86ED2CA8C97BBE95CF8476066D419E8E833376B850172107844D394016715B2E47E0A6EECB3E83A361FA75FA44693F90D38C6F62029FCD8EA395ED868F9D718293E9C0E63194E87"

@implementation Util

+(NSString *)encodeStringWithMD5:(NSString *)string{
    
    const char *original_str = [string UTF8String];//string为摘要内容，转成char
    
    /****系统api~~~~*****/
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);//调通系统md5加密
    NSMutableString *hash = [NSMutableString new];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    
    return hash ;//校验码
    
}

+(NSString *) doCipher:(NSString *)plainText operation:(CCOperation)encryptOrDecrypt
{
    const void * vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        NSData * EncryptData = [GTMBase64 decodeData:[plainText
                                                      dataUsingEncoding:NSUTF8StringEncoding]];
        
        plainTextBufferSize = [EncryptData length];
        vplainText = [EncryptData bytes];
    }
    else
    {
        NSData * tempData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [tempData length];
        vplainText = [tempData bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t * bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    // uint8_t ivkCCBlockSize3DES;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES)
    & ~(kCCBlockSize3DES - 1);
    
    bufferPtr = malloc(bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    NSString * key = @"123456789012345678901234";
    NSString * initVec = @"init Vec";
    
    const void * vkey = (const void *)[key UTF8String];
    const void * vinitVec = (const void *)[initVec UTF8String];
    
    uint8_t iv[kCCBlockSize3DES];
    memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey, //"123456789012345678901234", //key
                       kCCKeySize3DES,
                       vinitVec, //"init Vec", //iv,
                       vplainText, //plainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    //if (ccStatus == kCCSuccess) NSLog(@"SUCCESS");
    if (ccStatus == kCCParamError) return @"PARAM ERROR";
    else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
    else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
    else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
    else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
    else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED";
    
    NSString * result;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        result = [[NSString alloc] initWithData:[NSData
                                                  dataWithBytes:(const void *)bufferPtr
                                                  length:(NSUInteger)movedBytes] 
                                        encoding:NSUTF8StringEncoding];
    }
    else
    {
        NSData * myData = [NSData dataWithBytes:(const void *)bufferPtr
                                         length:(NSUInteger)movedBytes];
        
        result = [GTMBase64 stringByEncodingData:myData];
    }
    
    return result;
    
}

+(NSString *)baseServerUrl{
    
    return @"http://stronglion2010.gicp.net:8099/yhk_cust_sys/scl_pos";
//    return @"http://183.14.162.254:8099/yhk_cust_sys/scl_pos";
    
   
}
+(NSString *)appKey{
    return @"01010101";
}
+(NSString *)appVersion{
    
    return @"1.0.1";
}

+(NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt
{
    
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt)//解密
    {
        NSData *EncryptData = [GTMBase64 decodeData:[plainText dataUsingEncoding:NSUTF8StringEncoding]];
        plainTextBufferSize = [EncryptData length];
        vplainText = [EncryptData bytes];
    }
    else //加密
    {
        NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [data length];
        vplainText = (const void *)[data bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    // memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    const void *vkey = (const void *)[DESKEY UTF8String];
    // NSString *initVec = @"init Vec";
    //const void *vinitVec = (const void *) [initVec UTF8String];
    //  Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey,
                       kCCKeySize3DES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    //if (ccStatus == kCCSuccess) NSLog(@"SUCCESS");
    /*else if (ccStatus == kCC ParamError) return @"PARAM ERROR";
     else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
     else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
     else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
     else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
     else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED"; */
    
    NSString *result;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                length:(NSUInteger)movedBytes]
                                        encoding:NSUTF8StringEncoding]
                ;
    }
    else
    {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [GTMBase64 stringByEncodingData:myData];
    }
    
    return result;
}
+(NSString *)signSuffix{
    
    return @"3F53BC47C0165EF589586E475452A227";
}

+(void)alertNetworkError:(UIView *)view{
    
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
    
    
    [[[UIAlertView  alloc] initWithTitle:@"网络错误" message:@"请检查网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
    
}

+(NSString *)passwordStringInMD5:(NSString *)pw{
    
    NSString *mPw = [@"mobile" stringByAppendingString:pw];
    
    
    return  [Util encodeStringWithMD5:mPw];
    
}
+(BOOL)inputIsNull:(UITextField *)textField{
    
    return  [textField.text isEqualToString:@""];
    
}

@end
