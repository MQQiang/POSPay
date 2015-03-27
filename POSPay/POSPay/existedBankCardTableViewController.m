//
//  existedBankCardTableViewController.m
//  POSPay
//
//  Created by 齐立洋 on 15/3/15.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "existedBankCardTableViewController.h"
#import "addBankCardTableViewCell.h"
#import "bankCardInfo.h"
#import "addBankCardViewController.h"
#import "UserInfo.h"
#import "cardDetialViewController.h"
@interface existedBankCardTableViewController ()<addViewControllerDelegate,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *bankCardArray;
@property (nonatomic,assign) NSInteger *seletedRow;
@end

@implementation existedBankCardTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 模拟数据
    NSMutableArray *array = [NSMutableArray array];
    bankCardInfo *b1 = [[bankCardInfo alloc]init];
    b1.bankName = @"中国银行";
    b1.bankCardType = @"储蓄卡";
    b1.bankNumber = @"6666";
    bankCardInfo *b2 = [[bankCardInfo alloc]init];
    b2.bankName = @"招商银行";
    b2.bankCardType = @"信用卡";
    b2.bankNumber = @"8888";
    [array addObject:b1];
    [array addObject:b2];
    self.bankCardArray = array;
    
    [self addReturnBtn];
    [self addRightBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[addBankCardViewController class]]) {
        addBankCardViewController *addVc = segue.destinationViewController;
        addVc.delegate = self;
    }
    else if ([segue.destinationViewController isKindOfClass:[cardDetialViewController class]]){
        cardDetialViewController *cardDetialVc = segue.destinationViewController;
        cardDetialVc.seletedCardInfo = [self.bankCardArray objectAtIndex:self.seletedRow];
    }
    
}
- (void)addRightBtn{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(addButtonClick)];
    self.navigationItem.rightBarButtonItem = rightButton;
}
- (void)addButtonClick{
    [self performSegueWithIdentifier:@"existed2add" sender:nil];
}
- (void)addReturnBtn{
    UIButton *returnBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 32)];
    [returnBtn setTitle:@"返回" forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnToMain) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *returnBtnItem = [[UIBarButtonItem alloc]initWithCustomView:returnBtn];
    self.navigationItem.leftBarButtonItem = returnBtnItem;
}
- (void)returnToMain{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.bankCardArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    addBankCardTableViewCell *cell = [addBankCardTableViewCell cellWithTableView:tableView];
    bankCardInfo *info = self.bankCardArray[indexPath.row];
    cell.name.text = info.bankName;
    cell.cardType.text = info.bankCardType;
    cell.cardNumber.text = info.bankNumber;
    

    // Configure the cell...
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.bankCardArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
#pragma mark - tabelView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.seletedRow = indexPath.row;
    
    [self performSegueWithIdentifier:@"existed2detial" sender:nil];
}

#pragma mark - addVcDelegate
- (void)addViewController:(addBankCardViewController *)addVc didAddBankCard:(bankCardInfo *)bankcard{
    //  完成当前view的数据添加
    [self.bankCardArray addObject:bankcard];
    [self.tableView reloadData];
}

-(void)requestReceiverAcount{
    // 处理settles字段 ToDo
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];
    
    NSMutableArray *stringArray = [NSMutableArray arrayWithObjects:[Util appKey], [Util appVersion],@"phonepay.scl.pos.bankcard.qry",[UserInfo sharedUserinfo].phoneNum,[UserInfo sharedUserinfo].randomCode,nil];
    
    
    NSString *checkCode = [Util MD5WithStringArray:stringArray];
    
    
    
    NSDictionary *parameters = @{@"app_key":[Util appKey],@"version":[Util appVersion],@"service_type":@"phonepay.scl.pos.bankcard.qry",@"mobile":[UserInfo sharedUserinfo].phoneNum,@"sign":checkCode};
    
    [manager POST:[Util baseServerUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        if([dic[@"rsp_code"] isEqualToString:@"0000"]){
            
            //            [[UserInfo sharedUserinfo] setUserInfoWithDic:dic];
            
            //            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            
            _bankCardArray = dic[@"settle"];
            
            
            
        }
        else{
            
            
            [[[UIAlertView  alloc] initWithTitle:@"查询银行卡信息失败" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
            
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        NSLog(@"operation: %@", operation.responseString);
        
        [Util alertNetworkError:self.view];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    
    
    
    
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
