//
//  CHBNewController.m
//  BuDeJie
//
//  Created by ibokanwisdom on 16/7/18.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import "CHBNewController.h"
#import "CHBTagController.h"
@interface CHBNewController ()

@end
#pragma mark -
@implementation CHBNewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /** 设置导航栏 */
    [self setupNav];
}
#pragma mark - 设置导航栏
-(void)setupNav{
    //    设置标题view
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //    设置左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithButton:[UIButton buttonWithType:UIButtonTypeCustom] andImage:[UIImage imageNamed:@"MainTagSubIcon"] andHighlightImage:[UIImage imageNamed:@"MainTagSubIconClick"] andTarget:self andSelector:@selector(tagClick)];
}
-(void)tagClick{
    CHBTagController *tagVC = [[CHBTagController alloc]init];
    [self.navigationController pushViewController:tagVC animated:YES];
}

#pragma mark - Table view data source




@end
