//
//  cardDetialViewController.m
//  POSPay
//
//  Created by 齐立洋 on 15/3/27.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "cardDetialViewController.h"

@interface cardDetialViewController ()
@property (weak, nonatomic) IBOutlet UILabel *bankNameLable;
@property (weak, nonatomic) IBOutlet UILabel *bankCardTypeLable;
@property (weak, nonatomic) IBOutlet UILabel *bankCardNumberLable;
@property (weak, nonatomic) IBOutlet UILabel *bankCardUserLable;
@property (weak, nonatomic) IBOutlet UILabel *kaihuBankLabel;

@end

@implementation cardDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.bankCardNumberLable.text = self.seletedCardInfo.bankNumber;
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

@end
