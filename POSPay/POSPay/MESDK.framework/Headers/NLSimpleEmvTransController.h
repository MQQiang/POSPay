//
//  NLSimpleEmvTransController.h
//  MTypeSDK
//
//  Created by su on 14-2-6.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import "NLEmvTransController.h"
#import "NLEmvControllerListener.h"
#import "NLEmvTransStep.h"
#import "NLDevice.h"

@interface NLSimpleEmvTransController : NSObject<NLEmvTransController>
- (id)initWithDevice:(id<NLDevice>)owner listener:(id<NLEmvControllerListener>)listener;
- (id)initWithDevice:(id<NLDevice>)owner listener:(id<NLEmvControllerListener>)listener expectedSteps:(NSArray*)expectedSteps;
@end
