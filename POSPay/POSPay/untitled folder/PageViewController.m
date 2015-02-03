//
//  PageViewController.m
//  MESDKTest
//
//  Created by wanglx on 14-7-1.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import "PageViewController.h"
#import "AppDelegate.h"
//#import "NLDump.h"
#import <MESDK/MESDK.h>
//#import "PBOCTest.h"
//#import "CalcMacTest.h"
//#import "ConsumeTest.h"
//#import "PrintTest.h"
//#import "ME11Test.h"
#define TITLES_KEYBOARD [NSMutableArray arrayWithObjects:@"立刻从键盘缓冲区读取首个键值（NO）",@"限定时间内读取键值",@"键盘模式的输入流（NO）",@"开启一个标准金额读取流程(AMT)（NO）",@"开启一个标准字符串读取流程（Wait）",@"开启一个标准数字读取流程（NO）",@"撤销键盘输入（NO）",nil]
#define TITLES_LCD [NSMutableArray arrayWithObjects:@"液晶屏清屏",@"设置显示模式(NORMAL)",@"设置显示模式(REVARSAL)",@"设置光标位置（NO）",@"获得光标位置（NO）",@"获得液晶属性（NO）",@"画出给定图像",@"手动刷新屏幕（NO）",@"启动背光",@"关闭背光",@"获得字体大小",@"设置字体颜色（NO）",@"从当前光标处输出字符串",@"回显命令压力测试", @"停止回显命令测试", nil]
#define TITLES_PIN [NSMutableArray arrayWithObjects:@"开启一个Pin输入过程",@"撤销密码输入",@"加密一串数据",@"解密一串数据",@"计算Mac",@"装载一个工作密钥",nil]
#define TITLES_SECURITY [NSMutableArray arrayWithObjects:@"获得设备信息",@"获得一个线路保护的随机数",@"设备认证",@"服务端认证",@"在线更新密钥接口",@"在线更新设备信息",@"联机更新磁道公钥",nil]
#define TITLES_TLV [NSMutableArray arrayWithObjects:@"设置终端参数",@"获取终端参数",nil]
#import <CoreBluetooth/CoreBluetooth.h>
@interface PageViewController ()<UIActionSheetDelegate,NLDeviceEventListener>
@property (nonatomic, strong) UIActionSheet *deviceSelectorSheet;
@property (nonatomic, strong) UIActionSheet *operationSelectorSheet;
@property (nonatomic, strong) UIActionSheet *secondSelectorSheet;
@property (nonatomic, strong) NSArray * devicesArray;
@property (nonatomic, strong) NSString * curDeviceTermID;
@property (nonatomic, strong) NSString *uuid;
@end

@implementation PageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    self.title = [NSString stringWithFormat:@"[%@]", app.driver];
    _operationSelectorSheet = [[UIActionSheet alloc] initWithTitle:@"操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"read keyboard",@"LCD",@"Set Date",@"Get Date",@"Open Swiper", @"swiper-read-des", @"Close Swiper",  @"CardReader check", @"CardReader open", @"CardReader communicate", @"CardReader close", @"Pininput",@"DeviceInfo", @"randomnumer", @"loadmasterkey", @"loadworkingkey-pin", @"loadworkingkey-trace", @"input string", @"input number", @"input amount", @"calc mac",@"consume",@"打印图片", @"打印文字", @"cancelCurrentCmd", @"startPBOCTransfer", @"updateApp", @"设置终端属性", @"增加应用标识", @"删除应用标识", @"增加公钥", @"删除公钥", @"ME11设备信息", @"ME11读卡", nil];
    _devicesArray = [NSArray array];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addText:(NSString *)string
{
    dispatch_async(dispatch_get_main_queue(),^{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSMutableString * text = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@\n%@",[dateFormatter stringFromDate:[NSDate date]],string]];
        [text appendString:@"\n--------------------------------------------\n"];
        [text appendString:_textView.text];
        _textView.text = text;
    });
}

- (IBAction)scan:(id)sender {
    [NLBluetoothHelper startScan];
}
- (IBAction)clear:(id)sender {
    _textView.text = @"";
}

- (IBAction)onClick:(id)sender {
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (![app.device isAlive]) {
        [[[UIAlertView alloc] initWithTitle:@"提醒" message:@"设备未连接，请选择并连接！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        return ;
    }
    [self.operationSelectorSheet showInView:self.view];
}
- (IBAction)connect:(id)sender {
    self.deviceSelectorSheet = [[UIActionSheet alloc] initWithTitle:@"选择连接设备" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    NSArray *deviceNames = [[NLBluetoothHelper devices] allKeys];
    for (NSString *name in deviceNames) {
        [self.deviceSelectorSheet addButtonWithTitle:name];
    }
    [self.deviceSelectorSheet addButtonWithTitle:@"音频"];
    [self.deviceSelectorSheet addButtonWithTitle:@"取消"];
    [self.deviceSelectorSheet showInView:self.view];
}

//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (actionSheet == self.deviceSelectorSheet) {
//        NSString *deviceName = [actionSheet buttonTitleAtIndex:buttonIndex];
//        AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//        [app.device destroy];
//        if ([@"音频" isEqual:deviceName]) {
//            [NSThread detachNewThreadSelector:@selector(initializeAudioDriver) toTarget:app withObject:nil];
//            return ;
//        }
//        [NSThread detachNewThreadSelector:@selector(initalizedDriverWithBleName:) toTarget:app withObject:deviceName];
//        return ;
//    } else if (actionSheet == _operationSelectorSheet){
//        if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"取消"]) {
//            return;
//        }
//        AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//        if (![app.device isAlive]) {
//            [[[UIAlertView alloc] initWithTitle:@"提醒" message:@"设备未连接，请选择并连接！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
//            return ;
//        }
//        id<NLKeyBoard> keyboard = (id<NLKeyBoard>)[app.device standardModuleWithModuleType:NLModuleTypeCommonKeyboard];
//        id<NLLCD> lcd = (id<NLLCD>)[app.device standardModuleWithModuleType:NLModuleTypeCommonLCD];
//        id<NLSwiper> swiper = (id<NLSwiper>)[app.device standardModuleWithModuleType:NLModuleTypeCommonSwiper];
//        id<NLSecurityModule> security = (id<NLSecurityModule>)[app.device standardModuleWithModuleType:NLModuleTypeCommonSecurity];
//        id<NLCardReader> reader = (id<NLCardReader>)[app.device standardModuleWithModuleType:NLModuleTypeCommonCardReader];
//        id<NLPinInput> pin = (id<NLPinInput>)[app.device standardModuleWithModuleType:NLModuleTypeCommonPinInput];
//        PBOCTest *pbocTest = [PBOCTest new];
//        ME11Test *me11Test = [ME11Test new];
//        
//        NSString *rowTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
//        NSError *err = nil;
//        NSString * show = nil;
//        self.title = rowTitle;
//        if ([@"read keyboard" isEqual:rowTitle]) { // read keyboard
//            [lcd clearScreen];
//            [lcd drawWithWords:@"keyboard reading ..." showtime:2];//显示2秒
//            //限定时间内读取键值
//            int num = [keyboard readWithTimeout:5*60*1000] - 0x30;
//            [self addText:[NSString stringWithFormat:@"read a num : %d", num]];
//            [lcd clearScreen];
//            [lcd drawWithWords:[NSString stringWithFormat:@"you input a num : %d", num] showtime:2];
//        } else if ([@"Set Date" isEqual:rowTitle]) { // set date
//            NSDate *date = [NSDate date];
//            [lcd clearScreen];
//            [lcd drawWithWords:@"date setting ..." showtime:2];
//            [app.device setDeviceDate:date];
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//            [lcd clearScreen];
//            NSString * show = [NSString stringWithFormat:@"date setted: %@", [formatter stringFromDate:date]];
//            [lcd drawWithWords:show showtime:3];
//            [self addText:show];
//        } else if ([@"Get Date" isEqual:rowTitle]) { // get date
//            [lcd clearScreen];
//            [lcd drawWithWords:@"getting date ..." showtime:5];
//            NSDate *date = [app.device deviceDate];
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//            [lcd clearScreen];
//            show = [NSString stringWithFormat:@"current time: %@", [formatter stringFromDate:date]];
//            [lcd drawWithWords:show showtime:3];
//            [self addText:show];
//        } else if ([@"Open Swiper" isEqual:rowTitle]) { // swiper open
//            // 清屏
//            [lcd clearScreen];
//            [lcd drawWithWords:@"please swipe: "];
//            BOOL b = [swiper checkOpenSwiperWithTimeout:200];
//            [lcd clearScreen];
//            if (b) {
//                show = @"swipe success. you can get account info now!";
//                [lcd drawWithWords:show showtime:5];
//                [self addText:show];
//            } else {
//                show = @"swipe fail!";
//                [lcd drawWithWords:show showtime:5];
//                [self addText:show];
//            };
//        } else if ([@"swiper-read-des" isEqual:rowTitle]) {
//            [lcd clearScreen];
//            [lcd drawWithWords:@"swiper des mag reading ..." showtime:1];
//            NLWorkingKey *wk = [[NLWorkingKey alloc] initWithIndex:1];
//            NLSwipeResult * rslt = [swiper readSimposResultWithReadModel:@[@(NLSwiperReadModelReadSecondTrack), @(NLSwiperReadModelReadThirdTrack)] trackSecurityPaddingType:NLTrackSecurityPaddingTypeNone wk:wk seed:nil flowId:nil encryptAlgorithm:[NLTrackEncryptAlgorithm BY_DUKPT_MODEL]];
//            [lcd clearScreen];
//            if (rslt) {
//                show = [NSString stringWithFormat:@"swiper des mag read success, cardnum is %@", [rslt account].acctId];
//                [lcd drawWithWords:show showtime:5];
//                [self addText:show];
//            } else {
//                show = @"swiper des mag read failed!";
//                [lcd drawWithWords:show showtime:5];
//                [self addText:show];
//                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"swiper read des failed" message:@"if you don't open swiper , please open it, esle please close swiper and try open swiper then do it again!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//                [alert show];
//            }
//        } else if ([@"Close Swiper" isEqual:rowTitle]) { // swiper close
//            [lcd clearScreen];
//            [lcd drawWithWords:@"swiper closing ... " showtime:2];
//            [swiper closeSwiper];
//            [lcd clearScreen];
//            show = @"swiper closed.";
//            [lcd drawWithWords:show showtime:5];
//            [self addText:show];
//        } else if ([@"CardReader check" isEqual:rowTitle]) { // cardreader check
//            [lcd clearScreen];
//            [lcd drawWithWords:@"checking ic card is existed ... " showtime:5];
//            BOOL isExist = [reader checkCardReader];
//            show = [NSString stringWithFormat:@"ic card is %@existed.", isExist ? @"" : @"not "];
//            [lcd clearScreen];
//            [lcd drawWithWords:show showtime:5];
//            [self addText:show];
//        } else if ([@"CardReader open" isEqual:rowTitle]) { // cardreader open
//            // supported module
//            [reader openCardReaderWithCardReaderModuleTypes:@[@(NLModuleTypeCommonICCard)] timeout:200 listener:self];
//        } else if ([@"CardReader communicate" isEqual:rowTitle]) { // cardreader communicate
//            [reader performSelector:@selector(communicateCardReaderWithHexCmd:) withObject:@"0084000008"]; //
//            [self addText:@"communicateCardReaderWithHexCmd:0084000008"];
//        }
//        else if ([@"CardReader close" isEqual:rowTitle]) { // cardreader close
//            [lcd clearScreen];
//            [lcd drawWithWords:@"card reader closeing ... " showtime:5];
//            [reader closeCardReader];
//            [lcd clearScreen];
//            show = @"card reader closed.";
//            [lcd drawWithWords:show showtime:5];
//            [self addText:show];
//        } else if ([@"Pininput" isEqual:rowTitle]) { // pin input
//            
//            [pin startPinInputWithWorkingKey:[[NLWorkingKey alloc] initWithIndex:0x02 wk:[NLISOUtils hexStr2Data:@"00000000000000000000000000000000"]] pinManageType:NLPinManageTypeMKSK acctInputType:NLAccountInputTypeUserAccount acctSymbol:@"1111111111111111111111111111111111111111" inputMaxLen:0x0C pinPadding:[NLISOUtils hexStr2Data:@""] isEnterEnabled:YES displayContent:@"" timeout:80 inputListener:self];
//        } else if ([@"DeviceInfo" isEqual:rowTitle]){ // deviceinfo
//            id<NLDeviceInfo> info = [app.device deviceInfo];
//            [self addText:CString(@"deviceType: %d isSupportPrint : %d", [info PID], [info isSupportPrint])];
//        } else if ([@"randomnumer" isEqual:rowTitle]) { // randomnumber
//            [self addText:[NLDump hexDumpWithData:[security securityRandom]]];
//        } else if ([@"loadmasterkey" isEqual:rowTitle]) { // load master key
//            [pin loadMasterKeyWithKEKKeyIndex:0x01 masterKeyIndex:0x01 data:[NLISOUtils
//                                                                             hexStr2Data:[@"3D D9 D3 4B A2 AE ED B4 3D D9 D3 4B A2 AE ED B4" stringByReplacingOccurrencesOfString:@" " withString:@""]] error:&err];
//            [self addText:(err ? [err description] : @"load master key ok!!!")];
//        } else if ([@"loadworkingkey-pin" isEqual:rowTitle]) { // load working key for pin
//            
//            [pin loadWorkingKeyWithWorkingKeyType:NLWorkingKeyTypePinInput mainKeyIndex:0x01 workingKeyIndex:0x02 data:[NLISOUtils hexStr2Data:[@"50 B0 38 B6 9D BC 6A B7 50 B0 38 B6 9D BC 6A B7" stringByReplacingOccurrencesOfString:@" " withString:@""]] error:&err];
//            NSLog(@"%@", err);
//            [self addText:(err ? [err description] : @"load pin working key ok!!!")];
//        } else if ([@"loadworkingkey-trace" isEqual:rowTitle]) { // load working key for trace
//            
//            [pin loadWorkingKeyWithWorkingKeyType:NLWorkingKeyTypeDataEncrypt mainKeyIndex:0x01 workingKeyIndex:0x01 data:[NLISOUtils hexStr2Data:[@"07 90 BC A4 34 65 CE 06 07 90 BC A4 34 65 CE 06" stringByReplacingOccurrencesOfString:@" " withString:@""]] error:&err];
//            NSLog(@"%@", err);
//            [self addText:(err ? [err description] : @"load trace working key ok!!!")];
//        } else if ([@"loadworkingkey-mac" isEqual:rowTitle]) { // load working key for mac
//            
//            [pin loadWorkingKeyWithWorkingKeyType:NLWorkingKeyTypeMAC mainKeyIndex:0x01 workingKeyIndex:0x03 data:[NLISOUtils hexStr2Data:[@"76 77 50 EA 3A 01 27 18 53 03 09 F9 84 3B D2 05" stringByReplacingOccurrencesOfString:@" " withString:@""]] error:&err];
//            NSLog(@"%@", err);
//            [self addText:(err ? [err description] : @"load mac working key ok!!!")];
//        } else if ([@"input string" isEqual:rowTitle]) {
//            //开启一个标准字符串读取流程
//            [keyboard readStringWithDispType:NLDispTypeNoraml title:@"读字符串(标题)" content:@"字符串是什么" minLength:1 maxLength:200 timeout:60 listener:self];
//        } else if ([@"input number" isEqual:rowTitle]) {
//            //开启一个标准数字读取流程
//            [keyboard readNumberWithDispType:NLDispTypeNoraml title:@"读取数字(标题)" content:@"数字是什么" minLength:1 maxLength:20 timeout:30 listener:self];
//        } else if ([@"input amount" isEqual:rowTitle]) {
//            //开启一个标准金额读取流程(AMT)
//            [keyboard readAmtWithDispType:NLDispTypeRevarsal title:@"读金额(标题)" content:@"金额是什么" minLength:1 maxLength:18 timeout:5*60*1000 listener:self];
//        } else if ([@"calc mac" isEqual:rowTitle]) {
//            // 计算mac
//            CalcMacTest *test = [CalcMacTest new];
//            //        [test calcMac4Common];
//            [test calcMac4YiLian];
//        }else if([@"consume" isEqual:rowTitle]){
//            //消费
//            ConsumeTest *test = [ConsumeTest new];
//            [NSThread detachNewThreadSelector:@selector(consume) toTarget:test withObject:nil];
//        }else if([@"打印图片" isEqual:rowTitle]){
//            //打印
//            PrintTest *test = [PrintTest new];
//            [NSThread detachNewThreadSelector:@selector(printImage) toTarget:test withObject:nil];
//        }else if([@"打印文字" isEqual:rowTitle]){
//            //打印
//            PrintTest *test = [PrintTest new];
//            [NSThread detachNewThreadSelector:@selector(printText) toTarget:test withObject:nil];
//        }else if ([@"cancelCurrentCmd" isEqual:rowTitle]) {
//            //取消当前命令
//            //        [NSThread detachNewThreadSelector:@selector(cancelCurrentExecute) toTarget:app.device withObject:nil];
//            [app.device cancelCurrentExecute];
//            //        self.isUserCancelPin = YES;
//            //        [NSThread detachNewThreadSelector:@selector(consume) toTarget:self withObject:nil];
//        } else if ([@"startPBOCTransfer" isEqual:rowTitle]) {
//                    [NSThread detachNewThreadSelector:@selector(startTransfer) toTarget:pbocTest withObject:nil];
//        } else if ([@"updateApp" isEqual:rowTitle]) {
//            err = nil;
//            NSString *path = [[NSBundle mainBundle] pathForResource:@"mapp_99Bill_ME31" ofType:@"NLD"];
//            NSInputStream *is = [NSInputStream inputStreamWithFileAtPath:path];
//            //        [app.device updateAppWithInputStream:is error:&err];
//            NSNumber *contentLength = (NSNumber *) [[[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil] objectForKey:NSFileSize];
//            int fileSize = [contentLength intValue];
//            [app.device updateAppWithInputStream:is fileSize:fileSize isForce:NO block:^(int fileIndex, BOOL isFinish, NSError *err) {
//                if (isFinish) {
//                    [self addText:@"updateApp successed!"];
//                } else {
//                    if (err) {
//                        [self addText:[NSString stringWithFormat:@"updateApp err:%@",err]];
//                    } else {
//                        [self addText:[NSString stringWithFormat:@"update progress %d%@",(int)(((double)fileIndex)/fileSize*100),@"%"]];
//                    }
//                }
//            }];
//            
//            
//        }
//        else if ([rowTitle isEqual:@"设置终端属性"]) {
//            [pbocTest testEmv:rowTitle];
//        } else if ([rowTitle isEqual:@"增加应用标识"]) {
//            [pbocTest testEmv:rowTitle];
//        } else if ([rowTitle isEqual:@"删除应用标识"]) {
//            [pbocTest testEmv:rowTitle];
//        } else if ([rowTitle isEqual:@"增加公钥"]) {
//            [pbocTest testEmv:rowTitle];
//        } else if ([rowTitle isEqual:@"删除公钥"]) {
//            [pbocTest testEmv:rowTitle];
//        } else if ([rowTitle isEqualToString:@"LCD"]) {
//            _secondSelectorSheet = [[UIActionSheet alloc]initWithTitle:rowTitle delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
//            for (NSString *name in TITLES_LCD) {
//                [_secondSelectorSheet addButtonWithTitle:name];
//            }
//            [_secondSelectorSheet addButtonWithTitle:@"取消"];
//            [_secondSelectorSheet showInView:self.view];
//        } else if ([rowTitle isEqualToString:@"ME11设备信息"]) {
//            [me11Test deviceInfo];
//        } else if ([rowTitle isEqualToString:@"ME11读卡"]) {
//            [NSThread detachNewThreadSelector:@selector(startReadCard) toTarget:me11Test withObject:nil];
//        }
//    } else {
//        if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"取消"]) {
//            return;
//        }
//        if ([actionSheet.title isEqualToString:@"LCD"]) {
//            [self LCD:[actionSheet buttonTitleAtIndex:buttonIndex]];
//        }
//    }
//    
//}
- (void)LCD:(NSString *)title
{
    static BOOL echoAble = NO;
    static long long count = 0;
    echoAble = NO;
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (![app.device isAlive]) {
        [[[UIAlertView alloc] initWithTitle:@"提醒" message:@"设备未连接，请选择并连接！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        return ;
    }
    id<NLLCD> lcd = (id<NLLCD>)[app.device standardModuleWithModuleType:NLModuleTypeCommonLCD];
    self.title = title;
    int index = [TITLES_LCD indexOfObject:title];
    switch (index) {
        case 0:
        {
            // 液晶清屏
            [NSThread detachNewThreadSelector:@selector(clearScreen) toTarget:lcd withObject:nil];
            [self addText:@"Clean screen"];
            
            break;
        }
        case 1:
        {
            
            // 设置显示模式
            [lcd setDisplayType:NLDispTypeNoraml];
            [self addText:@"set screen noraml display"];
            break;
        }
        case 2:
        {
            // 设置显示模式为反选
            [lcd setDisplayType:NLDispTypeRevarsal];
            
            break;
        }
        case 3:
        {
            // 设置光标位置
            break;
        }
        case 4:
        {
            // 获得光标位置
            [lcd cursorPosition];
            
            break;
        }
        case 5:
        {
            // 获得液晶属性
            [lcd LCDClass];
            
            break;
        }
        case 6:
        {
            // 画出给定图像
            const uint8_t tit_cmd[] = {
                0x10,0x11,0xF2,0x40,0x44,0xFF,0x44,0x44,0xFF,0x44,0x40,0x00,
                0x00,0x00,0x01,0x81,0x72,0x0C,0x70,0x80,0x00,0x00,0x00,0x00,
                0x10,0xD0,0x48,0x54,0xD2,0x11,0xD2,0x54,0x48,0xD0,0x10,0x00,
                0x10,0x50,0x48,0x44,0x52,0x61,0x42,0x44,0xC8,0x10,0x10,0x00,
                0x88,0x68,0xFF,0x48,0x02,0xFA,0xAF,0xAA,0xAF,0xFA,0x02,0x00,
                0x08,0x48,0x48,0xC8,0x48,0x48,0x08,0xFF,0x08,0x09,0x0A,0x00,
                
                0x08,0x04,0x03,0x04,0x0A,0x09,0x08,0x08,0x0B,0x08,0x08,0x00,
                0x08,0x04,0x02,0x01,0x00,0x00,0x00,0x01,0x02,0x04,0x08,0x00,
                0x00,0x07,0x02,0x02,0x07,0x00,0x0F,0x00,0x04,0x07,0x00,0x00,
                0x00,0x00,0x02,0x02,0x04,0x04,0x0A,0x09,0x00,0x00,0x00,0x00,
                0x00,0x00,0x0F,0x00,0x0A,0x0A,0x06,0x03,0x06,0x0A,0x0A,0x00,
                0x08,0x08,0x08,0x07,0x04,0x04,0x04,0x00,0x03,0x04,0x0E,0x00,
            };
            UIImage *img = [UIImage imageWithData:[NSData dataWithBytes:tit_cmd length:12*12]];
            [lcd drawWithPicture:[[NLPicBitmap alloc] initWithStartPoint:[[NLPoint alloc] initWithX:10 y:4] width:72 height:12 bitmap:img/*[UIImage imageNamed:@"Default.png"]*/]];
            break;
        }
        case 7:
        {
            // 手动刷新屏幕
            [lcd flush];
            break;
        }
        case 8:
        {
            // 启动背光
            [lcd enableBackgroundLight];
            [self addText:@"Enable BackgroundLight"];
            break;
        }
        case 9:
        {
            // 关闭背光
            [lcd disableBackgroundLight];
            [self addText: @"Enable BackgroundLight"];
            break;
        }
        case 10:
        {
            // 获得字体大小
            NLFontSize *fontSize = [lcd fontSize];
            [self addText:[NSString stringWithFormat:@"fontsize(%d,%d,%d,%d)",fontSize.chineseCharWidth,fontSize.chineseCharHeight,fontSize.charWidth,fontSize.charHeight]];
            
            break;
        }
        case 11:
        {
            // 设置字体颜色
            //[lcd setNormalWordsColor:[NLColor colorWithValue:134]];
            break;
        }
        case 12:
        {
            // 从当前光标处输出字符串
            [lcd drawWithWords:@"12345678678helloworld!"];
            break;
        }
        case 13: // 回显压力测试
        {
            echoAble = YES;
            count = 0;
            self.title = @"echoing...";
            while (echoAble && [lcd performSelector:@selector(echo:) withObject:[@"helloworld" dataUsingEncoding:NSASCIIStringEncoding]]) {
                count++;
            }
            if (echoAble) {
                self.title = [NSString stringWithFormat:@"echo error at loop %llu", count];
            } else {
                self.title = [NSString stringWithFormat:@"echo is ok all loops: %llu", count];
            }
        }
            
            break ;
        case 14: // 停止回显压力测试
        {
            echoAble = NO;
            self.title = [NSString stringWithFormat:@"echo is stop at loop: %llu", count];
        }
            break ;
        default:
            break;
    }
}
- (IBAction)disConnect:(id)sender {
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (![app.device isAlive]) {
        [[[UIAlertView alloc] initWithTitle:@"提醒" message:@"设备未连接，请选择并连接！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        return ;
    }
    self.title = @"disconnect";
    [app.device destroy];
}
#pragma mark delegate
//设备检查的结果
- (void)onEvent:(id <NLDeviceEvent>)event
{
    NSLog(@"on event %@", event);
    if ([event isKindOfClass:[NLPinInputFinishedEvent class]]) {
        NLPinInputFinishedEvent *pinEvent = (NLPinInputFinishedEvent*)event;
        self.title = @"pin input finished";
        [self addText:[NSString stringWithFormat:@"pin input cancel:%d len:%d encrypPin:%@ ksn:%@", pinEvent.isUserCanceled, pinEvent.inputLen, pinEvent.encrypPin, pinEvent.ksn]];
    }
    if ([event isKindOfClass:[NLOpenCardReaderEvent class]]) {
        NLOpenCardReaderEvent *readerEvent = (NLOpenCardReaderEvent*)event;
        [self addText:[NSString stringWithFormat:@"open card reader %@", [readerEvent openedCardReaders]]];
    }
    if ([event isKindOfClass:[NLKeyBoardInputStringEvent class]]) {
        NLKeyBoardInputStringEvent *inputEvent = event;
        [self addText:[NSString stringWithFormat:@"read input string %@", [inputEvent string]]];
        return ;
    }
    if ([event isKindOfClass:[NLKeyBoardInputNumberEvent class]]) {
        NLKeyBoardInputNumberEvent *inputEvent = event;
        [self addText:[NSString stringWithFormat:@"read input number %@", [inputEvent number]]];
        return ;
    }
    if ([event isKindOfClass:[NLKeyBoardInputAmountDecimalEvent class]]) {
        NLKeyBoardInputAmountDecimalEvent *inputEvent = event;
        [self addText:[NSString stringWithFormat:@"read input amount %@", [inputEvent amount]]];
        return ;
    }
}
@end
