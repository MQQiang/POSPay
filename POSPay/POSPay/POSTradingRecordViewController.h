//
//  POSTradingRecordViewController.h
//  POSPay
//
//  Created by LiuZhiqi on 15-3-15.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "POSDatePickerView.h"
@interface POSTradingRecordViewController : UIViewController<POSDatePickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableViewTradeRecord;

-(void) setTimeWith:(NSData*)date;


@end
