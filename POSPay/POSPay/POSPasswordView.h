//
//  POSPasswordView.h
//  POSPay
//
//  Created by Macintosh on 15-2-5.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passwordViewDelegate <NSObject>

@required
-(void)passwordViewRightPassword;
-(void)passwordViewWrongPassword;

@end


@interface POSPasswordView : UIView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *view_wordsView;
@property(strong,nonatomic) NSMutableString *password;
@property(weak,nonatomic) id<passwordViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *textField_hideField;

+(instancetype )instanceTextView;

@end
