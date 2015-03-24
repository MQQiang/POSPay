//
//  POSTradingRecordTableViewCell.h
//  POSPay
//
//  Created by LiuZhiqi on 15-3-15.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface POSTradingRecordTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label_transferType;
@property (weak, nonatomic) IBOutlet UILabel *label_userName;
@property (weak, nonatomic) IBOutlet UILabel *label_bankName;
@property (weak, nonatomic) IBOutlet UILabel *label_cardId;
@property (weak, nonatomic) IBOutlet UILabel *label_money;
@property (weak, nonatomic) IBOutlet UILabel *label_time;
@property (weak, nonatomic) IBOutlet UILabel *label_state;

-(void)changeCellWithType:(BOOL) type UserName:(NSString *) username BankName:(NSString * )bankname cardID:(NSString * ) cardId Time:(NSString * ) time PaidMoney:(NSString * ) money transferState:(BOOL) type;


-(void)setupCellWithDic:(NSDictionary *)dic;


@end
