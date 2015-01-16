//
//  findPwdViewController.m
//  POSPay
//
//  Created by 齐立洋 on 15/1/16.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "findPwdViewController.h"

@interface findPwdViewController ()
- (IBAction)sendIdentifyingCode;
@property (weak, nonatomic) IBOutlet UILabel *timeCountDownLable;
@property (weak, nonatomic) IBOutlet UIButton *sendIdentifyingCodeBtn;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) int secondsCountDown;
@end

@implementation findPwdViewController
- (IBAction)next {
    
    //加判断
    [self performSegueWithIdentifier:@"toNewPwdViewController" sender:nil];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)sendIdentifyingCode {
    self.secondsCountDown = 60;
    NSTimer *countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    self.timer = countDownTimer;
    self.sendIdentifyingCodeBtn.enabled = NO;
    self.timeCountDownLable.hidden = NO;
    
}
- (void)timeFireMethod{
    self.secondsCountDown--;
    self.timeCountDownLable.text = [NSString stringWithFormat:@"%ds",self.secondsCountDown];
    if (self.secondsCountDown == 0 ) {
        [self.timer invalidate];
        self.sendIdentifyingCodeBtn.enabled = YES;
        self.timeCountDownLable.hidden = YES;
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

@end
