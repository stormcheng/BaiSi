//
//  CHBEssenceController.m
//  BuDeJie
//
//  Created by ibokanwisdom on 16/7/18.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import "CHBEssenceController.h"
#import "CHBAllController.h"
#import "CHBVoiceController.h"
#import "CHBVideosController.h"
#import "CHBPictureController.h"
#import "CHBJokesController.h"
@interface CHBEssenceController ()<UIScrollViewDelegate>
/** 标题栏点击了的按钮 */
@property (weak,nonatomic)UIButton *previousBtn;
/** 标题栏动画view */
@property (weak,nonatomic)UIView *lineView;
/** 标题栏 */
@property (weak,nonatomic)UIView *titleView;
/** 用于展示多个tableView的scrollView */
@property (weak,nonatomic)UIScrollView *scroll;
@end

@implementation CHBEssenceController
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    /** 设置导航栏 */
    [self setupNav];
    /** 添加子控制器 */
    [self addChilVC];
    /** 添加scrollView */
    [self setupScrollView];
    /** 添加标题View */
    [self setupTitleView];
    /** 添加第一个view */
    [self addChilViewWith:0];
}
#pragma mark - 设置标题View
-(void)setupTitleView{
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.chb_width, 35)];
    titleView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];
    self.titleView = titleView;
    [self.view addSubview:titleView];
    [self setupTitleButton];
    [self setupTitleUnderline];
}
/**
 *  设置标题栏上的按钮
 */
-(void)setupTitleButton{
    NSArray *titles = @[@"全部",@"声音",@"视频",@"图片",@"段子"];
    CGFloat width = self.view.chb_width / titles.count;
    CGFloat height = _titleView.chb_height;
    for (int i = 0 ; i < titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.tag = i;
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(i * width, 0, width, height);
        [_titleView addSubview:btn];
    }
}
/**
 *  标题按钮的点击
 *
 *  @param btn 标题栏上的按钮
 */
-(void)clickBtn:(UIButton *)btn{
    // 重复点击按钮发送通知
    if (self.previousBtn == btn) {
        [[NSNotificationCenter defaultCenter] postNotificationName:CHBRepeatClickTitleButtonNotification object:nil];
    }
    self.previousBtn.selected = NO;
    btn.selected = YES;
    self.previousBtn = btn;
    //设置线条动画
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.chb_width = self.previousBtn.titleLabel.chb_width;
        self.lineView.chb_center_x = self.previousBtn.chb_center_x;
        //滚动到对应的视图
        self.scroll.contentOffset =CGPointMake(self.previousBtn.tag * self.scroll.chb_width, 0);
    }];
    [self addChilViewWith:btn.tag];
    //滚动到头部
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *vc = self.childViewControllers[i];
        if(![vc isViewLoaded]) continue;
        UIScrollView *scroll = (UIScrollView *)vc.view;
        if (![scroll isKindOfClass:[UIScrollView class]]) continue;
            scroll.scrollsToTop = btn.tag == i;
    }
}
/**
 *  设置titleView的底部线条
 */
-(void)setupTitleUnderline{
    UIView *lineView =[[UIView alloc]init];
    lineView.backgroundColor = [UIColor redColor];
    lineView.chb_height = 1;
    lineView.chb_y = _titleView.chb_height - 1;
    [_titleView addSubview:lineView];
    self.previousBtn =  self.titleView.subviews.firstObject;
    self.previousBtn.selected = YES;
    [self.previousBtn.titleLabel sizeToFit];
    lineView.chb_width = self.previousBtn.titleLabel.chb_width;
    lineView.chb_center_x = self.previousBtn.chb_center_x;
    self.lineView = lineView;
}

#pragma mark - 添加子控制器
-(void)addChilVC{
    [self addChildViewController:[[CHBAllController alloc]init]];
    [self addChildViewController:[[CHBVoiceController alloc]init]];
    [self addChildViewController:[[CHBVideosController alloc]init]];
    [self addChildViewController:[[CHBPictureController alloc]init]];
    [self addChildViewController:[[CHBJokesController alloc]init]];
}
#pragma mark - 添加ScrollView
-(void)setupScrollView{
    UIScrollView *scroll = [[UIScrollView alloc]init];
    scroll.frame = self.view.bounds;
    scroll.pagingEnabled = YES;
    scroll.autoresizesSubviews = NO;
    scroll.delegate = self;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.scrollsToTop = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:scroll];
    NSInteger count = self.childViewControllers.count;
    CGFloat width = scroll.chb_width;
    scroll.contentSize = CGSizeMake(count * width, 0);
    self.scroll = scroll;
}
#pragma mark - 设置导航栏
-(void)setupNav{
//    设置titleView
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
//    设置左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithButton:[UIButton buttonWithType:UIButtonTypeCustom] andImage:[UIImage imageNamed:@"nav_item_game_icon"] andHighlightImage:[UIImage imageNamed:@"nav_item_game_click_icon"] andTarget:self andSelector:@selector(playGame)];
//    设置右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithButton:[UIButton buttonWithType:UIButtonTypeCustom] andImage:[UIImage imageNamed:@"navigationButtonRandom"] andHighlightImage:[UIImage imageNamed:@"navigationButtonRandomClick"] andTarget:self andSelector:@selector(randomGo)];
}
#pragma mark - scrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index =  scrollView.contentOffset.x / scrollView.chb_width;
    [self clickBtn:self.titleView.subviews[index]];
}
#pragma mark - 懒加载view
-(void)addChilViewWith:(NSInteger)index{
    UITableViewController *vc = self.childViewControllers[index];
    if ([vc isViewLoaded]) return;
    CGFloat width = self.scroll.chb_width;
    CGFloat height = self.scroll.chb_height;
    vc.view.frame = CGRectMake(index * width, 0, width, height);
    [self.scroll addSubview:vc.view];
}
#pragma mark - 待实现方法
-(void)playGame{
    CHBFunc
}
-(void)randomGo{
    CHBFunc
}
@end
