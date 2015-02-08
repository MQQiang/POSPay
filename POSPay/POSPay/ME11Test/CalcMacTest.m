//
//  CalcMacTest.m
//  MTypeSDK
//
//  Created by su on 14/6/19.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import "CalcMacTest.h"
@implementation CalcMacTest
- (void)calcMac4Common
{
    id<NLPinInput> pin = (id<NLPinInput>)[self.app.device standardModuleWithModuleType:NLModuleTypeCommonPinInput];
    // 计算mac
    NLWorkingKey *wk = [[NLWorkingKey alloc] initWithIndex:0x03 wk:[NLISOUtils hexStr2Data:@"0000"]/*nil*/];
    NSData *inputData = [NLISOUtils
                         hexStr2Data:[@"123482398472384834" stringByReplacingOccurrencesOfString:@" " withString:@""]];
    NSData *macData = [pin calcMac:wk input:inputData];
    if (macData.length <= 0) {
        [self setTitle: @"calc mac error"];
    } else {
        [self setTitle:[NSString stringWithFormat:@"mac:%@", [NLDump hexDumpWithData:macData]]];
    }
}
- (void)calcMac4YiLian
{
    id<NLPinInput> pin = (id<NLPinInput>)[self.app.device standardModuleWithModuleType:NLModuleTypeCommonPinInput];
    // 计算mac
    NLWorkingKey *wk = [[NLWorkingKey alloc] initWithIndex:0x04 wk:[NLISOUtils hexStr2Data:@"212223"]];
    NSData *inputData = [NLISOUtils
                         hexStr2Data:[@"3132333435363738 " stringByReplacingOccurrencesOfString:@" " withString:@""]];
    NLMacResult *rslt = [pin calcMacWithKsn:wk input:inputData macAlgorithm:NLMacAlgorithm9606 pinManageType:NLPinManageTypeFIXED];
    if (rslt.mac.length <= 0) {
        [self setTitle:@"calc mac error"];
    } else {
        [self setTitle:[NSString stringWithFormat:@"mac:%@ ksn:%@", [NLDump hexDumpWithData:rslt.mac], [NLDump hexDumpWithData:rslt.ksn]]];
    }
}
@end
