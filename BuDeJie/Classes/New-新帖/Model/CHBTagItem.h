//
//  CHBTagItem.h
//  BuDeJie11
//
//  Created by ibokanwisdom on 16/7/20.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHBTagItem : NSObject
/** 头像 */
@property (copy,nonatomic) NSString *image_list;
/** 订阅人数 */
@property (copy,nonatomic) NSString *sub_number;
/** 名字 */
@property (copy,nonatomic) NSString *theme_name;
@end
