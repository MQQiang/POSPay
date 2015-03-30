//
//  detialViewController.m
//  POSPay
//
//  Created by 齐立洋 on 15/3/30.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "detialViewController.h"


@interface detialViewController ()
- (IBAction)downBtnClick:(id)sender;

@end

@implementation detialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
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

- (IBAction)downBtnClick:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
@end
