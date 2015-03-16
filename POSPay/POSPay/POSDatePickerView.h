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
-(void)setTimeWith:(NSDate *)date tag:(NSInteger)tag;
@end




@interface POSDatePickerView : UIView
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)cancel:(id)sender;
- (IBAction)confirm:(id)sender;


@property(assign,nonatomic)NSInteger tag;
@property(weak,nonatomic)id<POSDatePickerViewDelegate> delegate;
+ (POSDatePickerView *)instanceWithFrame:(CGRect)frame Id:(NSInteger)tag date:(NSDate*) date;
@end
