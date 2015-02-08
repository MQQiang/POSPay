//
//  ConsumeTest.h
//  MTypeSDK
//
//  Created by su on 14/6/18.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import "BaseTest.h"

@interface ConsumeTest : BaseTest
-(void)consume;


#pragma mark - no test
- (void)pinInputWithAmt:(NSDecimalNumber *)amt swipeResult:(NLSwipeResult *)rslt;

@end
