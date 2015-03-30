//
//  tixianViewController2.m
//  POSPay
//
//  Created by 齐立洋 on 15/3/16.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//
#import "tixianViewController2.h"

@interface tixianViewController2 ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *shoukuanAccountNmuber;
@property (weak, nonatomic) IBOutlet UILabel *moneyAmount;
@property (weak, nonatomic) IBOutlet UILabel *shouxufeiLable;

@property (weak, nonatomic) IBOutlet UIButton *normalBtn;
@property (weak, nonatomic) IBOutlet UIButton *fastBtn;
@property (assign, nonatomic) BOOL tixianType;//提现方式标志位，0表示普通，1表示快速
- (IBAction)confirmBtnClick:(id)sender;

@end

@implementation tixianViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shoukuanAccountNmuber.text = self.bankAccountNumber;
    self.moneyAmount.text = [NSString stringWithFormat:@"%d",self.tixianNumber ];
    self.tixianType = 0;
    self.normalBtn.selected = YES;
    self.shouxufeiLable.text = nil;
    
    [self.normalBtn setImage:[UIImage imageNamed:@"选择icon（未选）"] forState:UIControlStateNormal];
    [self.normalBtn setImage:[UIImage imageNamed:@"选择icon（已选）"] forState:UIControlStateSelected];
    self.normalBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [self.normalBtn addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.fastBtn setImage:[UIImage imageNamed:@"选择icon（未选）"] forState:UIControlStateNormal];
    [self.fastBtn setImage:[UIImage imageNamed:@"选择icon（已选）"] forState:UIControlStateSelected];
    self.fastBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [self.fastBtn addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)checkboxClick:(UIButton *)btn
{
    if (btn.selected == NO) {
        btn.selected = !btn.selected;
        if (btn == self.normalBtn) {
            self.fastBtn.selected = NO;
            self.shouxufeiLable.text = nil;
        }
        else{
            self.normalBtn.selected = NO;
            //计算手续费并显示
            self.shouxufeiLable.text = @"手续费：50元";
        }
        self.tixianType = !self.tixianType;
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)confirmBtnClick:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请输入提现密码" message:[NSString stringWithFormat:@"%@元",self.moneyAmount.text] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
    UITextField *tf = [alertView textFieldAtIndex:0];
    tf.keyboardType = UIKeyboardTypeNumberPad;
    [alertView show];
}
#pragma mark - alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        UITextField *tixianPasswordField = [alertView textFieldAtIndex:0];//取出用户输入的密码框
        UITextField *tf = [alertView textFieldAtIndex:0];
        [tf resignFirstResponder];
        [self performSegueWithIdentifier:@"confirm2succeed" sender:nil];
    }
}
@end
