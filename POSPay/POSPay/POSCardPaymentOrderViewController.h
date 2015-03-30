//
//  POSCardPaymentOrderViewController.h
//  POSPay
//
//  Created by LiuZhiqi on 15-1-25.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, SwipeCardType) {
   
    SwipeCardTypeCiCard,
    SwipeCardTypeICCard,
    SwipeCardTypeFailed
    
};


@interface POSCardPaymentOrderViewController : UIViewController
@property (assign, nonatomic) IBOutlet UITextView *textView;


@property(nonatomic,strong)NSString *secondTrackString;
@property(nonatomic,strong)NSString *deviceId;
@property(nonatomic,assign)SwipeCardType swipeCardResult;


- (IBAction)disConnect:(id)sender;
- (IBAction)scan:(id)sender;
- (IBAction)onClick:(id)sender;
- (IBAction)clear:(id)sender;
- (IBAction)connect:(id)sender;
@end
