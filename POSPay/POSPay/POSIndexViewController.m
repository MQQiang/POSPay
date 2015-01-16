//
//  FirstViewController.m
//  POSPay
//
//  Created by mq on 15/1/2.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "POSIndexViewController.h"
#import "appCell.h"

@interface POSIndexViewController ()<UIScrollViewDelegate>
//图片轮播器
@property (weak, nonatomic) IBOutlet UIScrollView *adView;
//应用格子
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation POSIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAdView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    
    CGRect rect = CGRectMake(_tabBar.frame.origin.x, _tabBar.frame.origin.y+5.0f, _tabBar.frame.size.width, 40);
    
    [_tabBar setFrame:rect];
    [self.view bringSubviewToFront:_tabBar];
}

#pragma 广告轮播器
    
- (void)addAdView
{
    int pictureNum = 3;
    for (int i = 0; i<pictureNum;i++ ) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"ad_00"];
        imageView.backgroundColor = [UIColor blackColor];
        CGFloat scrollViewW = self.adView.frame.size.width;
        CGFloat scrollViewH = self.adView.frame.size.height;
        CGFloat imageW = scrollViewW;
        CGFloat imageH = scrollViewH;
        CGFloat imageX = i*imageW;
        CGFloat imageY = 0;
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        self.adView.contentSize = CGSizeMake(pictureNum*imageW, 0);
        self.adView.showsHorizontalScrollIndicator = NO;
        self.adView.pagingEnabled = YES;
        self.adView.delegate = self;
        
        [self.adView addSubview:imageView];
    }
    [self addTimer];
    
    
    

}
- (void)addTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)deleteTimer
{
    [_timer invalidate];
    _timer = nil;
}
- (void)nextImage{
    // 默认的三张图片轮播
    CGFloat x = self.adView.contentOffset.x;
    x+=320;
    if (x == 320*3) {
        x = 0;
    }
    //self.adView.contentOffset = CGPointMake(x, 0);
    [self.adView setContentOffset:CGPointMake(x, 0) animated:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == self.adView) {
        [self deleteTimer];
    }
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView == self.adView) {
    [self addTimer];
    }
}

@end


