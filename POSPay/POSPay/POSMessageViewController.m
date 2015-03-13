//
//  SecondViewController.m
//  POSPay
//
//  Created by mq on 15/1/2.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//




#import "POSMessageViewController.h"
#import "POSMessage.h"
#import "messageCell.h"
#import "messageFooterView.h"
#import "UserInfo.h"

@interface POSMessageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSArray *messages;
@property (weak, nonatomic) IBOutlet UITableView *messageTableView;


@end

@implementation POSMessageViewController

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;// 先用10来看看效果
    
    //return self.messages.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    messageCell *cell = [messageCell cellWithTableView:tableView];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.messageTableView.separatorStyle = NO;
    messageFooterView *footerView = [messageFooterView messageFooterView];
    self.messageTableView.tableFooterView = footerView;
    
    [self requestUserMessageWithType:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestUserMessageWithType:(NSInteger)type{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];
    
    NSString *checkCode = [Util encodeStringWithMD5:[[[[[[[[Util appKey] stringByAppendingString:[Util appVersion] ]stringByAppendingString:@"phonepay.scl.pos.notices.qry"] stringByAppendingString:[UserInfo sharedUserinfo].phoneNum ]   stringByAppendingString:@"1"]stringByAppendingString:@"0"] stringByAppendingString:@"20"]stringByAppendingString: [UserInfo sharedUserinfo].randomCode]];
    
    
    NSDictionary *parameters = @{@"app_key":[Util appKey],@"version":[Util appVersion],@"service_type":@"phonepay.scl.pos.notices.qry",@"mobile":[UserInfo sharedUserinfo].phoneNum,@"sign":checkCode,@"notice_type":@1,@"start_rows":@"0",@"offset":@"20"};
    
    
    [manager POST:[Util baseServerUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        if([dic[@"rsp_code"] isEqualToString:@"0000"]){
            
            //            [[UserInfo sharedUserinfo] setUserInfoWithDic:dic];
            
            //            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [[[UIAlertView  alloc] initWithTitle:@"" message:@"密码修改成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
        }
        else{
            
            
            [[[UIAlertView  alloc] initWithTitle:@"查询用户信息失败" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
            
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
