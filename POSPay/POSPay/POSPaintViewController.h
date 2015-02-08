//
//  POSPaintViewController.h
//  POSPay
//
//  Created by mq on 15/2/9.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaintingView.h"
#import "PaintingWindow.h"
@interface POSPaintViewController : UIViewController{
//    PaintingWindow		*window;
//    PaintingView		*drawingView;
    CFTimeInterval		lastTime;
}

@property (nonatomic, retain) IBOutlet PaintingView *drawingView;

@end
