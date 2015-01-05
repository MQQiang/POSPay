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
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation POSIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAdView];
    CGFloat scrollViewW = 320;
    CGFloat scrollViewH = 375;
    self.scrollView.contentSize = CGSizeMake(scrollViewW * 4, scrollViewH);
    self.scrollView.pagingEnabled = YES;
    [self addFirstView];
    [self addSecondView];
    [self addThirdView];
    [self addFourthView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma 添加应用格子View
- (void)addFirstView
{
    CGFloat padding = 10;
    UIView *view1= [[UIView alloc]init];
    [self addAppCellToView:view1 withNumber:5];
    view1.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:view1];
    UIImageView *imageView = [[UIImageView alloc]init];
    CGFloat imageX = padding;
    CGFloat imageY = padding*2 + 90 *2;
    CGFloat imageW = 300;
    CGFloat imageH = 90;
    imageView.frame = CGRectMake(imageX, imageY,imageW, imageH);
    imageView.image = [UIImage imageNamed:@"ad_00"];
    [view1 addSubview:imageView];
}
- (void)addSecondView
{
    UIView *view2= [[UIView alloc]init];
    [self addAppCellToView:view2 withNumber:5];
    view2.frame = CGRectMake(320, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:view2];
}
- (void)addThirdView
{
    UIView *view3 = [[UIView alloc]init];
    [self addAppCellToView:view3 withNumber:9];
    view3.frame = CGRectMake(640, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:view3];
}
- (void)addFourthView
{
    UIView *view4 = [[UIView alloc]init];
    [self addAppCellToView:view4 withNumber:1];
    view4.frame = CGRectMake(960, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:view4];
}
- (void)addAppCellToView:(UIView *)view withNumber:(NSInteger)number
{
    CGFloat padding = 10;
    for (int i = 0; i<number; i++) {
        UIView *appView = [[[NSBundle mainBundle] loadNibNamed:@"appCell" owner:nil options:nil] lastObject];
        //计算位置
        
        CGFloat appW = 75;
        CGFloat appH = 90;
        CGFloat appX = padding + appW*(i%4);
        CGFloat appY = padding +i/4 *appH;
        appView.frame = CGRectMake(appX, appY, appW, appH);
        [view addSubview:appView];
    }
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


