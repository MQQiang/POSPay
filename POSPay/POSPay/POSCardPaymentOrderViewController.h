//
//  POSCardPaymentOrderViewController.h
//  POSPay
//
//  Created by LiuZhiqi on 15-1-25.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface POSCardPaymentOrderViewController : UIViewController
@property (assign, nonatomic) IBOutlet UITextView *textView;


- (IBAction)disConnect:(id)sender;
- (IBAction)scan:(id)sender;
- (IBAction)onClick:(id)sender;
- (IBAction)clear:(id)sender;
- (IBAction)connect:(id)sender;
@end
