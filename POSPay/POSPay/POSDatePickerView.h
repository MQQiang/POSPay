//
//  POSDatePickerView.h
//  POSPay
//
//  Created by LiuZhiqi on 15-3-15.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol POSDatePickerViewDelegate <NSObject>

@required   
-(void)setTimeWith:(NSData *)data;
@end




@interface POSDatePickerView : UIView
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)cancel:(id)sender;
- (IBAction)confirm:(id)sender;
@property(weak,nonatomic)id<POSDatePickerViewDelegate> delegate;
+ (POSDatePickerView *)instanceWithFrame:(CGRect)frame;
@end
