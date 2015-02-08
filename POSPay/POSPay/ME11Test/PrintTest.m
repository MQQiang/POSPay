//
//  PrintTest.m
//  MTypeSDK
//
//  Created by su on 14/6/18.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import "PrintTest.h"

@implementation PrintTest

- (void)printImage
{
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (![app.device isAlive]) {
        [[[UIAlertView alloc] initWithTitle:@"提醒" message:@"设备未连接，请选择并连接！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        return ;
    }
    id<NLLCD> lcd = (id<NLLCD>)[app.device standardModuleWithModuleType:NLModuleTypeCommonLCD];
    id<NLPrinter> printer = (id<NLPrinter>)[app.device standardModuleWithModuleType:NLModuleTypeCommonPrinter];
    [printer initialize];
    if ([printer status] == NLPrinterStatusOutOfPaper) {
        [self showMsgOnMainThread:@"打印机缺纸"];
        [lcd clearScreen];
        [lcd drawWithWords:@"打印机缺纸"];
        return;
    }
    [lcd clearScreen];
    [lcd drawWithWords:@"正在打印"];
    //    [printer printWithBitmap:[UIImage imageNamed:@"qrcode.png"] timeout:SET_TIMEOUT];
    //    [printer printWithBitmap:[UIImage imageNamed:@"logo.png"] timeout:SET_TIMEOUT];
    NSDate *sdate = [NSDate date];
    [printer printWithBitmap:[UIImage imageNamed:@"test.jpg"] timeout:SET_TIMEOUT];
    NSDate *date = [NSDate date];
    NSLog(@"bitmap time : %f", [date timeIntervalSince1970] - [sdate timeIntervalSince1970]);
    sdate = [NSDate date];
    //[printer printWithString:@"\n测试打印。。。。\n测试打印。。。。\n测试打印。。。。\n测试打印。。。。\n\n\n\n" timeout:SET_TIMEOUT];
    //    for (NSString *str in arr) {
    //        [printer printWithString:str timeout:50];
    //    }
    [lcd clearScreen];
    [lcd drawWithWords:@"打印完成"];
}
- (void)printText
{
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (![app.device isAlive]) {
        [[[UIAlertView alloc] initWithTitle:@"提醒" message:@"设备未连接，请选择并连接！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        return ;
    }
    id<NLLCD> lcd = (id<NLLCD>)[app.device standardModuleWithModuleType:NLModuleTypeCommonLCD];
    id<NLPrinter> printer = (id<NLPrinter>)[app.device standardModuleWithModuleType:NLModuleTypeCommonPrinter];
    [printer initialize];
    /*!
     * 根据需要设置打印属性
     [printer setLineSpace:1]; // 设置行间距
     [printer setWordStockType:NLWordStockTypePix16]; // 设置字库
     [printer setDensity:3]; // 设置浓度
     [printer setFontType:NLFontTypeNormal literalType:NLLiteralTypeChinese settingScope:NLFontSettingScopeWidth]; // 设置字体
     */
    if ([printer status] == NLPrinterStatusOutOfPaper) {
        [self showMsgOnMainThread:@"打印机缺纸"];
        [lcd clearScreen];
        [lcd drawWithWords:@"打印机缺纸"];
        return;
    }
    
    [lcd clearScreen];
    [lcd drawWithWords:@"正在打印"];
    
    NSArray *arr = @[@"快钱支付清算信息有限公司",
                     @"商户名称：快钱快刷测试",
                     @"商户号：999923124421312",
                     @"终端号：60001159",
                     @"卡别：招商银商",
                     @"卡号：6225-88xx-xxxx-2997",
                     @"交易类型：刷卡消费",
                     @"日期时间：2014/04/24 17:51:08",
                     @"批次号：000000",
                     @"凭证号：000002",
                     @"授权号：068360",
                     @"参考号：000012245691",
                     @"总金额：RMB 5.10",
                     @"订单号：equippeduuuuiiiii",
                     @"商品信息：ghkllk",
                     @"手机号码：1131***7330",
                     @"邮箱地址：l***5@qq.com",
                     @"操作员号：001",
                     @"软件版本：快刷iOS V4.0",
                     @"持卡人签名（CARD HOLD SIGNATURE）",
                     @"xxxxxxxxx",
                     @"嘻嘻嘻嘻",
                     @"嘻嘻嘻嘻",
                     @"嘻嘻嘻嘻",
                     @"同意支付上述款项",
                     @"I ACKNOWLEDGE SATISFACTORY RECEIPT",
                     @"OF RELATIVE GOODS/SERVICES"];
    
    NSMutableString *buff = [NSMutableString string];
    for (NSString *str in arr) {
        [buff appendString:str];
        [buff appendFormat:@"\n"];
    }
    
    
    //    [printer printWithBitmap:[UIImage imageNamed:@"qrcode.png"] timeout:SET_TIMEOUT];
    //    [printer printWithBitmap:[UIImage imageNamed:@"logo.png"] timeout:SET_TIMEOUT];
    NSDate *sdate = [NSDate date];
    sdate = [NSDate date];
    //[printer printWithString:@"\n测试打印。。。。\n测试打印。。。。\n测试打印。。。。\n测试打印。。。。\n\n\n\n" timeout:SET_TIMEOUT];
    //    for (NSString *str in arr) {
    //        [printer printWithString:str timeout:50];
    //    }
    [printer printWithString:buff timeout:1000];
    [printer printWithBitmap:[UIImage imageNamed:@"test-sign.jpg"] timeout:SET_TIMEOUT];
    NSDate *date = [NSDate date];
    NSLog(@"string time : %f", [date timeIntervalSince1970] - [sdate timeIntervalSince1970]);
    
    [lcd clearScreen];
    [lcd drawWithWords:@"打印完成"];
}
@end
