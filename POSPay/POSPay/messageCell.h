//
//  messageCell.h
//  POSPay
//
//  Created by 齐立洋 on 15/1/11.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class POSMessage;

@interface messageCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tabelView;
@property (strong, nonatomic) POSMessage *message;
@end
