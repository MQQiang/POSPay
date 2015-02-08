//
//  BaseTest.h
//  MTypeSDK
//
//  Created by su on 14/6/18.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "NLDump.h"

#define CString(s, ... ) [NSString stringWithFormat:s, ##__VA_ARGS__]
#define NSLogObj(obj) NSLog(@"%@", obj);
#define NLKeyIndexConst_KSN_INITKEY_INDEX 1


static long SET_TIMEOUT = (long) (30 * 1000);// 预设超时时间(毫秒)
const int KeyIndex = 87;

@protocol TestContainer <NSObject>
- (void)loadTest;
@end

@interface BaseTest : NSObject<TestContainer>
@property (nonatomic, strong) id<NLDevice> device;
@property (nonatomic, strong) id<NLDeviceDriver> driver;
@property (nonatomic, assign) UIViewController *controller;
- (void)setTitle:(NSString*)title;
- (AppDelegate*)app;
- (void)showMsgOnMainThread:(NSString*)string;
#pragma mark - helpers
- (id<NLDeviceEvent>)eventFilter:(NLAbstractProcessDeviceEvent<NLDeviceEvent>*)event exCode:(int)defaultExCode;
@end
