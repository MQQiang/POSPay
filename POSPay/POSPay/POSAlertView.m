//
//  POSAlertView.m
//  POSPay
//
//  Created by LiuZhiqi on 15-1-7.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "POSAlertView.h"

@implementation POSAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype )instanceTextView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"POSAlertView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

@end
