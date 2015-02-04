//
//  POSCardPaymentController.h
//  POSPay
//
//  Created by LiuZhiqi on 15-1-7.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface POSCardPaymentController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *moneyLabel;
@property(strong,nonatomic) NSArray * pickerItems;
@property (weak, nonatomic) IBOutlet UIButton *pickerButton;


- (IBAction)searchAddressBook:(id)sender;
- (IBAction)next:(id)sender;


@end
