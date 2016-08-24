//
//  CHBFileTool.h
//  BuDeJie11
//
//  Created by ibokanwisdom on 16/7/21.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//  文件夹计算大小和删除的工具类

#import <Foundation/Foundation.h>
@interface CHBFileTool : NSObject
/**
 *  获取文件夹路径总大小
 *
 *  @param path       文件夹路径
 *  @param completion 回调传值
 */
+(void)getSizeFromPath:(NSString *)path completion:(void(^)(NSInteger size))completion;
/**
 *  删除路径下的文件
 *
 *  @param path 文件夹路径
 */
+(void)removeDiretoryPath:(NSString *)path;

@end
