//
//  CHBTabBar.m
//  BuDeJie
//
//  Created by ibokanwisdom on 16/7/18.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import "CHBTabBar.h"

@interface CHBTabBar ()
/** 发布按钮 */
@property (weak,nonatomic) UIButton *publishBtn;
/** 第一次点击的按钮 */
@property (weak,nonatomic)UIControl *previouseBtn;

@end

@implementation CHBTabBar
#pragma mark - init
-(instancetype)init{
    if (self = [super init]) {
//        设置背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
    }
    return  self;
}
#pragma mark - lazy
-(UIButton *)publishBtn{
    if (_publishBtn == nil) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [btn sizeToFit];
        [self addSubview:btn];
        _publishBtn = btn;
    }
    return _publishBtn;
}

#pragma mark - 布局子控件
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat itemWidth = self.chb_width / 5;
    CGFloat itemHight = self.chb_height;
    NSInteger index = 0;
    for (UIControl *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (index > 1) {
                view.frame = CGRectMake((index+1) * itemWidth, 0, itemWidth, itemHight);
            }else{
                view.frame = CGRectMake(index * itemWidth, 0, itemWidth, itemHight);
            }
            index ++;
            [view addTarget:self action:@selector(repeatRefresh:) forControlEvents:UIControlEventTouchUpInside];
            if(index == 1) self.previouseBtn = view;
        }
    }
    self.publishBtn.chb_center_x = self.chb_width / 2;
    self.publishBtn.chb_y = 0;
}
-(void)repeatRefresh:(UIControl *)clickBtn{
    if (self.previouseBtn == clickBtn) {
        [[NSNotificationCenter defaultCenter]postNotificationName:CHBRepeatClickTabBarButtonNotification object:nil];
    }
    self.previouseBtn = clickBtn;
}
@end
