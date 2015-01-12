//
//  messageFooterView.m
//  POSPay
//
//  Created by 齐立洋 on 15/1/11.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "messageFooterView.h"

@implementation messageFooterView
+ (instancetype)messageFooterView
{
    
    messageFooterView *footerView = [[[NSBundle mainBundle]loadNibNamed:@"messageFooterView" owner:nil options:nil]lastObject];
    return footerView;
}


@end
