//
//  addBankCardTableViewCell.h
//  POSPay
//
//  Created by 齐立洋 on 15/3/15.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addBankCardTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bankImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *cardType;
@property (weak, nonatomic) IBOutlet UILabel *cardNumber;
+ (instancetype)cellWithTableView:(UITableView *)tabelView;
@end
