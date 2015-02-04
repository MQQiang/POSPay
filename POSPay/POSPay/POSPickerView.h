//
//  POSPickerView.h
//  POSPay
//
//  Created by LiuZhiqi on 15-1-25.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class POSPickerView;

@protocol POSPickerViewDelegate <UIPickerViewDataSource,UIPickerViewDelegate>

@required
-(void)POSPicker:(POSPickerView *) picker removePOSPickerViewWithSelectStatus:(BOOL)status;

@end






@interface POSPickerView : UIView
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (weak, nonatomic) IBOutlet UILabel *pickerTitle;
@property(weak,nonatomic)id <UIPickerViewDelegate,UIPickerViewDataSource,POSPickerViewDelegate> delegate;
@property(assign,nonatomic )NSInteger row;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
