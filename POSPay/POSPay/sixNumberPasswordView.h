//
//  sixNumberPasswordView.h
//  POSPay
//
//  Created by 齐立洋 on 15/2/7.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sixNumberPasswordView : UIView
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (sixNumberPasswordView *)init;
+ (sixNumberPasswordView *)sixNumberPasswordView;
@end
