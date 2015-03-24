//
//  addBankCardViewController.m
//  POSPay
//
//  Created by 齐立洋 on 15/3/15.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "addBankCardViewController.h"
#import "bankCardInfo.h"
#import "UserInfo.h"
@interface addBankCardViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *bankCardNumberField;
@property (copy, nonatomic) NSString *bankName;
@property (copy, nonatomic) NSString *province;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *bankFullName;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

- (IBAction)nextBtnClick:(id)sender;

@end

@implementation addBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)add {
    // 1.关闭当前控制器
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    // 2.传递数据给上一个控制器
    // 2.通知代理
    if ([self.delegate respondsToSelector:@selector(addViewController:didAddBankCard:)]) {
        bankCardInfo *bankCard = [[bankCardInfo alloc]init];
        bankCard.bankNumber = self.bankCardNumberField.text;
        [self.delegate addViewController:self didAddBankCard:bankCard];
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
#pragma mark - tableView data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

#pragma mark - tableView delegage
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addBankCardTableViewCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = @"请选择银行";
    return cell;
}
#pragma mark - alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self add];
    }
}

- (IBAction)nextBtnClick:(id)sender {
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"    请再次确认您输入的银行卡号（%@）正确，且持卡人姓名为【】。",self.bankCardNumberField.text] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"完成", nil];
    [view show];
}

-(void)addBackCardInfo{
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];
    
    NSMutableArray *stringArray = [NSMutableArray arrayWithObjects:[Util appKey], [Util appVersion],@"phonepay.scl.pos.card.addcard",[UserInfo sharedUserinfo].phoneNum,@"6217906200000223011",@"104331000108",[UserInfo sharedUserinfo].randomCode,nil];
    
    
    NSString *checkCode = [Util MD5WithStringArray:stringArray];
    
    
    
    NSDictionary *parameters = @{@"app_key":[Util appKey],@"version":[Util appVersion],@"service_type":@"phonepay.scl.pos.card.addcard",@"mobile":[UserInfo sharedUserinfo].phoneNum,@"card_user_name":@"MQ",@"card_no":@"6217906200000223011",@"bank_name":@"中国银行股份有限公司杭州浙大支行",@"bank_union_code":@"104331000108",@"sign":checkCode};
    
    [manager POST:[Util baseServerUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        if([dic[@"rsp_code"] isEqualToString:@"0000"]){
            
            //            [[UserInfo sharedUserinfo] setUserInfoWithDic:dic];
            
            //            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [[[UIAlertView  alloc] initWithTitle:@"" message:@"添加银行卡成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
        }
        
        else  if([dic[@"rsp_code"] isEqualToString:@"6021"]){
            
            [[[UIAlertView  alloc] initWithTitle:@"错误" message:@"银行卡用户名与认证用户名不一致" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
        }
        
        else  if([dic[@"rsp_code"] isEqualToString:@"6020"]){
            
            [[[UIAlertView  alloc] initWithTitle:@"错误" message:@"该银行卡已绑定" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
        }
        
        else{
            
            
            [[[UIAlertView  alloc] initWithTitle:@"转账失败" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
            
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        NSLog(@"operation: %@", operation.responseString);
        
        [Util alertNetworkError:self.view];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    
    
    
    
}



@end
