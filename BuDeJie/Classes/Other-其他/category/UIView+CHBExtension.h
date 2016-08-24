//
//  UIView+CHBExtension.h
//  iOS_百思不得姐项目
//
//  Created by ibokanwisdom on 16/7/8.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//  快速获取view的坐标值

#import <UIKit/UIKit.h>

@interface UIView (CHBExtension)
/** 宽度 */
@property (assign,nonatomic)CGFloat chb_width;
/** 高度 */
@property (assign,nonatomic)CGFloat chb_height;
/** frame.x */
@property (assign,nonatomic)CGFloat chb_x;
/** frame.y */
@property (assign,nonatomic)CGFloat chb_y;
/** view的右侧 */
@property (assign,nonatomic)CGFloat chb_right;
/** view的底部*/
@property (assign,nonatomic)CGFloat chb_bottom;
/** view的中心x */
@property (assign,nonatomic)CGFloat chb_center_x;
/** view的中心y */
@property (assign,nonatomic)CGFloat chb_center_y;

+(instancetype)viewFromNib;
@end
