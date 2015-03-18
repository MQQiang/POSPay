//
//  FinanceIndexViewController.m
//  POSPay
//
//  Created by mq on 15/3/16.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "FinanceIndexViewController.h"
#import "FinanceIndexViewTableViewCell.h"
@interface FinanceIndexViewController ()

@end

@implementation FinanceIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_financeTableView registerNib:[UINib nibWithNibName:@"FinanceIndexViewTableViewCell" bundle:nil]forCellReuseIdentifier:@"FinaceIndexTabelView"];
   
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
//    _financeTableView 
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FinanceIndexViewTableViewCell * cell =  [_financeTableView dequeueReusableCellWithIdentifier:@"FinaceIndexTabelView"];
    
    
    return cell;
    
    
}


@end
