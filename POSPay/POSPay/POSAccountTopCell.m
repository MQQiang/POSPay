//
//  POSAccountTopCell.m
//  POSPay
//
//  Created by LiuZhiqi on 15-1-6.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "POSAccountTopCell.h"
#import "UserInfo.h"
@implementation POSAccountTopCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setupCell{
    
    if ([UserInfo sharedUserinfo].hasDetailInfo) {
        
        _nameLabel.text = [UserInfo sharedUserinfo].name;
        
        _phoneLabel.text = [UserInfo sharedUserinfo].phoneNum;
        
        _balanceLabel.text = [[UserInfo sharedUserinfo].myAssets stringValue];
        
    }
    
    else{
        
        _nameLabel.text=@"name";
        _phoneLabel.text=@"123456789";
        _balanceLabel.text=@"30000";
        
    }

    
}
@end
