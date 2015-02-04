//
//  POSPickerView.m
//  POSPay
//
//  Created by LiuZhiqi on 15-1-25.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "POSPickerView.h"

@implementation POSPickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setDelegate:(id<UIPickerViewDelegate,UIPickerViewDataSource,POSPickerViewDelegate>)delegate
{
    _delegate=delegate;
    self.pickView.delegate=delegate;
}
- (IBAction)cancel:(id)sender {
    

    [self.delegate POSPicker:self removePOSPickerViewWithSelectStatus:NO];
        [self removeFromSuperview];
    
}

- (IBAction)done:(id)sender {
    [self.delegate POSPicker:self removePOSPickerViewWithSelectStatus:YES];
    [self removeFromSuperview];
}
@end
