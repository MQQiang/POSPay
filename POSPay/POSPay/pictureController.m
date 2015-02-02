//
//  pictureController.m
//  POSPay
//
//  Created by 齐立洋 on 15/2/2.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "pictureController.h"

@interface pictureController ()
@property (weak, nonatomic) IBOutlet UIButton *mainPicture;
@property (weak, nonatomic) IBOutlet UIButton *frontPicture;
@property (weak, nonatomic) IBOutlet UIButton *backPicture;

- (IBAction)addMainPicture;
- (IBAction)addFrontPicture;
- (IBAction)addBackPicture;

- (IBAction)upload;

@end

@implementation pictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)addMainPicture {
}

- (IBAction)addFrontPicture {
}

- (IBAction)addBackPicture {
}

- (IBAction)upload {
}
@end
