//
//  sixNumberPasswordView.m
//  POSPay
//
//  Created by 齐立洋 on 15/2/7.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "sixNumberPasswordView.h"
@interface sixNumberPasswordView()
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIImageView *view1;
@property (weak, nonatomic) IBOutlet UIImageView *view2;
@property (weak, nonatomic) IBOutlet UIImageView *view3;
@property (weak, nonatomic) IBOutlet UIImageView *view4;
@property (weak, nonatomic) IBOutlet UIImageView *view5;
@property (weak, nonatomic) IBOutlet UIImageView *view6;
@property (weak, nonatomic) IBOutlet UIButton *passwordFieldBtn;
@property (strong, nonatomic) NSArray *viewArray;
@property (assign, nonatomic) NSInteger currentLength;
@end
@implementation sixNumberPasswordView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib{
    [self.passwordField becomeFirstResponder];
    self.viewArray = [NSArray arrayWithObjects:self.view1,self.view2,self.view3,self.view4,self.view5,self.view6, nil];
    [self.passwordFieldBtn addTarget:self action:@selector(passwordFieldBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.passwordField];
}
- (sixNumberPasswordView *)init{
    return [[[NSBundle mainBundle]loadNibNamed:@"sixNumberPasswordView" owner:nil options:nil]lastObject];
}
+ (sixNumberPasswordView *)sixNumberPasswordView{
    return [[sixNumberPasswordView alloc]init];
}
- (void)passwordFieldBtnClick{
    [self.passwordField becomeFirstResponder];
}
- (void)textChanged{
    NSUInteger changedLengthOfPassword = self.passwordField.text.length;
    if (changedLengthOfPassword>self.currentLength) {//增加长度
        UIImageView *currentImage = self.viewArray[changedLengthOfPassword - 1];
        [currentImage setImage:[UIImage imageNamed:@"箭头（黑）"]];
    }
    else{//减少长度
        UIImageView *currentImage = self.viewArray[changedLengthOfPassword];
        [currentImage setImage:[UIImage imageNamed:@"papasscode_background"]];
    }
    self.currentLength = changedLengthOfPassword;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
