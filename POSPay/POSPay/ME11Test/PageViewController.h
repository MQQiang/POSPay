//
//  PageViewController.h
//  MESDKTest
//
//  Created by wanglx on 14-7-1.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageViewController : UIViewController
@property (assign, nonatomic) IBOutlet UITextView *textView;
- (IBAction)disConnect:(id)sender;
- (IBAction)scan:(id)sender;
- (IBAction)onClick:(id)sender;
- (IBAction)clear:(id)sender;
- (IBAction)connect:(id)sender;
@end
