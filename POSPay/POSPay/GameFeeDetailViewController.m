//
//  GameFeeDetailViewController.m
//  POSPay
//
//  Created by mq on 15/3/24.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "GameFeeDetailViewController.h"

@interface GameFeeDetailViewController ()
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *accountTextField;
@property (strong, nonatomic) IBOutlet UITextField *numTextField;
@property (strong, nonatomic) IBOutlet UITextField *accountTextFiled;
@property (strong, nonatomic) IBOutlet UILabel *totalMoneyLabel;
- (IBAction)nextStepButton:(id)sender;

@end

@implementation GameFeeDetailViewController

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

- (IBAction)nextStepButton:(id)sender {
}
@end
