//
//  ConsumeTest.m
//  MTypeSDK
//
//  Created by su on 14/6/18.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import "ConsumeTest.h"
#import <MESDK/MTypeExCode.h>

@implementation ConsumeTest
-(void)consume{
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
    [reader openCardReaderWithCardReaderModuleTypes:@[@(NLModuleTypeCommonSwiper)] screenShow:CString(@"输入金额为:%@\n请刷卡",cash) timeout:200 listener:listener];
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
        case NLModuleTypeCommonSwiper:
        {
            /*NLWorkingKey *wk = [[NLWorkingKey alloc] initWithIndex:1 wk:[NLISOUtils hexStr2Data:@"00000000000000000000000000000000"]];
             rslt = [swiper readSimposResultWithReadModel:@[@(2), @(4)] wk:wk seed:[NLISOUtils hexStr2Data:@"118BAE25C393C410"] flowId:@"111111111111111111111111" encryptAlgorithm:];*/
            NLWorkingKey *wk = [[NLWorkingKey alloc] initWithIndex:1];
            //            rslt = [swiper readSimposResultWithReadModel:@[@(NLSwiperReadModelReadSecondTrack), @(NLSwiperReadModelReadThirdTrack)] trackSecurityPaddingType:NLTrackSecurityPaddingTypeNone wk:wk seed:nil flowId:nil encryptAlgorithm:[NLTrackEncryptAlgorithm BY_DUKPT_MODEL]];
            // 读取磁道密文
//            rslt = [swiper readEncryptResultWithReadModel:@[@(NLSwiperReadModelReadSecondTrack), @(NLSwiperReadModelReadThirdTrack)] wk:wk encryptAlgorithm:[NLTrackEncryptAlgorithm BY_99BILL_MODEL]];
//            if (rslt.rsltType != NLSwipeResultTypeSuccess) {
//                rslt=nil;
//            }
            
            // 读取卡号明文
            rslt = [swiper readPlainResultWithReadModel:NLSwiperReadModelReadSecondTrack];
            if(rslt == nil || [[rslt account].acctId length] == 0){
                rslt = nil;
            }
            
            break;
        }
            
        default:
            break;
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
    [self pinInputWithAmt:cash swipeResult:rslt];
}
- (void)pinInputWithAmt:(NSDecimalNumber *)amt swipeResult:(NLSwipeResult *)rslt
{
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (![app.device isAlive]) {
        [[[UIAlertView alloc] initWithTitle:@"提醒" message:@"设备未连接，请选择并连接！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        return ;
    }
    
    id<NLLCD> lcd = (id<NLLCD>)[app.device standardModuleWithModuleType:NLModuleTypeCommonLCD];
    id<NLPinInput> pin = (id<NLPinInput>)[app.device standardModuleWithModuleType:NLModuleTypeCommonPinInput];
    [self showMsgOnMainThread:@"请输入密码"];
    NSError *err;
    NLEventHolder *listener = [NLEventHolder new];
    NLWorkingKey *wk = [[NLWorkingKey alloc] initWithIndex:1];
    [pin startPinInputWithWorkingKey:wk
                       pinManageType:NLPinManageTypeDUKPT
                       acctInputType:NLAccountInputTypeUserAcctHash
                          acctSymbol:rslt.account.identityHash
                         inputMaxLen:6
                          pinPadding:[NSData fillWithByte:'F' len:10]
                      isEnterEnabled:YES
                      displayContent:CString(@"消费金额为:%@\n 请输入交易密码:",amt)
                             timeout:SET_TIMEOUT
                       inputListener:listener];
    [listener startWait:&err];
    if (err) {
        [pin cancelPinInput];
        [lcd clearScreen];
        [self showMsgOnMainThread:CString(@"密码输入撤销:%@",err)];
        return;
    }
    
    NLPinInputFinishedEvent *event = [self eventFilter:listener.event exCode:ExCode_GET_PININPUT_FAILED];
    if (!event) {
        [lcd clearScreen];
        [self showMsgOnMainThread:@"密码输入失败"];
        return;
    }
    if ([event isUserCanceled]) {
        [self showMsgOnMainThread:@"密码输入撤销"];
        return;
    }
    [lcd clearScreen];
    NSData *data = [event encrypPin];
    NSData *kns = [event ksn];
    [self showMsgOnMainThread:CString(@"密码:%@消费完成", [NLDump hexDumpWithData:kns])];
}
@end
