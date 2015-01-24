//
//  rigisterViewController.m
//  POSPay
//
//  Created by 齐立洋 on 15/1/16.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "rigisterViewController.h"

@interface rigisterViewController ()<UIAlertViewDelegate>
- (IBAction)sendIdentifyingCode;
- (IBAction)rigister;
- (IBAction)loadServiceContract;
- (IBAction)agreeServiceContract;

//textField控件
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *passwordAgain;
@property (weak, nonatomic) IBOutlet UITextField *identifingCode;


@property (weak, nonatomic) IBOutlet UILabel *timeCountDownLable;
@property (weak, nonatomic) IBOutlet UIButton *sendIdentifyingCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreeToContractBtn;


@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) int secondsCountDown;
@property (assign, nonatomic,getter=isAgree) BOOL agreeToContract;//标志是否同意服务协议

@end

@implementation rigisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timeCountDownLable.hidden = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneNumber];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.password];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.passwordAgain];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.identifingCode];
    self.sendIdentifyingCodeBtn.enabled = NO;
    self.downBtn.enabled = NO;
    self.agreeToContract = NO;
    
//    [self registerUser];
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
    NSString *pw = [Util encodeStringWithMD5:@"mobile123456"];
    NSString *stPw = [Util encodeStringWithMD5:@"mobile123456"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];
    
    NSString *checkCode = [Util encodeStringWithMD5:[[[[[[[[Util appKey] stringByAppendingString:[Util appVersion] ]stringByAppendingString:@"phonepay.scl.pos.user.reg" ] stringByAppendingString:@"13656678405"] stringByAppendingString:pw] stringByAppendingString:stPw]stringByAppendingString:@"1234"] stringByAppendingString:[Util signSuffix]] ];
//    NSString *sign = [checkCode stringByAppendingString:[Util signSuffix]];
    
    NSDictionary *parameters = @{@"app_key":[Util appKey],@"version":[Util appVersion],@"service_type":@"phonepay.scl.pos.user.reg",@"mobile":@"13656678405",@"login_pwd":pw,@"settle_pwd":stPw,@"sign":checkCode,@"phone_check_code":@"1234"};
    
    [manager POST:[Util baseServerUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if([dic[@"rsp_code"] isEqualToString:@"0000"]){
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"注册成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"立即登录", nil];
            [alertView show];
            
        }
        else{
            
            
            [[[UIAlertView  alloc] initWithTitle:@"注册失败" message:@"请检查用户名密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
            
        }
   
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        NSLog(@"%@",operation.responseObject);
    }];
    
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

- (IBAction)rigister {
    [self registerUser];

    
}

- (IBAction)loadServiceContract {
    
}

- (IBAction)agreeServiceContract {
    self.agreeToContract = !self.isAgree;
    if(self.isAgree == YES)
        [self.agreeToContractBtn setImage:[UIImage imageNamed:@"确定图标.png"] forState:UIControlStateNormal];
    else [self.agreeToContractBtn setImage:nil forState:UIControlStateNormal];
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
- (void)textChange{
    if (self.phoneNumber.text.length == 11) {
        self.sendIdentifyingCodeBtn.enabled = YES;
    }
    else self.sendIdentifyingCodeBtn.enabled = NO;
    self.downBtn.enabled = (self.phoneNumber.text.length && self.password.text.length && self.passwordAgain.text.length && self.identifingCode.text.length);
}
#pragma UIalertViewDelegate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
@end
