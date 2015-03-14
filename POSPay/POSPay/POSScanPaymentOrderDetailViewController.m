//
//  POSScanPaymentOrderDetailViewController.m
//  POSPay
//
//  Created by LiuZhiqi on 15-3-14.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "POSScanPaymentOrderDetailViewController.h"
#import "POSPaymentResultController.h"
@interface POSScanPaymentOrderDetailViewController ()
- (IBAction)confirm:(id)sender;
- (IBAction)payWIthCard:(id)sender;
- (IBAction)payWIthBalance:(id)sender;

@end

@implementation POSScanPaymentOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.typePayment=0;
    
    
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
    if (self.typePayment==0) {
        [self enterPassword];
    }else
    {
       [self enterPassword];
    }
    
}
-(void)enterPassword{
    sleep(2);
    POSPasswordView * passwordView=[POSPasswordView instanceTextView];
    passwordView.delegate=self;
    [self.view addSubview:passwordView];
    //self.view.userInteractionEnabled=NO;
}

- (IBAction)payWIthCard:(id)sender {
    
    self.typePayment=1;
    
}

- (IBAction)payWIthBalance:(id)sender {
    self.typePayment=0;
}






#pragma mark - passWordView delegate


-(void)passwordViewRightPassword{
    POSPaymentResultController* pushView=[[POSPaymentResultController alloc]init];
    [self.navigationController pushViewController:pushView animated:YES];
    
}
-(void)passwordViewWrongPassword{
    
}

@end
