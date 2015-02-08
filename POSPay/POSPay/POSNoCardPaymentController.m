//
//  POSNoCardPaymentController.m
//  POSPay
//
//  Created by LiuZhiqi on 15-1-7.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "POSNoCardPaymentController.h"
#import "POSEnterCardIdViewController.h"
@interface POSNoCardPaymentController ()
- (IBAction)next:(id)sender;

@end

@implementation POSNoCardPaymentController

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

- (IBAction)next:(id)sender {
    POSEnterCardIdViewController *pushView =[[POSEnterCardIdViewController alloc]init];
    [self.navigationController pushViewController:pushView animated:YES];
    
    
}
@end
