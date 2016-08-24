//
//  UIImage+CHBRender.m
//  BuDeJie11
//
//  Created by ibokanwisdom on 16/7/28.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.


#import "UIImage+CHBRender.h"

@implementation UIImage (CHBRender)
+(instancetype)imageFromOriginalWithName:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    return  [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+(instancetype)circularImageWithImageName:(NSString *)name {
    return  [[UIImage imageNamed:name]circularImage];
}

-(instancetype)circularImage {
//    1.开启图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 1);
//    2.设置剪切路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
//    3.添加剪切路径到上限
    [path addClip];
//    4.绘制图片
    [self drawAtPoint:CGPointZero];
//    5.从上下文中获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    6.关闭图形上下文
    UIGraphicsEndImageContext();
    return image;
}
@end
