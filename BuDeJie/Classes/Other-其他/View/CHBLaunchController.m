//
//  CHBLaunchController.m
//  BuDeJie11
//
//  Created by ibokanwisdom on 16/7/19.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import "CHBLaunchController.h"
#import <AFNetworking.h>
#import "CHBADItem.h"
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import "CHBTabBarController.h"
static NSString * const code2 = @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam";

@interface CHBLaunchController ()
/** 启动图片 */
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
/** 广告占位 */
@property (weak, nonatomic) IBOutlet UIView *containerView;
/** 跳过按钮 */
@property (weak, nonatomic) IBOutlet UIButton *skipBtn;
/** 网络管理者 */
@property (weak,nonatomic) AFHTTPSessionManager *manager;
/** 广告图片 */
@property (weak,nonatomic)UIImageView *adView;
/** 广告数据模型 */
@property (strong,nonatomic)CHBADItem *item;
/** 定时器 */
@property (weak,nonatomic)NSTimer *timer;
@end
#pragma mark -
@implementation CHBLaunchController
#pragma mark - lazy
-(UIImageView *)adView{
    if (_adView == nil) {
        UIImageView *adView = [[UIImageView alloc]init];
        [self.containerView addSubview:adView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(adTap)];
        [adView addGestureRecognizer:tap];
        adView.userInteractionEnabled = YES;
        _adView = adView;
    }
    return _adView;
}
-(AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        _manager = manager;
    }
    return _manager;
}
#pragma mark - 按钮点击
/** 广告跳过 */
- (IBAction)skip:(UIButton *)sender {
    [self.timer invalidate];
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    self.view.window.rootViewController = [[CHBTabBarController alloc]init];
}
/** 广告跳转 */
-(void)adTap{
    NSURL *url = [NSURL URLWithString:self.item.ori_curl];
    if([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url];
    }
}
#pragma mark - viewdidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    /** 设置启动图片 */
    [self setupLauchImageView];
    /** 加载广告数据 */
    [self loadADData];
    /** 设置定时器 */
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}
#pragma mark - 更改按钮数字
-(void)timeChange{
    static int i = 2;
    if (i==0) {
        [self skip:nil];
    }
    [self.skipBtn setTitle:[NSString stringWithFormat:@"跳过(%d)",i] forState:UIControlStateNormal] ;
    i--;
}
#pragma mark - 加载广告数据
-(void)loadADData{
    /** 设置请求参数 */
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"code2"] = code2;
    [self.manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
//        显示广告
        NSDictionary *dic = [responseObject[@"ad"] firstObject];
        self.item = [CHBADItem mj_objectWithKeyValues:dic];
        self.adView.frame = CGRectMake(0, 0, CHBScreenW, CHBScreenW/self.item.w *self.item.h);
        [self.adView sd_setImageWithURL:[NSURL URLWithString:self.item.w_picurl]];
        
//        更改时间
//        切换根控制器
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CHBLog(@"%@",error);
    }];
}
#pragma mark - 设置启动图片
- (void)setupLauchImageView {
    if (iphone6P) {
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }else if(iphone6){
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    }else if (iphone5){
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-568h"];
    }else if(iphone4){
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage"];
    }
}
@end
