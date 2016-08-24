//
//  CHBFileTool.m
//  BuDeJie11
//
//  Created by ibokanwisdom on 16/7/21.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import "CHBFileTool.h"

@implementation CHBFileTool

+(void)getSizeFromPath:(NSString *)path completion:(void(^)(NSInteger size)) completion{
//    判断路径是否存在
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDir = false;
    BOOL isExist = [mgr fileExistsAtPath:path isDirectory:&isDir];
    if ( !(isDir && isExist)) {
        NSException *ex = [[NSException alloc]initWithName:@"路径出错" reason:@"需要传入文件夹路径，并且路径存在" userInfo:nil];
        [ex raise];
    }
    
//    子线程计算
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSArray<NSString *> *paths = [mgr subpathsAtPath:path];
        
        NSInteger fileSize = 0;
        
        for (NSString *subPath in paths) {
            NSString *fullPath = [path stringByAppendingPathComponent:subPath];
            NSDictionary *dic = [mgr attributesOfItemAtPath:fullPath error:nil];
            fileSize += [dic fileSize];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(fileSize);
            }
        });
    });
    
}
+(void)removeDiretoryPath:(NSString *)path {
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDir = false;
    BOOL isExist = [mgr fileExistsAtPath:path isDirectory:&isDir];
    if ( !(isDir && isExist)) {
        NSException *ex = [[NSException alloc]initWithName:@"路径出错" reason:@"需要传入文件夹路径，并且路径存在" userInfo:nil];
        [ex raise];
    }
    NSArray<NSString *> *paths = [mgr contentsOfDirectoryAtPath:path error:nil];
    for (NSString *subPath in paths) {
        NSString *fullPath = [path stringByAppendingPathComponent:subPath];
        [mgr removeItemAtPath:fullPath error:nil];
    }
}
@end
