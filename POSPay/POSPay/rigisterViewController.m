//
//  rigisterViewController.m
//  POSPay
//
//  Created by 齐立洋 on 15/1/16.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "rigisterViewController.h"

@interface rigisterViewController ()
- (IBAction)sendIdentifyingCode;
@property (weak, nonatomic) IBOutlet UILabel *timeCountDownLable;
@property (weak, nonatomic) IBOutlet UIButton *sendIdentifyingCodeBtn;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) int secondsCountDown;

@end

@implementation rigisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timeCountDownLable.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)registerUser{
    
    // 手机号
    // 登入密码
    // 提现密码
    // 手机验证码
    // 签名
    
    //
    //    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    //
    //    NSDictionary *parameters = @{@"type":@"shortIntro",@"id":[NSNumber numberWithUnsignedInteger:_journeyId ]};
    //    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //
    //
    //
    //
    //
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //
    //        NSLog(@"Error: %@", error);
    //        
    //    }];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
@end
