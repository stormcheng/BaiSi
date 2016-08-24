//
//  CHBNavigationController.h
//  BuDeJie
//
//  Created by ibokanwisdom on 16/7/18.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHBNavigationController : UINavigationController
+(CHBNavigationController *)setupTabbarWithRootVC:(UIViewController *)vc andTitle:(NSString *)title andImage:(UIImage *)image andHighlightImage:(UIImage *)highlightImg;
@end
