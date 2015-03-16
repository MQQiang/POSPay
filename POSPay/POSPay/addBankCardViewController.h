//
//  addBankCardViewController.h
//  POSPay
//
//  Created by 齐立洋 on 15/3/15.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class addBankCardViewController, bankCardInfo;
@protocol addViewControllerDelegate <NSObject>

@optional

- (void)addViewController:(addBankCardViewController *)addVc didAddBankCard:(bankCardInfo *)bankcard;
@end

@interface addBankCardViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *userNameLable;
@property (nonatomic, weak) id<addViewControllerDelegate> delegate;
@end
