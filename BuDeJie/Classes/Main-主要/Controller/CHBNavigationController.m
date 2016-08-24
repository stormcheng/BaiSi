//
//  CHBNavigationController.m
//  BuDeJie
//
//  Created by ibokanwisdom on 16/7/18.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import "CHBNavigationController.h"

@interface CHBNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation CHBNavigationController
#pragma mark - load
+(void)load{
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    [bar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    //    navBar设置背景图片
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    bar.tintColor = [UIColor blackColor];
}
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置侧滑退出
    [self setupPan];
}
#pragma mark - 设置tabBarbutton属性
+(CHBNavigationController *)setupTabbarWithRootVC:(UIViewController *)vc andTitle:(NSString *)title andImage:(UIImage *)image andHighlightImage:(UIImage *)highlightImg{
    //    设置跟控制器
    CHBNavigationController * nav = [[self alloc]initWithRootViewController:vc];
    //    设置barbutton标题和文字属性
    nav.tabBarItem.title = title;
    [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor darkGrayColor]} forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
    //    设置barbutton图片
    nav.tabBarItem.image  = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage  = [highlightImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return nav;
}
#pragma mark - 设置push的VC
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    //统一设置返回按钮
    if (viewController!=self.childViewControllers[0]) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem ItemWithBackButton:[UIButton buttonWithType:UIButtonTypeCustom] andImage:[UIImage imageNamed:@"navigationButtonReturn"] andHighlightImage:[UIImage imageNamed:@"navigationButtonReturnClick"] andTarget:self andSelector:@selector(back)];
    }
    //统一设置背景色
    viewController.view.backgroundColor = CHBCommonColor;
}
-(void)back{
    [self popViewControllerAnimated:YES];
}
#pragma mark - 侧滑退出
-(void)setupPan{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
    self.interactivePopGestureRecognizer.enabled  = NO;
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.topViewController != self.childViewControllers[0]) {
        return YES;
    }
    return NO;
}

@end
