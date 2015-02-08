//
//  POSEnterCardInfoViewController.m
//  POSPay
//
//  Created by Macintosh on 15-2-9.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "POSEnterCardInfoViewController.h"
#import "POSPaymentResultController.h"
@interface POSEnterCardInfoViewController ()
- (IBAction)next:(id)sender;

@end

@implementation POSEnterCardInfoViewController

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
    POSPaymentResultController *pushView =[[POSPaymentResultController alloc]init];
    [self.navigationController pushViewController:pushView animated:YES];
    
    
}
@end
