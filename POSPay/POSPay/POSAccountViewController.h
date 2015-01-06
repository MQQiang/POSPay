//
//  POSAccountViewControllerTableViewController.h
//  POSPay
//
//  Created by LiuZhiqi on 15-1-5.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface POSAccountViewController : UITableViewController


@property (strong,nonatomic) NSArray * cellInfo;

- (IBAction)detailBarAction:(id)sender;

@end
