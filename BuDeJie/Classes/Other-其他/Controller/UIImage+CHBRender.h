//
//  UIImage+CHBRender.h
//  BuDeJie11
//
//  Created by ibokanwisdom on 16/7/28.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//  生成初始图片、获得圆角图片

#import <UIKit/UIKit.h>

@interface UIImage (CHBRender)
+(instancetype)imageFromOriginalWithName:(NSString *)name;
+(instancetype)circularImageWithImageName:(NSString *)name;
-(instancetype)circularImage;
@end
