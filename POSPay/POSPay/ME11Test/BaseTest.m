//
//  BaseTest.m
//  MTypeSDK
//
//  Created by su on 14/6/18.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import "BaseTest.h"

@implementation BaseTest
- (id)init
{
    if ((self = [super init])) {
        [self loadTest];
    }
    return self;
}
- (void)loadTest
{
    self.controller = [self app].viewController;
}
- (AppDelegate*)app
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}
- (id<NLDeviceDriver>)driver
{
    return self.app.driver;
}
- (id<NLDevice>)device
{
    return self.app.device;
}
- (void)showMsgOnMainThread:(NSString*)string
{
    if ([self.controller respondsToSelector:@selector(addText:)]) {
        [self.controller performSelector:@selector(addText:) withObject:string];
    }
}
- (void)setTitle:(NSString*)title {
    if (self.controller) {
        [self.controller performSelector:@selector(addText:) withObject:title];
    }
}
//- (void)onEvent:(id <NLDeviceEvent>)event
//{
//    if ([self.controller respondsToSelector:@selector(onEvent:)]) {
//        [self.controller performSelector:@selector(onEvent:) withObject:event];
//    }
//}
#pragma mark - helpers
- (id<NLDeviceEvent>)eventFilter:(NLAbstractProcessDeviceEvent<NLDeviceEvent>*)event exCode:(int)defaultExCode
{
    if (event.isSuccess || event.isUserCanceled) {
        return event;
    }
    if (event.error) {
        return nil;
    }
    return nil;
}
@end
