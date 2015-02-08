//
//  NLISOUtils.h
//  MTypeSDK
//
//  Created by su on 13-6-27.
//  Copyright (c) 2013年 suzw. All rights reserved.
//
#import <Foundation/Foundation.h>
@interface NLISOUtils : NSObject
/**
 * converts to BCD
 * @param s - the number
 * @param padLeft - flag indicating left/right padding
 * @param d The byte array to copy into.
 * @param offset Where to start copying into.
 * @return BCD representation of the number
 */
+ (NSData*)str2bcd:(NSString*)s padLeft:(BOOL)padLeft offset:(int)offset;

/**
 * converts to BCD
 * @param s - the number
 * @param padLeft - flag indicating left/right padding
 * @return BCD representation of the number
 */
+ (NSData*) str2bcd:(NSString*)s padLeft:(BOOL)padLeft;

/**
 * converts to BCD
 * @param s - the number
 * @param padLeft - flag indicating left/right padding
 * @param fill - fill value
 * @return BCD representation of the number
 */
+ (NSData*) str2bcd:(NSString*)s padLeft:(BOOL)padLeft fill:(Byte)fill;

/**
 * pad to the left
 * @param s - original string
 * @param len - desired len
 * @param c - padding char
 * @return padded string
 * @ on error
 */
+ (NSString*) padleft:(NSString*)s len:(int)len ch:(char)c;

+ (NSData*) padLeft:(NSData*)tgt len:(int)len padding:(Byte)padding;

+ (NSData*) unpadLeft:(NSData*)tgt padding:(Byte)padding;

+ (NSData*) unpadRight:(NSData*)tgt padding:(Byte)padding;

+ (NSData*) padRight:(NSData*)tgt len:(int)len padding:(Byte)padding;

/**
 * pad to the right
 *
 * @param s -
 *            original string
 * @param len -
 *            desired len
 * @param c -
 *            padding char
 * @return padded string
 * @ if String's length greater than pad length
 */
+ (NSString*) padright:(NSString*)s len:(int)len ch:(char)c;

+ (int)unPackIntFromBytes:(NSData*)lenBytes offset:(int)offset len:(int)len isBigEndian:(BOOL) isBigEndian;

/**
 * 将整型转成2字节长度表示
 *
 * @param v
 * @param isBigEnd
 * @return
 */
+ (NSData*)packIntToBytes:(int)value len:(int)len isBigEndian:(BOOL)isBigEndian;

+ (NSData*)intToBCD:(int)input maxLen:(int)maxLen padLeft:(BOOL)padLeft;

+ (int)bcdToInt:(NSData*)input offset:(int)offset len:(int)len padLeft:(BOOL)padLeft;

+ (Byte)hexStr2byte:(char)c;

+ (NSData*)hexStr2Data:(NSString*)hexStr;

//////////////////////////////////////////////////////////////////////////
+(NSString *)ebcdicToAscii:(NSData *)e;
+ (NSString *) ebcdicToAscii:(NSData *)e offset:(int)offset length:(int)len;
+ (NSData *)ebcdicToAsciiBytes:(NSData *)e;
+ (NSData *)ebcdicToAsciiBytes:(NSData *)e offset:(int)offset length:(int)len;
+(NSData *)asciiToEbcdic:(NSString *)s;
+(NSData *)asciiDataToEbcdic:(NSData *)a;
/**
 * trim String (if not null)
 * @param s String to trim
 * @return String (may be null)
 */
+(NSString *)trim:(NSString *)s;
/**
 * left pad with '0'
 * @param s - original string
 * @param len - desired len
 * @return zero padded string
 * @ if string's length greater than len
 */
+(NSString *)zeropadWithString:(NSString *)s length:(int)len;
/**
 * zeropads a long without throwing an ISOException (performs modulus operation)
 *
 * @param l the long
 * @param len the length
 * @return zeropadded value
 */
+(NSString *)zeropadWithLong:(long)l length:(int)len;
/**
 * pads to the right
 * @param s - original string
 * @param len - desired len
 * @return space padded string
 */
+(NSString *)strpadWithString:(NSString *)s lenth:(int)len;
+(NSString *)zeropadRightWithString:(NSString *)s lenth:(int)len;




////////////////////////////////////////////////////////////////////////
/**
 * converts a BCD representation of a number to a String
 * @param b - BCD representation
 * @param offset - starting offset
 * @param len - BCD field len
 * @param padLeft - was padLeft packed?
 * @return the String representation of the number
 */
+ (NSString*)bcd2str:(NSData*)b offset:(int)offset len:(int)len padLeft:(BOOL)padLeft;
+ (NSString*)hexStringWithData:(NSData*)data;
+ (NSString*)hexStringWithBytes:(Byte*)bytes length:(int)length;
+ (NSString*)hexStringWithBytes:(Byte *)bytes offset:(int)offset length:(int)length;

@end