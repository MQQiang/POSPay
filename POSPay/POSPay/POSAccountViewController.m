//
//  POSAccountViewControllerTableViewController.m
//  POSPay
//
//  Created by LiuZhiqi on 15-1-5.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//
#import "POSAboutProductController.h"
#import "POSAccountViewController.h"
#import "POSAccountTopCell.h"
#import "UserInfo.h"

@interface POSAccountViewController ()

@end

@implementation POSAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCellInfo];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
#warning 这几个backgroundcolor 和tint？？ 
    [self.navigationController.navigationBar setBarTintColor: [UIColor cyanColor]] ;
 
    [self.tableView registerNib:[UINib nibWithNibName:@"POSAccountTopCell" bundle:nil] forCellReuseIdentifier:@"POSAccountViewControllerTopCell"];
//    [_infoTabelView registerNib:[UINib nibWithNibName:@"LRBPathTabelViewCell" bundle:nil] forCellReuseIdentifier:@"PathTableViewId"];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setCellInfo
{
    self.cellInfo=@[@[@"name",@"可提款余额",@"不可用余额"],@[@"绑定银行卡",@"提款到我的银行卡"],@[@"交易记录"],@[@"我的刷卡器",@"充值冻结刷卡器保证金"],@[@"我的订单"],@[@"完善账号信息",@"实名认证",@"高级认证",@"修改密码",@"安全退出"]];

}

- (IBAction)detailBarAction:(id)sender {
    POSAboutProductController *pushView=[[POSAboutProductController alloc] init];
    pushView.hidesBottomBarWhenPushed=YES;
  //  [pushView.tabBarController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:pushView animated:YES];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return self.cellInfo.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[self.cellInfo objectAtIndex:section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    //cell.
    if(indexPath.section==0&&indexPath.row==0)
    {
        
        POSAccountTopCell * cell=[self.tableView dequeueReusableCellWithIdentifier:@"POSAccountViewControllerTopCell"];
        cell.nameLabel.text=@"name";
        cell.phoneLabel.text=@"123456789";
        cell.balanceLabel.text=@"30000";
        return cell;
    }
#warning 只能初始化设置style？
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"POSAccountViewControllerCell" ];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"POSAccountViewControllerTableViewControllerId"];
    }
    
    
    
    cell.textLabel.text=[[self.cellInfo objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    // Configure the cell...
    if(indexPath.section==0)
    {
        if(indexPath.row==1){
            cell.detailTextLabel.text=@"20000";
        }
        if(indexPath.row==2){
            cell.detailTextLabel.text=@"10000";
            
        }
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0) {
        return 85;
    }
    return 44;
}


-(void)requestUserInfo{
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];
    
    NSString *checkCode = [Util encodeStringWithMD5:[[[[Util appKey] stringByAppendingString:[Util appVersion] ]stringByAppendingString:@"phonepay.scl.pos.user.qry" ] stringByAppendingString:[UserInfo sharedUserinfo].phoneNum]];
    
    
    
    NSDictionary *parameters = @{@"app_key":[Util appKey],@"version":[Util appVersion],@"service_type":@"phonepay.scl.pos.user.qry",@"mobile":[UserInfo sharedUserinfo].phoneNum,@"sign":checkCode};
    
    [manager GET:[Util baseServerUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        if([dic[@"rsp_code"] isEqualToString:@"0000"]){
            
            [[UserInfo sharedUserinfo] setUserInfoWithDic:dic];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }
        else{
            
            
            [[[UIAlertView  alloc] initWithTitle:@"登录失败" message:@"请检查用户名密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        [Util alertNetworkError:self.view];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}
-(void)refreshAccountViewWithDic:(NSDictionary *)dic{
    
    NSString *checkString  =dic[@"verify_status"];
    if([checkString isEqualToString:@"0"]){
        
        
        
        
    }
    else if([checkString isEqualToString:@"1"]) {
        
        
        
    }
    else{
        
        [[UserInfo sharedUserinfo] setDetailUserInfo:dic];
        
        
        
    }
    
}
-(void)requestRateWithType:(NSInteger)type{
    //"费率类型分为：01:刷卡支付;
    // 02：快捷支付；03:转账汇款;04:系统转账;05:用户及时提现"
    
    // 手机号
    // 费率类型
    //签名
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];
    
    NSString *checkCode = [Util encodeStringWithMD5:[[[[[Util appKey] stringByAppendingString:[Util appVersion] ]stringByAppendingString:@"phonepay.scl.pos.settle.qryrate" ] stringByAppendingString:[UserInfo sharedUserinfo].phoneNum] stringByAppendingString:[[NSNumber numberWithInteger:type] stringValue]]];
    
    
    
    NSDictionary *parameters = @{@"app_key":[Util appKey],@"version":[Util appVersion],@"service_type":@"phonepay.scl.pos.settle.qryrate",@"mobile":[UserInfo sharedUserinfo].phoneNum,@"rate_type":[[NSNumber numberWithInteger:type] stringValue],@"sign":checkCode};
    
    [manager GET:[Util baseServerUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        if([dic[@"rsp_code"] isEqualToString:@"0000"]){
            
            [[UserInfo sharedUserinfo] setUserInfoWithDic:dic];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }
        else{
            
            
            [[[UIAlertView  alloc] initWithTitle:@"" message:@"查询费率失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        [Util alertNetworkError:self.view];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
