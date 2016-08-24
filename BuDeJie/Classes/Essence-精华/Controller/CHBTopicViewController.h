//
//  CHBTopicViewController.h
//  BuDeJie11
//
//  Created by ibokanwisdom on 16/8/17.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHBTopic.h"
@interface CHBTopicViewController : UITableViewController
/** 帖子的类型 */
@property (assign,nonatomic)CHBTopicType type;
@end
