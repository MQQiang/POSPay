//
//  ME11Test.m
//  MTypeSDK
//
//  Created by su on 14/10/29.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import "ME11Test.h"
static NSArray *L_55TAGS = nil;

@interface ME11Test ()<NLEmvControllerListener>

@end

@implementation ME11Test
- (void)loadTest
{
    [super loadTest];
    L_55TAGS = @[@0x9F26, @0x9F27, @0x9F10, @0x9F37, @0x9F36,
                 @0x95, @0x9A, @0x9C, @0x9F02, @0x5F2a, @0x82,
                 @0x9F1A, @0x9F03, @0x9F33, @0x9F34, @0x9F35,
                 @0x9F1E, @0x84, @0x9F09, @0x9F41, @0x9F63];
}
- (void)deviceInfo
{
    id<NLDeviceInfo> me11Info = [self.device me11DeviceInfo];
    [self showMsgOnMainThread:CString(@"ME11 KSN : %@", [me11Info KSN])];
}
- (void)startReadCard
{
    [self showMsgOnMainThread:@"正在等待刷卡/插卡......"];
    id<NLCardReader> cardReader = (id<NLCardReader>)[self.device standardModuleWithModuleType:NLModuleTypeCommonCardReader];
    // TODO
    int timeout = 60;
    
    NSDateFormatter *ft = [[NSDateFormatter alloc] init];
    [ft setDateFormat:@"yyMMddHHmmss"];
    NSData* time = [NLISOUtils hexStr2Data:[ft stringFromDate:[NSDate date]]]; //
    //            NSData* random = [NLISOUtils hexStr2Data:@""]; // 流水号
    //            NSData* appendData = [NLISOUtils hexStr2Data:@""]; // 订单号
    NLME11SwipeResult *rslt = [cardReader openCardReader:@[@(NLModuleTypeCommonSwiper), @(NLModuleTypeCommonICCard)] readModel:@[@(NLSwiperReadModelReadSecondTrack), @(NLSwiperReadModelReadThirdTrack)] panType:0x64 encryptAlgorithm:[NLTrackEncryptAlgorithm BY_M10_MODEL] wk:[[NLWorkingKey alloc] initWithIndex:0x04] time:time random:nil appendData:nil timeout:timeout];
    if (!rslt) {
        [self showMsgOnMainThread:CString(@"读卡POS响应失败")];
        return ;
    }
    if (rslt.rsltType != NLSwipeResultTypeSuccess || rslt.moduleTypes <= 0) {
        [self showMsgOnMainThread:CString(@"刷卡或插卡失败")];
        return ;
    }
    
    NLModuleType moduleType = [rslt.moduleTypes[0] intValue];
    if (NLModuleTypeCommonICCard == moduleType) {
        // ME11 pboc
        [self showMsgOnMainThread:@"正在读取IC卡......"];
        id<NLEmvModule> emvModule = (id<NLEmvModule>)[self.device standardModuleWithModuleType:NLModuleTypeCommonEMV];
        id<NLEmvTransController> emvController = [emvModule emvTransControllerWithListener:self];
        [emvController startEmvWithAmount: [NSDecimalNumber decimalNumberWithString:@"10.00"] cashback:[NSDecimalNumber zero] forceOnline:YES];
    } else if (NLModuleTypeCommonSwiper == moduleType) {
#warning 刷卡信息
        [self showMsgOnMainThread:CString(@"卡号：%@\nsecondTrackData:%@\nthirdTrackData:%@\ntrackDatas:%@\nvalidDate:%@\nserviceCode:%@\nksn:%@\nextInfo:%@\n",
                                          rslt.acctId,
                                          rslt.secondTrackData,
                                          rslt.thirdTrackData,
                                          rslt.trackDatas,
                                          rslt.validDate,
                                          rslt.serviceCode,
                                          rslt.ksn,
                                          rslt.extInfo)];
    } else {
        [self showMsgOnMainThread:@"该读卡模式不支持"];
    }
}
#pragma mark - NLEmvControllerListener implement
- (void)onRequestSelectApplication:(id<NLEmvTransController>)controller context:(NLEmvTransInfo*)context error:(NSError*)err
{
    
    //    [self showMsgOnMainThread:@"错误的事件返回，不可能要求应用选择！"];
    //    [controller cancelEmv];
}
- (void)onRequestTransferConfirm:(id<NLEmvTransController>)controller context:(NLEmvTransInfo*)context error:(NSError*)err
{
    
    //    [self showMsgOnMainThread:@"错误的事件返回，不可能要求交易确认！"];
    //    [controller cancelEmv];
}
- (void)onRequestPinEntry:(id<NLEmvTransController>)controller context:(NLEmvTransInfo*)context error:(NSError*)err
{
    
    //    [self showMsgOnMainThread:@"错误的事件返回，不可能要求密码输入！"];
    //    [controller cancelEmv];
}
- (void)onRequestOnline:(id<NLEmvTransController>)controller context:(NLEmvTransInfo*)context error:(NSError*)err
{
    NSLog(@"%@:%@", context, err);
    NSMutableString * show = [NSMutableString string];
    [show appendString:[NSString stringWithFormat:@"pboc读卡%@", err == nil ? @"成功!" : @"失败！"]];
    //    Byte *terminalVerificationResults = (Byte*)[[context terminalVerificationResults] bytes];
    //    int bit4 = terminalVerificationResults[2]>>3&0x01;
    //    if (bit4 == 1) { // 取消
    //        // TODO
    //        return ;
    //    }
    
    //    NSLog(@"%@", [NSString stringWithFormat:@"cardNo:%@\ncardExpirationDate:%@\ntransactionDate:%@\n",
    //                  [context cardNo],
    //                  [context cardExpirationDate],
    //                  [context transactionDate]]);
    [show appendString:CString(@"\n开启联机交易：%@", context)];
    [show appendString:CString(@"\n>>>>请求在线交易处理")];
    [show appendString:CString(@"\n		95：%@", [context terminalVerificationResults])];
    [show appendString:CString(@"\n		9f26：%@", [context appCryptogram])];
    [show appendString:CString(@"\n		9f34：%@", [context cvmRslt])];
    [show appendString:CString(@"\n>>>>卡号:%@,卡序列号:%@", [context cardNo], [context cardSequenceNumber])];
    [show appendString:CString(@"\n>>>>密码:%@", [context onLinePin])];
    [show appendString:CString(@"\n>>>>加密数据:%@", [context encrypt_data])];
    NLSecondIssuanceRequest *request = [NLSecondIssuanceRequest new];
    request.authorisationResponseCode = @"00";
    [controller secondIssuance:request];
    [self showMsgOnMainThread:show];
    //    //    NSArray *xArr = @[];
    //    NSArray *fields = [NSMutableArray arrayWithArray:[[NLEmvTransInfo emvTagDefineds] allKeys]];
    //    //    [fields removeObjectsInArray:xArr];
    //    NSData *pack8583Data = [[NLSimpleEmvPackager sharedPackager] pack:context fields:fields];
    //    NSLog(@"%@", pack8583Data);
    //
    //    NSMutableData *tc55Data = [NSMutableData dataWithData:pack8583Data];
    //    id<TLVPackage> tlvPackage = [NLTLVPackageUtils tlvPackage];
    //    // 多个tag...依次append(金额等)
    //    [tlvPackage appendWithTag:0x00 value:[NLISOUtils str2bcd:[NSString stringWithFormat:@"%@", context.amountAuthorisedNumeric] padLeft:NO]];
    //    // pack
    //    [tc55Data appendData:[tlvPackage pack]];
    
    
    
    //    if (err) {
    //        return ;
    //    }
    //
    //    if (![context isNeedOnLinePin]) {
    //        // 交易然后才二次授权
    //        [self performSelector:@selector(secondIssuance) withObject:nil afterDelay:0.3];
    //    } else {
    //        [self startPin:nil];
    //        self.isPBOC = YES;
    //    }
}
- (void)onEmvFinished:(BOOL)isSuccess context:(NLEmvTransInfo*)context error:(NSError*)err
{
    NSMutableString * show = [NSMutableString string];
    [show appendString:CString(@"pboc指令结束!%@", isSuccess ? @"成功" : @"失败")];
    if (isSuccess) {
        [show appendString:CString(@"\nemv交易结束:%@", context)];
        [show appendString:CString(@"\n>>>>交易完成，卡号:%@,卡序列号:%@", [context cardNo], [context cardSequenceNumber]/*, [context ksn]*/)];
        [show appendString:CString(@"\n>>>>交易完成，密码:%@", [context onLinePin])];
        id<TLVPackage> tlvPackage = [context setExternalInfoPackageWithTags:L_55TAGS];
        [show appendString:CString(@"\n>>>>55域打包集合:\n%@", [NLISOUtils hexStringWithData:[tlvPackage pack]])];
    }
    [self showMsgOnMainThread:show];
    //    self.title = [NSString stringWithFormat:@"pboc指令结束!%@", isSuccess ? @"成功" : @"失败"];
    //    cardDataLb.text = [NSString stringWithFormat:@"appCryptogram:%@\ntransactionDate:%@", [context appCryptogram], [context transactionDate]];
    //    NSLog(@"%@:%@", context, err);
    //    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    //    id<NLCardReader> reader = (id<NLCardReader>)[app.device standardModuleWithModuleType:NLModuleTypeCommonCardReader];
    //    [reader closeCardReader];
    
    //    [self emvPinInputWithAmt:[NSDecimalNumber decimalNumberWithString:@"100.00"] cardNo:context.cardNo];
}
/*!
 appendInteractiveInfoAndShow("emv交易结束:" + context.externalToString());
 appendInteractiveInfoAndShow("emv交易状态:" + arg0);
 appendInteractiveInfoAndShow(">>>>交易完成，卡号:" + context.getCardNo() + ",卡序列号:" + context.getCardSequenceNumber());
 appendInteractiveInfoAndShow(">>>>交易完成，密码:" + context.getOnLinePin());
 appendInteractiveInfoAndShow(">>>>交易完成，KSN:" + context.getKsn());
 
 appendInteractiveInfoAndShow("----8583 IC卡55域数据---表16　基本信息子域列表----");
 appendInteractiveInfoAndShow(">>>>应用密文(9f26):" + context.getAppCryptogram());
 appendInteractiveInfoAndShow(">>>>密文信息数据(9F27):" + context.getCryptogramInformationData());
 appendInteractiveInfoAndShow(">>>>发卡行应用数据(9F10):" + context.getIssuerApplicationData());
 appendInteractiveInfoAndShow(">>>>不可预知数(9F37):" + context.getUnpredictableNumber());
 appendInteractiveInfoAndShow(">>>>应用交易计数器(9F36):" + context.getAppTransactionCounter());
 appendInteractiveInfoAndShow(">>>>终端验证结果(95):" + context.getTerminalVerificationResults());
 appendInteractiveInfoAndShow(">>>>交易日期(9A):" + context.getTransactionDate());
 appendInteractiveInfoAndShow(">>>>交易类型(9C):" + context.getTransactionType());
 appendInteractiveInfoAndShow(">>>>授权金额(9F02):" + context.getAmountAuthorisedNumeric());
 appendInteractiveInfoAndShow(">>>>交易货币代码(5F2A):" + context.getTransactionCurrencyCode());
 appendInteractiveInfoAndShow(">>>>应用交互特征(82):" + context.getApplicationInterchangeProfile());
 appendInteractiveInfoAndShow(">>>>终端国家代码(9F1A):" + context.getTerminalCountryCode());
 appendInteractiveInfoAndShow(">>>>其它金额(9F03):" + context.getAmountOtherNumeric());
 appendInteractiveInfoAndShow(">>>>终端性能(9F33):" + context.getTerminal_capabilities());
 appendInteractiveInfoAndShow(">>>>电子现金发卡行授权码(9F74):" + context.getEcIssuerAuthorizationCode());
 appendInteractiveInfoAndShow("----8583 IC卡55域数据---可选信息子域列表----");
 appendInteractiveInfoAndShow(">>>>持卡人验证方法结果(9F34):" + context.getCvmRslt());
 appendInteractiveInfoAndShow(">>>>终端类型(9F35):" + context.getTerminalType());
 appendInteractiveInfoAndShow(">>>>接口设备序列号(9F1E):" + context.getInterface_device_serial_number());
 appendInteractiveInfoAndShow(">>>>专用文件名称(84):" + context.getDedicatedFileName());
 appendInteractiveInfoAndShow(">>>>软件版本号(9F09):" + context.getAppVersionNumberTerminal());
 appendInteractiveInfoAndShow(">>>>交易序列计数器(9F41):" + context.getTransactionSequenceCounter());
 appendInteractiveInfoAndShow(">>>>发卡行认证数据(91):" + context.getIssuerAuthenticationData());
 appendInteractiveInfoAndShow(">>>>发卡行脚本1(71):" + context.getIssuerScriptTemplate1());
 appendInteractiveInfoAndShow(">>>>发卡行脚本2(72):" + context.getIssuerScriptTemplate2());
 appendInteractiveInfoAndShow(">>>>发卡方脚本结果(DF31):" + context.getScriptExecuteRslt());
 appendInteractiveInfoAndShow(">>>>卡产品标识信息(9F63):" + context.getCardProductIdatification());
 TLVPackage tlvPackage=context.setExternalInfoPackage(L_55TAGS);
 appendInteractiveInfoAndShow(">>>>55域打包集合:" + ISOUtils.hexString(tlvPackage.pack()));
 
 */
- (void)onFallback:(NLEmvTransInfo*)context error:(NSError*)err
{
    [self showMsgOnMainThread:@"交易降级"];
}
- (void)onError:(id<NLEmvTransController>)controller error:(NSError*)err
{
    [self showMsgOnMainThread:@"emv交易失败"];
    if ([err isKindOfClass:NSClassFromString(@"NLProcessTimeoutError")]) { // 超时
        // TODO
        return ;
    } else if ([err isKindOfClass:NSClassFromString(@"NLDeviceInvokeCanceledError")]) { // 取消
        // TODO
    }
}
@end
