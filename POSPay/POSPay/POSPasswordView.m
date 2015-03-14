//
//  POSPasswordView.m
//  POSPay
//
//  Created by Macintosh on 15-2-5.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "POSPasswordView.h"

@implementation POSPasswordView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype )instanceTextView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"POSPasswordView" owner:nil options:nil];
    
    return [nibView objectAtIndex:0];
}

-(void)didMoveToWindow{
    self.textField_hideField.delegate=self;
    if (self.password==nil) {
        self.password=[[NSMutableString alloc] init];

    }
    BOOL test=[self.textField_hideField becomeFirstResponder];
   // NSLog(@"%@",[self.textField_hideField resignFirstResponder]) ;
    self.password=[[NSMutableString alloc] initWithString:@""];
    
}



-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length==1) {
        if (self.password.length<6) {
            UITextField *currentField=[self.view_wordsView.subviews objectAtIndex:self.password.length];
           [self.password appendString:string];
            NSLog(@"%@,%lu at%lu",_password,(unsigned long)_password.length,currentField.tag);
            currentField.text=string;
        
        }
        if (self.password.length>5) {
            [self.delegate passwordViewRightPassword];
        }
    }else{
        
        [self.password deleteCharactersInRange:range];
        
        UITextField *currentField=[self.view_wordsView.subviews objectAtIndex:self.password.length];
       
        currentField.text=string;
        
        
    }
    return YES;
    


}
@end
