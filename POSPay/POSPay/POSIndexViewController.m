//
//  FirstViewController.m
//  POSPay
//
//  Created by mq on 15/1/2.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//
#import "FinanceIndexViewController.h"
#import "POSIndexViewController.h"
#import "appCell.h"
#import "POSCardPaymentController.h"
#import "POSNoCardPaymentController.h"
#import "POSScanPaymentViewController.h"
#import "GameFeeViewController.h"
#import "LifeNormalFeeViewController.h"
#import "PhoneFeeViewController.h"
#import "AliPayViewController.h"
#import "QQFeeViewController.h"

@interface POSIndexViewController ()<UIScrollViewDelegate>
//图片轮播器
@property (weak, nonatomic) IBOutlet UIScrollView *adView;
//应用格子
@property (weak, nonatomic) IBOutlet UIScrollView *applicationScrollView;

- (IBAction)scanPayment:(id)sender;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation POSIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.adView.showsVerticalScrollIndicator = NO;
    //v self.adView.contentOffset = CGPointMake(0, 0);
    [self addAdView];
    
    [self addAppViewBtn];
    
    
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
- (void)addAppViewBtn{
    self.applicationScrollView.pagingEnabled = YES;
    self.applicationScrollView.contentSize = CGSizeMake(1280, 210);
    self.applicationScrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 300, 0);
    //第1页
    //刷卡支付
    UIButton *pushCardPayBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 150, 100)];
    [pushCardPayBtn setBackgroundImage:[UIImage imageNamed:@"按钮1"] forState:UIControlStateNormal];
    [pushCardPayBtn addTarget:self action:@selector(pushCardPayment:) forControlEvents:UIControlEventTouchUpInside];
    [self.applicationScrollView addSubview: pushCardPayBtn];
    //无卡支付
    UIButton *pushNoCardPayBtn = [[UIButton alloc]initWithFrame:CGRectMake(165, 5, 150, 100)];
    [pushNoCardPayBtn setBackgroundImage:[UIImage imageNamed:@"按钮2"] forState:UIControlStateNormal];
    [pushNoCardPayBtn addTarget:self action:@selector(pushNoCardPayment:) forControlEvents:UIControlEventTouchUpInside];
    [self.applicationScrollView addSubview: pushNoCardPayBtn];
    //NFC支付
    UIButton *NFCPayBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 110, 100, 100)];
    [NFCPayBtn setBackgroundImage:[UIImage imageNamed:@"按钮8"] forState:UIControlStateNormal];
    //[pushCardPayBtn addTarget:self action:@selector(pushCardPayment:) forControlEvents:UIControlEventTouchUpInside];
    [self.applicationScrollView addSubview: NFCPayBtn];
    //扫描支付
    UIButton *scanPayBtn = [[UIButton alloc]initWithFrame:CGRectMake(110, 110, 100, 100)];
    [scanPayBtn setBackgroundImage:[UIImage imageNamed:@"按钮9"] forState:UIControlStateNormal];
    [scanPayBtn addTarget:self action:@selector(scanPayment:) forControlEvents:UIControlEventTouchUpInside];
    [self.applicationScrollView addSubview: scanPayBtn];
    //会员积分支付
    UIButton *jifenPayBtn = [[UIButton alloc]initWithFrame:CGRectMake(215, 110, 100, 100)];
    [jifenPayBtn setBackgroundImage:[UIImage imageNamed:@"按钮10"] forState:UIControlStateNormal];
    //[pushCardPayBtn addTarget:self action:@selector(pushCardPayment:) forControlEvents:UIControlEventTouchUpInside];
    [self.applicationScrollView addSubview: jifenPayBtn];
    //广告（主页按钮）
    UIButton *adBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 215, 310, 70)];
    [adBtn setBackgroundImage:[UIImage imageNamed:@"主页按钮"] forState:UIControlStateNormal];
    [adBtn addTarget:self action:@selector(pushFinace:) forControlEvents:UIControlEventTouchUpInside];
    [self.applicationScrollView addSubview:adBtn];
    //第2页
    //话费
    UIButton *huafeiBtn = [[UIButton alloc]initWithFrame:CGRectMake(325, 5, 100, 100)];
    [huafeiBtn setBackgroundImage:[UIImage imageNamed:@"按钮11"] forState:UIControlStateNormal];
    [huafeiBtn addTarget:self action:@selector(pushPhoneFee:) forControlEvents:UIControlEventTouchUpInside];
    [self.applicationScrollView addSubview: huafeiBtn];
    //水电
    UIButton *shuidianBtn = [[UIButton alloc]initWithFrame:CGRectMake(430, 5, 100, 100)];
    [shuidianBtn setBackgroundImage:[UIImage imageNamed:@"按钮12"] forState:UIControlStateNormal];
    [shuidianBtn addTarget:self action:@selector(pushLifeNormal:) forControlEvents:UIControlEventTouchUpInside];
    [self.applicationScrollView addSubview: shuidianBtn];
    //点卡
    UIButton *diankaBtn = [[UIButton alloc]initWithFrame:CGRectMake(535, 5, 100, 100)];
    [diankaBtn setTitle:@"游戏点卡" forState:UIControlStateNormal];
    //[diankaBtn setBackgroundImage:[UIImage imageNamed:@"按钮1"] forState:UIControlStateNormal];
    [diankaBtn addTarget:self action:@selector(pushGameFee:) forControlEvents:UIControlEventTouchUpInside];
    [self.applicationScrollView addSubview: diankaBtn];
    //交通罚款
    UIButton *jiaotongBtn = [[UIButton alloc]initWithFrame:CGRectMake(325, 110, 100, 100)];
    [jiaotongBtn setBackgroundImage:[UIImage imageNamed:@"18"] forState:UIControlStateNormal];
    //[huafeiBtn addTarget:self action:@selector(pushCardPayment:) forControlEvents:UIControlEventTouchUpInside];
    [self.applicationScrollView addSubview: jiaotongBtn];
    //QB充值
    UIButton *QBBtn = [[UIButton alloc]initWithFrame:CGRectMake(430, 110, 100, 100)];
    [QBBtn setBackgroundImage:[UIImage imageNamed:@"按钮13"] forState:UIControlStateNormal];
    [QBBtn addTarget:self action:@selector(pushQQFee:) forControlEvents:UIControlEventTouchUpInside];
    [self.applicationScrollView addSubview: QBBtn];
    //彩票
    UIButton *caipiaoBtn = [[UIButton alloc]initWithFrame:CGRectMake(535, 110, 100, 100)];
    [caipiaoBtn setBackgroundImage:[UIImage imageNamed:@"15"] forState:UIControlStateNormal];
    //[huafeiBtn addTarget:self action:@selector(pushCardPayment:) forControlEvents:UIControlEventTouchUpInside];
    [self.applicationScrollView addSubview: caipiaoBtn];
    //加油卡
    UIButton *jiayoukaBtn = [[UIButton alloc]initWithFrame:CGRectMake(325, 215, 100, 100)];
    [jiayoukaBtn setBackgroundImage:[UIImage imageNamed:@"17"] forState:UIControlStateNormal];
    //[huafeiBtn addTarget:self action:@selector(pushCardPayment:) forControlEvents:UIControlEventTouchUpInside];
    [self.applicationScrollView addSubview: jiayoukaBtn];
    //电影票
    UIButton *dianyingpiaoBtn = [[UIButton alloc]initWithFrame:CGRectMake(430, 215, 100, 100)];
    [dianyingpiaoBtn setBackgroundImage:[UIImage imageNamed:@"16"] forState:UIControlStateNormal];
    //[huafeiBtn addTarget:self action:@selector(pushCardPayment:) forControlEvents:UIControlEventTouchUpInside];
    [self.applicationScrollView addSubview: dianyingpiaoBtn];
    //支付宝充值
    UIButton *zhifubaoBtn = [[UIButton alloc]initWithFrame:CGRectMake(535, 215, 100, 100)];
    [zhifubaoBtn setBackgroundImage:[UIImage imageNamed:@"14"] forState:UIControlStateNormal];
    [zhifubaoBtn addTarget:self action:@selector(pushAlipay:) forControlEvents:UIControlEventTouchUpInside];
    [self.applicationScrollView addSubview: zhifubaoBtn];
    //第3页
    //酒店预订
    UIButton *hotelBtn = [[UIButton alloc]initWithFrame:CGRectMake(645, 5, 150, 100)];
    [hotelBtn setBackgroundImage:[UIImage imageNamed:@"按钮3"] forState:UIControlStateNormal];
    //[huafeiBtn addTarget:self action:@selector(pushCardPayment:) forControlEvents:UIControlEventTouchUpInside];
    [self.applicationScrollView addSubview: hotelBtn];
    //景点门票
    UIButton *jingdianmenpiaoBtn = [[UIButton alloc]initWithFrame:CGRectMake(805, 5, 150, 100)];
    [jingdianmenpiaoBtn setBackgroundImage:[UIImage imageNamed:@"按钮4"] forState:UIControlStateNormal];
    //[huafeiBtn addTarget:self action:@selector(pushCardPayment:) forControlEvents:UIControlEventTouchUpInside];
    [self.applicationScrollView addSubview: jingdianmenpiaoBtn];
    //飞机票
    UIButton *feijipiaoBtn = [[UIButton alloc]initWithFrame:CGRectMake(645, 110, 100, 100)];
    [feijipiaoBtn setBackgroundImage:[UIImage imageNamed:@"按钮5"] forState:UIControlStateNormal];
    //[huafeiBtn addTarget:self action:@selector(pushCardPayment:) forControlEvents:UIControlEventTouchUpInside];
    [self.applicationScrollView addSubview: feijipiaoBtn];
    //火车票
    UIButton *huochepiaoBtn = [[UIButton alloc]initWithFrame:CGRectMake(750, 110, 100, 100)];
    [huochepiaoBtn setBackgroundImage:[UIImage imageNamed:@"按钮6"] forState:UIControlStateNormal];
    //[huafeiBtn addTarget:self action:@selector(pushCardPayment:) forControlEvents:UIControlEventTouchUpInside];
    [self.applicationScrollView addSubview: huochepiaoBtn];
    //汽车票
    UIButton *qichepiaoBtn = [[UIButton alloc]initWithFrame:CGRectMake(855, 110, 100, 100)];
    [qichepiaoBtn setBackgroundImage:[UIImage imageNamed:@"按钮7"] forState:UIControlStateNormal];
    //[huafeiBtn addTarget:self action:@selector(pushCardPayment:) forControlEvents:UIControlEventTouchUpInside];
    [self.applicationScrollView addSubview:qichepiaoBtn];
    //第4页
    //微信商城
    UIButton *weixinshangchengBtn = [[UIButton alloc]initWithFrame:CGRectMake(965, 5, 310 , 70)];
    [weixinshangchengBtn setBackgroundImage:[UIImage imageNamed:@"微信商城按钮"] forState:UIControlStateNormal];
    //[huafeiBtn addTarget:self action:@selector(pushCardPayment:) forControlEvents:UIControlEventTouchUpInside];
    [self.applicationScrollView addSubview: weixinshangchengBtn];
}

- (IBAction)pushCardPayment:(id)sender {
    POSCardPaymentController* pushedView=[[POSCardPaymentController alloc] init];
    pushedView.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:pushedView animated:YES];
    
    
}
-(void)pushPhoneFee:(id)sender{
    
    PhoneFeeViewController *vc = [[PhoneFeeViewController    alloc] init];
    
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)pushFinace:(id)sender
{
    FinanceIndexViewController *vc = [[FinanceIndexViewController alloc] init];
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)pushLifeNormal:(id)sender{
    
    LifeNormalFeeViewController * vc = [[LifeNormalFeeViewController alloc] init];
    
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
-(void)pushQQFee:(id)sender{
    
     QQFeeViewController* vc = [[QQFeeViewController alloc] init];
    
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)pushGameFee:(id)sender{
    
    GameFeeViewController * vc = [[GameFeeViewController alloc] init];
    
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

-(void)pushAlipay:(id)sender{
    
    AliPayViewController * vc = [[AliPayViewController alloc] init];
    
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)pushNoCardPayment:(id)sender {
    POSNoCardPaymentController* pushedView=[[POSNoCardPaymentController alloc] init];
    pushedView.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:pushedView animated:YES];
    
    
}
- (IBAction)scanPayment:(id)sender {
    POSScanPaymentViewController* pushView=[[POSScanPaymentViewController alloc] init];
    pushView.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:pushView animated:YES];
    
    
}
@end


