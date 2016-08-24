//
//  UITextField+CHBPlaceholderColor.m
//  iOS_百思不得姐项目
//
//  Created by ibokanwisdom on 16/7/10.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import "UITextField+CHBPlaceholderColor.h"

static NSString * const CHBPlaceholderColorKey = @"placeholderLabel.textColor";
@implementation UITextField (CHBPlaceholderColor)
/**
 *  设置placeholder的颜色
 *
 *  @param placeholderColor placeholder的颜色
 */
-(void)setChb_placeholderColor:(UIColor *)chb_placeholderColor{
    NSString *old = self.placeholder;
    self.placeholder = @" ";
    self.placeholder = old;
    if (chb_placeholderColor == nil) {
        chb_placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    }
    [self setValue:chb_placeholderColor forKeyPath:CHBPlaceholderColorKey];
}
-(UIColor *)chb_placeholderColor{
    return [self valueForKey:CHBPlaceholderColorKey];
}
@end
