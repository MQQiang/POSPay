//
//  POSTradingRecordViewController.m
//  POSPay
//
//  Created by LiuZhiqi on 15-3-15.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "POSTradingRecordViewController.h"
#import "POSDatePickerView.h"
#import "POSTradingRecordTableViewCell.h"
@interface POSTradingRecordViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *button_start;
@property (weak, nonatomic) IBOutlet UIButton *button_end;
- (IBAction)chooseStartTime:(id)sender;
- (IBAction)chooseEndTime:(id)sender;

@end

@implementation POSTradingRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableViewTradeRecord registerNib:[UINib nibWithNibName:@"POSTradingRecordTableViewCell" bundle:nil] forCellReuseIdentifier:@"POSTradingRecordTableViewCell"];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath   {
    
//    UITableViewCell* cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"asd"];
//    return cell;
    
    POSTradingRecordTableViewCell* cell=[self.tableViewTradeRecord dequeueReusableCellWithIdentifier:@"POSTradingRecordTableViewCell"];
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135;
    
    
}


-(void)setTimeWith:(NSData *)data
{
    NSString* title=[NSString stringWithFormat:@"%@",data];

}

- (IBAction)chooseStartTime:(id)sender {
    
    POSDatePickerView *datePicker=[POSDatePickerView instanceWithFrame:CGRectMake(0, self.view.frame.size.height-250, self.view.frame.size.width, 200)] ;
    datePicker.delegate=self;
    
    
    [self.view addSubview:datePicker];
                                                                            
    
    
}

- (IBAction)chooseEndTime:(id)sender {
    
    POSDatePickerView *datePicker=[POSDatePickerView instanceWithFrame:CGRectMake(0, self.view.frame.size.height-250, self.view.frame.size.width, 200)] ;
    
    
    datePicker.delegate=self;
    [self.view addSubview:datePicker];
    
    
}
@end
