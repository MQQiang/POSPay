//
//  POSCardPaymentController.m
//  POSPay
//
//  Created by LiuZhiqi on 15-1-7.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "POSCardPaymentController.h"
#import "POSPaymentResultController.h"
#import "POSAlertView.h"
#import "POSPickerView.h"
#import "POSCardPaymentOrderViewController.h"

@interface POSCardPaymentController ()<POSPickerViewDelegate>



- (IBAction)selectPurpose:(id)sender;

@end

@implementation POSCardPaymentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self setPickerItems];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)setPickerItems{
    
    _pickerItems=@[@"便民缴费",@"大宗商品",@"日用百货"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
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

- (IBAction)searchAddressBook:(id)sender {
}

- (IBAction)next:(id)sender {
    
    POSCardPaymentOrderViewController *pushView = [[POSCardPaymentOrderViewController alloc] init];
    [self.navigationController pushViewController:pushView animated:YES];
   // [self.navigationController setTabBarItem:YES];
    
    
//    
//    POSPaymentResultController *pushView=[[POSPaymentResultController alloc] init];
//
}




#pragma mark - network & swiping card interface


#pragma mark - pickerDelegate

-(void)POSPicker:(POSPickerView *)picker removePOSPickerViewWithSelectStatus:(BOOL)status
{
    if (status==YES) {
        
        self.pickerButton.titleLabel.text=[self.pickerItems objectAtIndex:[picker.pickView selectedRowInComponent:0]];
    }else{
        ;
    }
}

- (IBAction)selectPurpose:(id)sender {
    
    POSPickerView * picker=[[POSPickerView alloc]init];
    picker=[[[NSBundle mainBundle] loadNibNamed:@"POSPickerView" owner:self options:nil] objectAtIndex:0];
    
    
    
    picker.delegate=self;
    picker.frame=CGRectMake(0, self.view.frame.size.height-picker.frame.size.height, picker.frame.size.width, picker.frame.size.height);
    [self.view addSubview:picker];
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    return self.pickerItems.count;


}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{

    return 1;

}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickerItems objectAtIndex:row];
}

@end
