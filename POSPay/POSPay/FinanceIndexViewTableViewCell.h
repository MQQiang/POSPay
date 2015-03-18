//
//  FinanceIndexViewTableViewCell.h
//  POSPay
//
//  Created by mq on 15/3/16.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinanceIndexViewTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *percentsLabel;
@property (strong, nonatomic) IBOutlet UILabel *incomePercentLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLengthLabel;
@property (strong, nonatomic) IBOutlet UILabel *lestMoneyLabel;

@end
