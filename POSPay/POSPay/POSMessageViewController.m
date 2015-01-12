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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
