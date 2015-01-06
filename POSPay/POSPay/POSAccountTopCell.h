//
//  POSAccountTopCell.h
//  POSPay
//
//  Created by LiuZhiqi on 15-1-6.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface POSAccountTopCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *portrait;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;

@end
