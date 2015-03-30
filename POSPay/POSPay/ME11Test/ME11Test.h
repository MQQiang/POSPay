//
//  ME11Test.h
//  MTypeSDK
//
//  Created by su on 14/10/29.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import "BaseTest.h"
#import "POSCardPaymentOrderViewController.h"
@interface ME11Test : BaseTest
@property (nonatomic,weak) POSCardPaymentOrderViewController *targetVC;
- (void)deviceInfo;
- (void)startReadCard;
@end
