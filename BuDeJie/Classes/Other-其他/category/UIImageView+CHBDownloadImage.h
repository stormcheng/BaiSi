//
//  UIImageView+CHBDownloadImage.h
//  BuDeJie11
//
//  Created by ibokanwisdom on 16/7/29.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//  不同联网状态下，用来下载图片的分类

#import <UIKit/UIKit.h>

@interface UIImageView (CHBDownloadImage)

- (void)chb_setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(UIImage *)placeholder;
@end
