//
//  messageCell.m
//  POSPay
//
//  Created by 齐立洋 on 15/1/11.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "messageCell.h"
#import "POSMessage.h"
@interface messageCell()


@end

@implementation messageCell
+ (instancetype)cellWithTableView:(UITableView *)tabelView
{
    static NSString *ID = @"messageCell";
    messageCell *cell = [tabelView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"messageCell" owner:nil options:nil]lastObject];
    }
    return cell;
}
 - (void)setMessage:(POSMessage *)message
{
    self.message = message;
    //self.messageBtn.titleLabel.text = message.message;
}


@end
