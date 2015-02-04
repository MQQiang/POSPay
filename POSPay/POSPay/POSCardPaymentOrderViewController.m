//
//  POSCardPaymentOrderViewController.m
//  POSPay
//
//  Created by LiuZhiqi on 15-1-25.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "POSCardPaymentOrderViewController.h"
#import "POSAlertView.h"
@interface POSCardPaymentOrderViewController ()
- (IBAction)confirm:(id)sender;

@end

@implementation POSCardPaymentOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)confirm:(id)sender {
    
    
    
    POSAlertView * alertView = [POSAlertView instanceTextView];
    
    alertView.lableTextDetail.text=@"请刷银行卡";
    
    
    [self.view addSubview:alertView];
    self.view.userInteractionEnabled=NO;
//
//    sleep(2);
//    alertView.lableTextDetail.text=@"刷卡成功";
//    
//    sleep(2);
//    [alertView removeFromSuperview];
//    
}
@end
