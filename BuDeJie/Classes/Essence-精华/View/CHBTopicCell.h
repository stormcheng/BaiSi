//
//  XMGTopicCell.h
//  BuDeJie
//
//  Created by xiaomage on 16/3/23.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHBTopic;

@interface CHBTopicCell : UITableViewCell
/** 模型数据 */
@property (nonatomic, strong) CHBTopic *topic;
@end
