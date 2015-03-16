//
//  addBankCardTableViewCell.m
//  POSPay
//
//  Created by 齐立洋 on 15/3/15.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "addBankCardTableViewCell.h"
@interface addBankCardTableViewCell()


@end
@implementation addBankCardTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tabelView
{
    static NSString *ID = @"bankCardCell";
    addBankCardTableViewCell *cell = [tabelView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"addBankCardTableViewCell" owner:nil options:nil]lastObject];
    }
    return cell;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
