//
//  pictureController.m
//  POSPay
//
//  Created by 齐立洋 on 15/2/2.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "pictureController.h"
#import "authenticationInfo.h"
#import "confirmController.h"
#import "UserInfo.h"

@interface pictureController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *mainPicture;
@property (weak, nonatomic) IBOutlet UIButton *frontPicture;
@property (weak, nonatomic) IBOutlet UIButton *backPicture;
@property (weak, nonatomic) UIButton *currentBtn;
@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;

- (IBAction)addPicture:(id)sender;


- (IBAction)upload;

@end

@implementation pictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackBtn];
    //示例按钮
    [self addRightBtn];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pictureAdded) name:@"pictureAddedNotification" object:self.mainPicture];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pictureAdded) name:@"pictureAddedNotification" object:self.frontPicture];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pictureAdded) name:@"pictureAddedNotification" object:self.backPicture];
    self.uploadBtn.enabled = NO;
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



- (IBAction)addPicture:(id)sender {
    UIActionSheet *sheet;
    self.currentBtn = sender;
    
    // 判断是否支持相机
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
        
    }
    
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
        
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];

}
- (void)pictureAdded{
    if ([self.backPicture backgroundImageForState:UIControlStateNormal] != nil && [self.frontPicture backgroundImageForState:UIControlStateNormal] != nil && [self.backPicture backgroundImageForState:UIControlStateNormal] != nil) {
        self.uploadBtn.enabled = YES;
    }
    else self.uploadBtn.enabled = NO;
}

- (IBAction)upload {

        
        // 手机号
        
        
        //
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];

        NSString *checkCode = [Util encodeStringWithMD5:[[[[[[[Util appKey] stringByAppendingString:[Util appVersion] ]stringByAppendingString:@"phonepay.scl.pos.user.edite"] stringByAppendingString:[UserInfo sharedUserinfo].phoneNum]   stringByAppendingString:_userInfo.name]stringByAppendingString:_userInfo.IDnumber] stringByAppendingString: [UserInfo sharedUserinfo].randomCode]];
        
        NSDictionary *parameters = @{@"app_key":[Util appKey],@"version":[Util appVersion],@"service_type":@"phonepay.scl.pos.user.edite",@"mobile":[UserInfo sharedUserinfo].phoneNum,@"real_name":_userInfo.name,@"idcard_no":_userInfo.IDnumber,@"sign":checkCode};
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:[Util baseServerUrl] parameters: parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            NSData *fontImage = UIImageJPEGRepresentation(_userInfo.frontImage, 1.0);
            
            NSData *backImage = UIImageJPEGRepresentation(_userInfo.backImage, 1.0);
            
            NSData *mainImage = UIImageJPEGRepresentation(_userInfo.mainImage, 1.0);
            
            [formData appendPartWithFileData:fontImage name:@"cred_img_a" fileName:@"1.png" mimeType:@"image/jpg"];
            
            [formData appendPartWithFileData:backImage name:@"cred_img_b" fileName:@"1.png" mimeType:@"image/jpg"];
            
            [formData appendPartWithFileData:mainImage name:@"cred_img_c" fileName:@"1.png" mimeType:@"image/jpg"];
            
            
        } error:nil];
        
        AFHTTPRequestOperation *opration = [[AFHTTPRequestOperation alloc]initWithRequest:request];
        
        opration.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript", nil];
        
        [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
            NSDictionary * dic = (NSDictionary *)responseObject;
            
            NSLog(@"%@",dic);
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [[[UIAlertView  alloc] initWithTitle:@"信息上传成功" message:@"请耐心等待审核" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            
            NSLog(@"%@",error);
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            [[[UIAlertView  alloc] initWithTitle:@"上传信息失败" message:@"请检查网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
        }];
        
        [manager.operationQueue addOperation:opration];
    
}


- (void)addRightBtn{
//    UIButton *exampleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
//    [exampleBtn setTitle:@"示例" forState:UIControlStateNormal];
//    exampleBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
//    [exampleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [exampleBtn addTarget:self action:@selector(presentExample) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *exampleItem = [[UIBarButtonItem alloc]initWithCustomView:exampleBtn];
//    self.navigationItem.rightBarButtonItem = exampleItem;
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"示例" style:UIBarButtonItemStyleDone target:self action:@selector(presentExample)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
}
- (void)presentExample{
    [self performSegueWithIdentifier:@"picture2example" sender:nil];
}

//添加返回按钮
- (void)addBackBtn{
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"箭头（白）左.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backward) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}
- (void)backward{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"picture2confirm"]) {
        self.userInfo.mainImage = [self.mainPicture backgroundImageForState:UIControlStateNormal];
        self.userInfo.frontImage = [self.frontPicture backgroundImageForState:UIControlStateNormal];
        self.userInfo.backImage = [self.backPicture backgroundImageForState:UIControlStateNormal];
        confirmController *confirmController = segue.destinationViewController;
        confirmController.userInfo = self.userInfo;
    }
    
}
#pragma -mark actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        //imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
        
    }
}
#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    
    [self.currentBtn setImage:nil forState:UIControlStateNormal];
    [self.currentBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter]postNotification:[[NSNotification alloc]initWithName:@"pictureAddedNotification" object:self.currentBtn userInfo:nil]];
    
    self.currentBtn.tag = 100;
    
}
@end
