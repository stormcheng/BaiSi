//
//  CHBCollectionItem.h
//  BuDeJie11
//
//  Created by ibokanwisdom on 16/7/21.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHBCollectionItem : NSObject
/** 图标 */
@property (copy,nonatomic) NSString *icon;
/** 标签 */
@property (copy,nonatomic) NSString *name;
/** 跳转地址 */
@property (copy,nonatomic) NSString *url;
@end
