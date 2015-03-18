//
//  FinanceIndexViewController.h
//  POSPay
//
//  Created by mq on 15/3/16.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinanceIndexViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *financeTableView;

@end
