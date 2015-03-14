//
//  POSScanPaymentViewController.m
//  POSPay
//
//  Created by LiuZhiqi on 15-3-14.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "POSScanPaymentViewController.h"
#import "POSScanPaymentOrderDetailViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface POSScanPaymentViewController ()
- (IBAction)next:(id)sender;
@property(assign,nonatomic)BOOL isReading;
@property(strong ,nonatomic)AVCaptureSession* captureSession;
@property(strong,nonatomic)AVCaptureVideoPreviewLayer* videoPreviewLayer ;
@property(assign,nonatomic)BOOL qrcodeFlag;


@end

@implementation POSScanPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(loadFromAlbum)];
    self.navigationItem.rightBarButtonItem=rightButtonItem;
       //[self startReading];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
 
    // Dispose of any resources that can be recreated.
}

- (void)loadFromAlbum{
    POSScanPaymentOrderDetailViewController* pushView=[[POSScanPaymentOrderDetailViewController alloc] init];
    [self.navigationController pushViewController:pushView animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/





- (IBAction)next:(id)sender {
    
    POSScanPaymentOrderDetailViewController* pushView=[[POSScanPaymentOrderDetailViewController alloc] init];
    [self.navigationController pushViewController:pushView animated:YES];
//
//    ZBarReaderViewController *reader = [ZBarReaderViewController new];
//    reader.readerDelegate = self;
//    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
//    
//    ZBarImageScanner *scanner = reader.scanner;
//    
//    [scanner setSymbology: ZBAR_I25
//                   config: ZBAR_CFG_ENABLE
//                       to: 0];
//    
//    [self presentModalViewController: reader animated: YES];
//    
//    
//    
}

//
//
//- (void) imagePickerController: (UIImagePickerController*) reader
// didFinishPickingMediaWithInfo: (NSDictionary*) info
//{
//    id<NSFastEnumeration> results =
//    [info objectForKey: ZBarReaderControllerResults];
//    ZBarSymbol *symbol = nil;
//    for(symbol in results)
//        break;
//    
//    self.imageViewQR.image = [info objectForKey: UIImagePickerControllerOriginalImage];
//    
//    [reader dismissModalViewControllerAnimated: YES];
//    
//    //判断是否包含 头'http:'
//    NSString *regex = @"http+:[^\\s]*";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
//    
//    //判断是否包含 头'ssid:'
//    NSString *ssid = @"ssid+:[^\\s]*";;
//    NSPredicate *ssidPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",ssid];
//    NSString* text= symbol.data ;
//   // label.text =  symbol.data ;
//    
//    if ([predicate evaluateWithObject:text]) {
//        
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil
//                                                        message:@"It will use the browser to this URL。"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"Close"
//                                              otherButtonTitles:@"Ok", nil];
//        alert.delegate = self;
//        alert.tag=1;
//        [alert show];
//        
//        
//        
//    }
//    else if([ssidPre evaluateWithObject:text]){
//        
//        NSArray *arr = [text componentsSeparatedByString:@";"];
//        
//        NSArray * arrInfoHead = [[arr objectAtIndex:0] componentsSeparatedByString:@":"];
//        
//        NSArray * arrInfoFoot = [[arr objectAtIndex:1] componentsSeparatedByString:@":"];
//        
//        
//        text=[NSString stringWithFormat:@"ssid: %@ \n password:%@",[arrInfoHead objectAtIndex:1],[arrInfoFoot objectAtIndex:1]];
//        
//        
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:text        message:@"The password is copied to the clipboard , it will be redirected to the network settings interface" delegate:nil   cancelButtonTitle:@"Close"    otherButtonTitles:@"Ok", nil];
//        
//        
//        alert.delegate = self;
//        alert.tag=2;
//        [alert show];
//        
//        UIPasteboard *pasteboard=[UIPasteboard generalPasteboard];
//        //        然后，可以使用如下代码来把一个字符串放置到剪贴板上：
//        pasteboard.string = [arrInfoFoot objectAtIndex:1];
//        
//        
//    }
//}
//
//








@end
