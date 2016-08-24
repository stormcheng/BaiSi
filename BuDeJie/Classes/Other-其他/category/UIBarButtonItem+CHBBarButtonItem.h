//
//  UIBarButtonItem+CHBBarButtonItem.h
//  iOS_百思不得姐项目
//
//  Created by ibokanwisdom on 16/7/8.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//  快速添加barbuttonitem

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CHBBarButtonItem)
/** 快速添加高亮按钮的item */
+(instancetype)itemWithButton:(UIButton *)btn andImage:(UIImage *)image andHighlightImage:(UIImage *)highImage andTarget:(id)target andSelector:(SEL)selector;
/** 快速添加选中按钮的item */
+(instancetype)itemWithButton:(UIButton *)btn andImage:(UIImage *)image andSelectedImage:(UIImage *)selectedimage andTarget:(id)target andSelector:(SEL)selector;
/** 快速设置返回buttonitme */
+(instancetype)ItemWithBackButton:(UIButton *)btn andImage:(UIImage *)image andHighlightImage:(UIImage *)highImage andTarget:(id)target andSelector:(SEL)selector;
@end
