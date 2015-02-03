//
//  AppDelegate.h
//  POSPay
//
//  Created by mq on 15/1/2.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MESDK/MESDK.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) id<NLDeviceDriver> driver;
@property (strong, nonatomic) id<NLDevice> device;
- (void)initalizedDriverWithBleName:(NSString*)name;


@end

