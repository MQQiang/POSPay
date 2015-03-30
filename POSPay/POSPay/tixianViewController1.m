//
//  tixianViewController1.m
//  POSPay
//
//  Created by 齐立洋 on 15/3/16.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "tixianViewController1.h"
#import "tixianViewController2.h"

@interface tixianViewController1 ()


@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *shoukuanBank;
@property (weak, nonatomic) IBOutlet UILabel *kahuCity;
@property (weak, nonatomic) IBOutlet UILabel *bankNumber;
@property (weak, nonatomic) IBOutlet UILabel *moneyAmount;
@property (weak, nonatomic) IBOutlet UITextField *tixianNumberField;

@end

@implementation tixianViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shoukuanBank.text = self.bankCardInfo.bankName;
    self.bankNumber.text = self.bankCardInfo.bankNumber;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    tixianViewController2 *Vc2 = segue.destinationViewController;
    Vc2.bankAccountNumber = self.bankNumber.text;
    Vc2.tixianNumber = [self.tixianNumberField.text integerValue];
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
