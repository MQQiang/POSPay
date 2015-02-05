//
//  POSCardPaymentOrderViewController.m
//  POSPay
//
//  Created by LiuZhiqi on 15-1-25.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "POSCardPaymentOrderViewController.h"
#import "POSAlertView.h"
#import "POSPasswordView.h"
#import "POSPaymentResultController.h"
@interface POSCardPaymentOrderViewController ()<passwordViewDelegate>
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
//    self.view.userInteractionEnabled=NO;

    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(swipeSuccess:) object:alertView];
    [thread start];
//

//    alertView.lableTextDetail.text=@"刷卡成功";
//    
//    sleep(2);
//    [alertView removeFromSuperview];
//    
}
-(void )swipeSuccess:(POSAlertView * )alertView
{
    sleep(2);
    alertView.lableTextDetail.text=@"刷卡成功";

    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(enterPassword:) object:alertView];
    [thread start];
    
}
-(void )enterPassword:(POSAlertView * )alertView
{
    sleep(2);
    [alertView removeFromSuperview];
    POSPasswordView * passwordView=[POSPasswordView instanceTextView];
    passwordView.delegate=self;
    [self.view addSubview:passwordView];
    //self.view.userInteractionEnabled=NO;

    
    
}
-(void)passwordViewRightPassword{
    POSCardPaymentOrderViewController* pushView=[[POSPaymentResultController alloc] init];
    [self.navigationController pushViewController:pushView animated:YES];


}

@end
