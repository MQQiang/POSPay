//
//  POSScanPaymentViewController.h
//  POSPay
//
//  Created by LiuZhiqi on 15-3-14.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZBarSDK/Headers/ZBarSDK/ZBarSDK.h"
@interface POSScanPaymentViewController : UIViewController<ZBarReaderDelegate>
@property(strong,nonatomic) UIImageView *imageViewQR;
@end
