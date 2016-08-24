//
//  CHBADItem.h
//  BuDeJie11
//
//  Created by ibokanwisdom on 16/7/20.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHBADItem : NSObject
/** 广告图片地址 */
@property (nonatomic, strong) NSString *w_picurl;
/** 点击广告跳转的地址 */
@property (nonatomic, strong) NSString *ori_curl;
/** 图片高 */
@property (assign,nonatomic)CGFloat h;
/** 图片宽度 */
@property (assign,nonatomic)CGFloat w;


@end
