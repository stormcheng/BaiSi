//
//  NSDate+CHBExtension.h
//  BuDeJie11
//
//  Created by ibokanwisdom on 16/8/17.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CHBExtension)
/**
*  是否为今年
*/
- (BOOL)isThisYear;

/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为昨天
 */
- (BOOL)isYesterday;

/**
 *  是否为明天
 */
- (BOOL)isTomorrow;
@end
