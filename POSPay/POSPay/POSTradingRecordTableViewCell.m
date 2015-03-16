//
//  POSTradingRecordTableViewCell.m
//  POSPay
//
//  Created by LiuZhiqi on 15-3-15.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "POSTradingRecordTableViewCell.h"

@implementation POSTradingRecordTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)changeCellWithType:(BOOL) type UserName:(NSString *) username BankName:(NSString * )bankname cardID:(NSString * ) cardId Time:(NSString * ) time PaidMoney:(NSString * ) money transferState:(BOOL) state{
    
    self.label_bankName.text=bankname;
    self.label_userName.text=username;
    if (type==NO) {
        self.label_transferType.text=@"转账到银行卡";
    }else{
        self.label_transferType.text=@"转账到手机号";
        
    }
    self.label_time.text=time;
    self.label_money.text=money;
    if (state==NO) {
        self.label_state.text=@"交易成功";
        [self.label_state setTextColor:[UIColor greenColor]];
        
        
    }else{
        self.label_state.text=@"交易失败";
        
        [self.label_state setTextColor:[UIColor redColor]];
    }
    
    
    
    
    
    
    
}





@end
