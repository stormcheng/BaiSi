//
//  CHBTabBarController.m
//  BuDeJie
//
//  Created by ibokanwisdom on 16/7/18.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import "CHBTabBarController.h"
#import "CHBNavigationController.h"
#import "CHBNewController.h"
#import "CHBMineController.h"
#import "CHBEssenceController.h"
#import "CHBFriendTrendsController.h"
#import "CHBTabBar.h"
@interface CHBTabBarController ()

@end

@implementation CHBTabBarController
#pragma mark - view加载完毕
- (void)viewDidLoad {
    [super viewDidLoad];
    /** 设置导航控制器 */
    [self setupNav];
    /** 自定义tabbar */
    [self setupTabBar];
}
#pragma mark - 初始化导航控制器
-(void)setupNav{
    [self addChildViewController:[CHBNavigationController setupTabbarWithRootVC:[[CHBEssenceController alloc]init] andTitle:@"精华" andImage:[UIImage imageNamed:@"tabBar_essence_icon"] andHighlightImage:[UIImage imageNamed:@"tabBar_essence_click_icon"]]];
    [self addChildViewController:[CHBNavigationController setupTabbarWithRootVC:[[CHBNewController alloc]init] andTitle:@"新帖" andImage:[UIImage imageNamed:@"tabBar_new_icon"] andHighlightImage:[UIImage imageNamed:@"tabBar_new_click_icon"]]];
    [self addChildViewController:[CHBNavigationController setupTabbarWithRootVC:[[CHBFriendTrendsController alloc]init] andTitle:@"关注" andImage:[UIImage imageNamed:@"tabBar_friendTrends_icon"] andHighlightImage:[UIImage imageNamed:@"tabBar_friendTrends_click_icon"]]];
    [self addChildViewController:[CHBNavigationController setupTabbarWithRootVC:[[CHBMineController alloc]init] andTitle:@"我" andImage:[UIImage imageNamed:@"tabBar_me_icon"] andHighlightImage:[UIImage imageNamed:@"tabBar_me_click_icon"]]];
    
    
}
#pragma mark - 自定义tabBar
-(void)setupTabBar{
    CHBTabBar *bar = [[CHBTabBar alloc]init];
    [self setValue:bar forKeyPath:@"tabBar"];
}



@end
