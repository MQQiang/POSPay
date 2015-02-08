//
//  PBOCTest.m
//  MTypeSDK
//
//  Created by su on 14/6/18.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import "PBOCTest.h"
#import <MESDK/NLSimpleEmvPackager.h>
#import <MESDK/MTypeExCode.h>
#import "ConsumeTest.h"

@interface PBOCTest ()<NLEmvControllerListener>
@property (nonatomic) BOOL isICcardTrade;
@property (nonatomic) BOOL processing;

@property (nonatomic, strong) NLTerminalConfig *trmnlConfig;
@property (nonatomic, strong) NLAIDConfig *aidConfig;
@property (nonatomic, strong) NLCAPublicKey *caKey;
@property (nonatomic, strong) NSData *aid;
@property (nonatomic, strong) NSData *rid;
@end

@implementation PBOCTest
static NSArray *L_55TAGS = nil;
- (void)loadTest
{
    [super loadTest];
    L_55TAGS = @[@0x9F26, @0x9F27, @0x9F10, @0x9F37, @0x9F36,
                 @0x95, @0x9A, @0x9C, @0x9F02, @0x5F2a, @0x82,
                 @0x9F1A, @0x9F03, @0x9F33, @0x9F34, @0x9F35,
                 @0x9F1E, @0x84, @0x9F09, @0x9F41, @0x9F63];
    
    self.rid = [NLISOUtils hexStr2Data:@"A000000003"];
    self.aid = [NLISOUtils hexStr2Data:@"A0000000031010"];
    [self initAidConfig];
    [self initCAPublicKey];
    [self initTrmnlConfig];
}
#pragma mark - test case
- (void)testEmv:(NSString*)rowTitle
{
    if ([rowTitle isEqual:@"设置终端属性"]) {
        [self showMsgOnMainThread:@"设置终端属性..."];
        [self.emvModule setTrmnlParams:self.trmnlConfig];
    } else if ([rowTitle isEqual:@"增加应用标识"]) {
        [self showMsgOnMainThread:@"增加应用标识..."];
        [self.emvModule addAID:self.aidConfig];
    } else if ([rowTitle isEqual:@"删除应用标识"]) {
        [self showMsgOnMainThread:@"删除应用标识..."];
        [self.emvModule deleteAID:self.aid];
    } else if ([rowTitle isEqual:@"增加公钥"]) {
        [self showMsgOnMainThread:@"增加公钥..."];
        [self.emvModule addCAPublicKey:self.caKey rid:self.rid];
    } else if ([rowTitle isEqual:@"删除公钥"]) {
        [self showMsgOnMainThread:@"删除公钥..."];
        [self.emvModule deleteCAPublicKey:self.rid index:KeyIndex];
    }
}
#pragma mark - pboc module
- (id<NLEmvModule>)emvModule
{
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    return (id<NLEmvModule>)[app.device standardModuleWithModuleType:NLModuleTypeCommonEMV];
}
-(void)startTransfer
{
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (![app.device isAlive]) {
        [[[UIAlertView alloc] initWithTitle:@"提醒" message:@"设备未连接，请选择并连接！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        return ;
    }
    id<NLLCD> lcd = (id<NLLCD>)[app.device standardModuleWithModuleType:NLModuleTypeCommonLCD];
    id<NLSwiper> swiper = (id<NLSwiper>)[app.device standardModuleWithModuleType:NLModuleTypeCommonSwiper];
    id<NLCardReader> reader = (id<NLCardReader>)[app.device standardModuleWithModuleType:NLModuleTypeCommonCardReader];
    NSError *err;
    //输入金额
    NSDecimalNumber *cash = @(100);
    [self showMsgOnMainThread:CString(@"输入金额为:%@,请刷卡",cash)];
    // 清屏
    //    [lcd clearScreen];
    //    [lcd drawWithWords:CString(@"输入金额为:%@\n请刷卡",cash)];
    //打开刷卡器
    NLEventHolder *listener = [NLEventHolder new];
    [reader openCardReaderWithCardReaderModuleTypes:@[@(NLModuleTypeCommonSwiper), @( NLModuleTypeCommonICCard), @(NLModuleTypeCommonNCCard)] screenShow:CString(@"输入金额为:%@\n请刷卡或者插入IC卡",cash) timeout:200 listener:listener];
    [listener startWait:&err];
    if (err) {
        [reader cancelCardRead];
        [lcd clearScreen];
        [self showMsgOnMainThread:CString(@"刷卡失败:%@",err)];
        return;
    }
    NLOpenCardReaderEvent *event = [self eventFilter:listener.event exCode:ExCode_GET_TRACKTEXT_FAILED];
    //读取刷卡数据
    if (!event)
    {
        [lcd clearScreen];
        [self showMsgOnMainThread:@"刷卡失败"];
        return;
    }
    if ([event isUserCanceled])
    {
        [self showMsgOnMainThread:@"刷卡已取消"];
        return;
    }
    NSArray *openedModuleTypes = [event openedCardReaders];
    if (openedModuleTypes.count <= 0) {
        [self showMsgOnMainThread:@"刷卡失败"];
        [lcd clearScreen];
        return;
    }
    if (openedModuleTypes.count > 1) {
        NSString * errMsg = [NSString stringWithFormat:@"%dshould return only one type of cardread action!but is :%d",
                             ExCode_GET_TRACKTEXT_FAILED, openedModuleTypes.count];
        [self showMsgOnMainThread:errMsg];
        [lcd clearScreen];
        return;
    }
    
    NLModuleType openType = [[openedModuleTypes objectAtIndex:0] integerValue];
    NLSwipeResult *rslt;
    switch (openType) {
        case NLModuleTypeCommonSwiper: // 参考磁条卡部分
        {
            /*NLWorkingKey *wk = [[NLWorkingKey alloc] initWithIndex:1 wk:[NLISOUtils hexStr2Data:@"00000000000000000000000000000000"]];
             rslt = [swiper readSimposResultWithReadModel:@[@(2), @(4)] wk:wk seed:[NLISOUtils hexStr2Data:@"118BAE25C393C410"] flowId:@"111111111111111111111111" encryptAlgorithm:];*/
            NLWorkingKey *wk = [[NLWorkingKey alloc] initWithIndex:1];
            //            rslt = [swiper readSimposResultWithReadModel:@[@(NLSwiperReadModelReadSecondTrack), @(NLSwiperReadModelReadThirdTrack)] trackSecurityPaddingType:NLTrackSecurityPaddingTypeNone wk:wk seed:nil flowId:nil encryptAlgorithm:[NLTrackEncryptAlgorithm BY_DUKPT_MODEL]];
            rslt = [swiper readEncryptResultWithReadModel:@[@(NLSwiperReadModelReadSecondTrack), @(NLSwiperReadModelReadThirdTrack)] wk:wk encryptAlgorithm:[NLTrackEncryptAlgorithm BY_99BILL_MODEL]];
            if (rslt.rsltType != NLSwipeResultTypeSuccess) {
                rslt=nil;
            }
            
            //关闭刷卡器
            [reader closeCardReader];
            if (rslt) {
                [self showMsgOnMainThread:CString(@"卡号：%@ KSN：%@",[rslt account].acctId, [rslt ksn])];
            }
            else{
                [self showMsgOnMainThread:@"刷卡失败"];
                return;
            }
            
            //输入密码
            [[ConsumeTest new] pinInputWithAmt:cash swipeResult:rslt];
            
            break;
        }
            
        case NLModuleTypeCommonICCard:
        {
            self.isICcardTrade = YES;
            NLOnlinePinConfig *config = [NLOnlinePinConfig new];
            config.workingKey = [[NLWorkingKey alloc] initWithIndex:NLKeyIndexConst_KSN_INITKEY_INDEX];
            config.pinManageType = NLPinManageTypeDUKPT;
            config.pinPadding = [NSData fillWithByte:'F' len:10];
            config.displayContent = @"请输入密码:";
            config.timeout = 30;
            config.inputMaxLen = 6;
            config.isEnterEnabled = YES;
            [self.emvModule setOnlinePinConfig:config];
            
            id<NLEmvTransController> emvController = [self.emvModule emvTransControllerWithListener:self];
            [emvController startEmvWithAmount:[NSDecimalNumber decimalNumberWithString:@"30.00"] cashback:[NSDecimalNumber zero] forceOnline:NO];
            break;
        }
            
        default:
            break;
    }
}
- (void)processingFinished
{
    self.processing = NO;
}
- (void)initTrmnlConfig
{
    self.trmnlConfig = [NLTerminalConfig new];
    self.trmnlConfig.trmnlICSConfig = [NLISOUtils hexStr2Data:@"F4F0F0FAAFFEA0"];
    self.trmnlConfig.terminalType = 0x22;
    self.trmnlConfig.terminalCapabilities = [NLISOUtils hexStr2Data:@"E0F8C8"];
    self.trmnlConfig.additionalTerminalCapabilities = [NLISOUtils hexStr2Data:@"FF80F0B001"];
    self.trmnlConfig.pointOfServiceEntryMode = 0x05;
    self.trmnlConfig.transactionCurrencyCode = @"156";
    self.trmnlConfig.transactionCurrencyExp = @"1";
    self.trmnlConfig.terminalCountryCode = [NLISOUtils hexStr2Data:@"0840"];
    self.trmnlConfig.interfaceDeviceSerialNumber = @"11111111";
    self.trmnlConfig.aidPartlyMatchSupported = 0x01;
}
- (void)initAidConfig
{
    self.aidConfig = [NLAIDConfig new];
    [self.aidConfig setAid:self.aid];
    [self.aidConfig setAppSelectIndicator:1];
    [self.aidConfig setAppVersionNumberTerminal:[NLISOUtils hexStr2Data:@"008C"]];
    [self.aidConfig setTacDefault:[NLISOUtils hexStr2Data:@"0000000000"]];
    [self.aidConfig setTacOnLine:[NLISOUtils hexStr2Data:@"0000000000"]];
    [self.aidConfig setTacDenial:[NLISOUtils hexStr2Data:@"0000000000"]];
    // IC交易限额
    [self.aidConfig setTerminalFloorLimit:[NLISOUtils hexStr2Data:@"00001000"]];
    [self.aidConfig setThresholdValueForBiasedRandomSelection:[NLISOUtils hexStr2Data:@"00001388"]];
    [self.aidConfig setMaxTargetPercentageForBiasedRandomSelection:0];
    [self.aidConfig setTargetPercentageForRandomSelection:0];
    [self.aidConfig setDefaultDDOL:[NLISOUtils hexStr2Data:@"9F37049F47018F019F3201"]]; // 1024暂时修改为11
    [self.aidConfig setOnLinePinCapability:1];
    [self.aidConfig setEcTransLimit:[NLISOUtils hexStr2Data:@"000000010000"]];
    [self.aidConfig setNciccOffLineFloorLimit:[NLISOUtils hexStr2Data:@"000000000001"]];
    [self.aidConfig setNciccTransLimit:[NLISOUtils hexStr2Data:@"000060000000"]];
    [self.aidConfig setNciccCVMLimit:[NLISOUtils hexStr2Data:@"000000008000"]];
    [self.aidConfig setEcCapability:1];
    [self.aidConfig setCoreConfigType:1];
}
- (void)initCAPublicKey
{
    Byte modulusBytes[] = { (Byte) 0x94, 0x2B,
        0x7F, 0x2B, (Byte) 0xA5,
        (Byte) 0xEA, 0x30, 0x73, 0x12,
        (Byte) 0xB6, 0x3D, (Byte) 0xF7,
        0x7C, 0x52, 0x43, 0x61,
        (Byte) 0x8A, (Byte) 0xCC, 0x20,
        0x02, (Byte) 0xBD, 0x7E,
        (Byte) 0xCB, 0x74, (Byte) 0xD8,
        0x21, (Byte) 0xFE, 0x7B,
        (Byte) 0xDC, 0x78, (Byte) 0xBF,
        0x28, (Byte) 0xF4, (Byte) 0x9F,
        0x74, 0x19, 0x0A, (Byte) 0xD9,
        (Byte) 0xB2, 0x3B, (Byte) 0x97,
        0x13, (Byte) 0xB1, 0x40,
        (Byte) 0xFF, (Byte) 0xEC, 0x1F,
        (Byte) 0xB4, 0x29, (Byte) 0xD9,
        0x3F, 0x56, (Byte) 0xBD,
        (Byte) 0xC7, (Byte) 0xAD,
        (Byte) 0xE4, (Byte) 0xAC, 0x07,
        0x5D, 0x75, 0x53, 0x2C, 0x1E,
        0x59, 0x0B, 0x21, (Byte) 0x87,
        0x4C, 0x79, 0x52, (Byte) 0xF2,
        (Byte) 0x9B, (Byte) 0x8C, 0x0F,
        0x0C, 0x1C, (Byte) 0xE3,
        (Byte) 0xAE, (Byte) 0xED,
        (Byte) 0xC8, (Byte) 0xDA, 0x25,
        0x34, 0x31, 0x23, (Byte) 0xE7,
        0x1D, (Byte) 0xCF, (Byte) 0x86,
        (Byte) 0xC6, (Byte) 0x99,
        (Byte) 0x8E, 0x15, (Byte) 0xF7,
        0x56, (Byte) 0xE3 };
    Byte shaBytes[] = { 0x25, 0x1A, 0x5F, 0x5D,
        (Byte) 0xE6, 0x1C, (Byte) 0xF2,
        (Byte) 0x8B, 0x5C, 0x6E, 0x2B,
        0x58, 0x07, (Byte) 0xC0, 0x64,
        0x4A, 0x01, (Byte) 0xD4, 0x6F,
        (Byte) 0xF5 };
    NSData *modulus = [[NSData alloc] initWithBytes:modulusBytes length:sizeof(modulusBytes)];
    NSData *sha = [[NSData alloc] initWithBytes:shaBytes length:sizeof(shaBytes)];
    self.caKey = [[NLCAPublicKey alloc] initWithIndex:KeyIndex hashAlgorithmIndicator:1 publicKeyAlgorithmIndicator:1 modulus:modulus exponent:[NLISOUtils hexStr2Data:@"010001"] sha1CheckSum:sha expirationDateString:@"20991231"];
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
    Byte *terminalVerificationResults = (Byte*)[[context terminalVerificationResults] bytes];
    int bit4 = terminalVerificationResults[2]>>3&0x01;
    if (bit4 == 1) { // 取消
        // TODO
        return ;
    }
    
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
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    id<NLCardReader> reader = (id<NLCardReader>)[app.device standardModuleWithModuleType:NLModuleTypeCommonCardReader];
    [reader closeCardReader];
    
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
    //    [self startSwipeTransfer];
    //    [self processingFinished];
    //    self.title = [NSString stringWithFormat:@"IC卡读卡失败，请刷磁条卡!"];
    //    CSwiperParameter *param = [CSwiperParameter magneticCardParameterWitContent:@"收款"];
    //    [self.reader setStartParameter:param type:CSwiperParameterTypeSerial];
    //    [self.reader startCSwiperWithAmount:@"2.00"];
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
    
    [self processingFinished];
}

// no use
//- (void)emvPinInputWithAmt:(NSDecimalNumber *)amt cardNo:(NSString *)cardNo
//{
//    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    if (![app.device isAlive]) {
//        [[[UIAlertView alloc] initWithTitle:@"提醒" message:@"设备未连接，请选择并连接！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
//        return ;
//    }
//    
//    id<NLLCD> lcd = (id<NLLCD>)[app.device standardModuleWithModuleType:NLModuleTypeCommonLCD];
//    id<NLPinInput> pin = (id<NLPinInput>)[app.device standardModuleWithModuleType:NLModuleTypeCommonPinInput];
//    [self showMsgOnMainThread:@"请输入密码"];
//    NSError *err;
//    NLEventHolder *listener = [NLEventHolder new];
//    NLWorkingKey *wk = [[NLWorkingKey alloc] initWithIndex:1];
//    [pin startPinInputWithWorkingKey:wk
//                       pinManageType:NLPinManageTypeDUKPT
//                       acctInputType:NLAccountInputTypeUserAccount
//                          acctSymbol:cardNo
//                         inputMaxLen:6
//                          pinPadding:[NSData fillWithByte:'F' len:10]
//                      isEnterEnabled:YES
//                      displayContent:CString(@"消费金额为:%@\n 请输入交易密码:",amt)
//                             timeout:SET_TIMEOUT
//                       inputListener:listener];
//    [listener startWait:&err];
//    if (err) {
//        [pin cancelPinInput];
//        [lcd clearScreen];
//        [self showMsgOnMainThread:CString(@"密码输入撤销:%@",err)];
//        return;
//    }
//    
//    NLPinInputFinishedEvent *event = [self eventFilter:listener.event exCode:ExCode_GET_PININPUT_FAILED];
//    if (!event) {
//        [lcd clearScreen];
//        [self showMsgOnMainThread:@"密码输入失败"];
//        return;
//    }
//    if ([event isUserCanceled]) {
//        [self showMsgOnMainThread:@"密码输入撤销"];
//        return;
//    }
//    [lcd clearScreen];
//    NSData *data = [event encrypPin];
//    NSData *kns = [event ksn];
//    [self showMsgOnMainThread:CString(@"密码:%@消费完成", [NLDump hexDumpWithData:kns])];
//}
@end
