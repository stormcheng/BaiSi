//
//  UIBarButtonItem+CHBBarButtonItem.m
//  iOS_百思不得姐项目
//
//  Created by ibokanwisdom on 16/7/8.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import "UIBarButtonItem+CHBBarButtonItem.h"

@implementation UIBarButtonItem (CHBBarButtonItem)

+(instancetype)itemWithButton:(UIButton *)btn andImage:(UIImage *)image andHighlightImage:(UIImage *)HighImage andTarget:(id)target andSelector:(SEL)selector {
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:HighImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return  [[self alloc]initWithCustomView:btn];
}

+(instancetype)itemWithButton:(UIButton *)btn andImage:(UIImage *)image andSelectedImage:(UIImage *)selectedimage andTarget:(id)target andSelector:(SEL)selector {
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selectedimage forState:UIControlStateSelected];
    [btn sizeToFit];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return  [[self alloc]initWithCustomView:btn];
}

+(instancetype)ItemWithBackButton:(UIButton *)btn andImage:(UIImage *)image andHighlightImage:(UIImage *)highImage andTarget:(id)target andSelector:(SEL)selector{
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:btn];
}
@end
