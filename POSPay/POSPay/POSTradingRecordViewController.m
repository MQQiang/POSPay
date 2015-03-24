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

#import "UserInfo.h"
@interface POSTradingRecordViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *button_start;
@property (weak, nonatomic) IBOutlet UIButton *button_end;
- (IBAction)chooseStartTime:(id)sender;
- (IBAction)chooseEndTime:(id)sender;
@property(nonatomic,strong) NSMutableArray *tradeRecordArray;
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
    
    
    _tradeRecordArray = [[NSMutableArray alloc] init];
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

-(void)requestTradeRecords{
    
    
    //Todo  返回的     settles =     （)处理
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];
    
    NSMutableArray *stringArray = [NSMutableArray arrayWithObjects:[Util appKey], [Util appVersion],@"phonepay.scl.pos.settle.qry",[UserInfo sharedUserinfo].phoneNum,@"0",@"20",[UserInfo sharedUserinfo].randomCode,nil];
    
    
    NSString *checkCode = [Util MD5WithStringArray:stringArray];
    
    
    
    NSDictionary *parameters = @{@"app_key":[Util appKey],@"version":[Util appVersion],@"service_type":@"phonepay.scl.pos.settle.qry",@"mobile":[UserInfo sharedUserinfo].phoneNum,@"create_date":@"20150301000000",@"end_date":@"20150302000000",@"start_rows":@"0",@"offset":@"20",@"sign":checkCode};
    
    [manager POST:[Util baseServerUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        if([dic[@"rsp_code"] isEqualToString:@"0000"]){
            
            //            [[UserInfo sharedUserinfo] setUserInfoWithDic:dic];
            
            //            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            _tradeRecordArray = dic[@"settle"];
            
            [_tableViewTradeRecord reloadData];
            
        }
        else{
            
            
            [[[UIAlertView  alloc] initWithTitle:@"查询失败" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
            
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
