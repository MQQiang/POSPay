//
//  PBOCTest.h
//  MTypeSDK
//
//  Created by su on 14/6/18.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import "BaseTest.h"

typedef enum {
    EmvCaseSetTrmnlParams,
    EmvCaseAddAID,
    EmvCaseDeleteAID,
    EmvCaseAddCAPublicKey,
    EmvCaseDeleteCAPublicKey
} EmvCase; // no use

@interface PBOCTest : BaseTest
- (void)testEmv:(NSString*)rowTitle;
@end
