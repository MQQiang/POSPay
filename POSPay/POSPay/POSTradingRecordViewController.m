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
    self.startDate=[NSDate dateWithTimeIntervalSinceNow:0];
    self.endDate=[NSDate dateWithTimeIntervalSinceNow:0];
    NSString * temp=[self.startDate.description substringToIndex:10];
    [self.button_end setTitle:[self.startDate.description substringToIndex:10] forState:UIControlStateNormal];
    [self.button_start setTitle:[self.startDate.description substringToIndex:10] forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.button_end.titleLabel.text=[self.startDate.description substringToIndex:10];
    self.button_start.titleLabel.text=[self.startDate.description substringToIndex:10];
    
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


-(void)setTimeWith:(NSDate *)date tag:(NSInteger)tag
{
    if (tag==0) {
        self.button_start.titleLabel.text=[date.description substringToIndex:10];
        self.startDate=date;
    }
    if (tag==1) {
        self.button_end.titleLabel.text=[date.description substringToIndex:10];
        self.endDate=date;
        
    }
}

- (IBAction)chooseStartTime:(id)sender {
    
    POSDatePickerView *datePicker=[POSDatePickerView instanceWithFrame:CGRectMake(0, self.view.frame.size.height-250, self.view.frame.size.width, 200) Id:0 date:self.startDate] ;
    datePicker.delegate=self;
    
    
    [self.view addSubview:datePicker];
                                                                            
    
    
}

- (IBAction)chooseEndTime:(id)sender {
    
    POSDatePickerView *datePicker=[POSDatePickerView instanceWithFrame:CGRectMake(0, self.view.frame.size.height-250, self.view.frame.size.width, 200) Id:1 date:self.endDate] ;
    
    
    datePicker.delegate=self;
    [self.view addSubview:datePicker];
    
    
}
@end
