//
//  FinaceDetailViewController.h
//  POSPay
//
//  Created by mq on 15/3/16.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinaceDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *wenYingLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UILabel *finishPercentLabel;
@property (strong, nonatomic) IBOutlet UIView *progressView;
@property (strong, nonatomic) IBOutlet UILabel *shouYiLvLabel;
@property (strong, nonatomic) IBOutlet UILabel *qixianLabel;
@property (strong, nonatomic) IBOutlet UILabel *benJinLabel;
@property (strong, nonatomic) IBOutlet UILabel *shengYuLabel;
@property (strong, nonatomic) IBOutlet UILabel *diZengLabel;
@property (strong, nonatomic) IBOutlet UILabel *touZiLabel;

@end
