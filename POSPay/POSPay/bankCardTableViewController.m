//
//  bankCardTableViewController.m
//  POSPay
//
//  Created by 齐立洋 on 15/3/16.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "bankCardTableViewController.h"
#import "bankCardInfo.h"
#import "addBankCardTableViewCell.h"
#import "tixianViewController1.h"

@interface bankCardTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *bankCardArray;
@property (nonatomic,strong) bankCardInfo *seletedCard;
@end

@implementation bankCardTableViewController

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}
#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.seletedCard = [self.bankCardArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"card2tixian" sender:nil];
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    tixianViewController1 *nextVc = segue.destinationViewController;
    nextVc.bankCardInfo = self.seletedCard;
}


@end
