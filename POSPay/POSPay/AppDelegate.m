//
//  AppDelegate.m
//  POSPay
//
//  Created by mq on 15/1/2.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "AppDelegate.h"
#import <MESDK/NLAudioPortV100ConnParams.h>
#import <MESDK/NLDeviceLaunchEvent.h>
#import <MESDK/MESDK.h>
@interface AppDelegate()<NLDeviceEventListener>
@property (nonatomic, strong) id<NLLCD> lcd;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    

    self.driver = [[NLMESeriesDriver alloc] init];
    
    // Override point for customization after application launch.
    return YES;
}


- (void)initalizedDriverWithBleName:(NSString*)name
{
    //    NSDictionary* bleMap = [NLBluetoothHelper syncScanWithDuration:2];
    NSDictionary* bleMap = [NLBluetoothHelper devices];
    NSLog(@"devices %@", bleMap);
    NSLog(@"is has device connected %d", [NLBluetoothHelper isConnected]);
    
    // 蓝牙连接参数
    id<NLDeviceConnParams> params = [[NLBlueToothV100ConnParams alloc] initWithUuid:[bleMap objectForKey:name]];
    // 请求连接并获取ME30终端设备
    NSError *err; // 驱动连接设备错误指针
    // 驱动连接ME30获取设备对象信息
    self.device = [self.driver connectWithConnParams:params closedListener:self error:&err];
    if (err || !self.device) { // 获取失败
        NSLog(@"device error %@", err);
        if ([self.viewController respondsToSelector:@selector(addText:)]) {
            [self.viewController performSelector:@selector(addText:) withObject:[NSString stringWithFormat:@"device error %@", err]];
        }
        [(UINavigationController*)self.window.rootViewController topViewController].title = @"device connected failed";
        [[[UIAlertView alloc] initWithTitle:@"连接失败" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        return ;
    }
    [(UINavigationController*)self.window.rootViewController topViewController].title = @"device is connected!!!";
    if ([self.viewController respondsToSelector:@selector(addText:)]) {
        [self.viewController performSelector:@selector(addText:) withObject:@"device is connected!!!"];
    }
    NSLog(@"Bluetooth device instance %@", self.device);
}

- (void)initializedDriver
{
    // 使用模块前，判断设备对象是否处于活跃状态（即正常连接工作模式）
    if (![self.device isAlive]) {
        NSLog(@"not alive");
        return ;
    }
    
    // 从设备对象加载具体某个模块（如标准LCD模块）
    self.lcd = (id<NLLCD>)[self.device standardModuleWithModuleType:NLModuleTypeCommonLCD];
    
    // 此处开始使用具体某个模块内提供的api，模块将输出具体功能
    [self.lcd clearScreen]; // 测试清屏
}

- (void)initializeAudioDriver
{
    // 音频连接参数
    id<NLDeviceConnParams> params = [[NLAudioPortV100ConnParams alloc] init];
    // 请求连接并获取ME30终端设备
    NSError *err = nil; // 驱动连接设备错误指针
    // 驱动连接ME30获取设备对象信息
    self.device = [self.driver connectWithConnParams:params closedListener:self launchListener:self error:&err];
    if (err || !self.device) { // 获取失败
        NSLog(@"device error %@", err);
        if ([self.viewController respondsToSelector:@selector(addText:)]) {
            [self.viewController performSelector:@selector(addText:) withObject:[NSString stringWithFormat:@"device error %@", err]];
        }
        [(UINavigationController*)self.window.rootViewController topViewController].title = @"device connected failed";
        [[[UIAlertView alloc] initWithTitle:@"连接失败" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        return ;
    }
    [(UINavigationController*)self.window.rootViewController topViewController].title = @"device is connected!!!";
    if ([self.viewController respondsToSelector:@selector(addText:)]) {
        [self.viewController performSelector:@selector(addText:) withObject:@"device is connected!!!"];
    }
    NSLog(@"Audio device instance %@", self.device);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)onEvent:(id <NLDeviceEvent>)event
{
    NSLog(@"onEvent : %@", event);
    // TODO判别事件类型并做相应处理
    if ([event isKindOfClass:[NLConnectionCloseEvent class]]) {
        [(UINavigationController*)self.window.rootViewController topViewController].title = @"device is disconnected!!!";
        if ([self.viewController respondsToSelector:@selector(addText:)]) {
            [self.viewController performSelector:@selector(addText:) withObject:@"device is disconnected!!!"];
        }
    } else if ([event isKindOfClass:[NLDeviceLaunchEvent class]]) {
        NLDeviceLaunchEvent *launchEvent = (NLDeviceLaunchEvent*)event;
        if ([launchEvent isSuccess]) {
            // 0xA5 + Len(2B) + 0x3A + 固件版本号(1B) + ksn + CRC(1B) + 0x5A
            NSData *data = [launchEvent userInfo][NLDeviceLaunchDataInfo];
            if (data.length > 7) {
                NSLog(@"KSN : %@", [NLISOUtils hexStringWithData:[data subdataWithRange:NSMakeRange(5, data.length - 7)]]);
            }
        }
    }
}

@end
