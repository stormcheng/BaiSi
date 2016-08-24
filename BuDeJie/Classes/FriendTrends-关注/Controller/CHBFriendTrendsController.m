//
//  CHBFriendTrendsController.m
//  BuDeJie
//
//  Created by ibokanwisdom on 16/7/18.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import "CHBFriendTrendsController.h"
#import "CHBLoginOrRegisterController.h"
@interface CHBFriendTrendsController ()

@end

@implementation CHBFriendTrendsController

- (void)viewDidLoad {
    [super viewDidLoad];
    /** 设置导航栏 */
    [self setupNav];
}
#pragma mark - 设置导航栏
-(void)setupNav{
        //    设置标题view
    self.navigationItem.title = @"关注";
    //    设置左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithButton:[UIButton buttonWithType:UIButtonTypeCustom] andImage:[UIImage imageNamed:@"friendsRecommentIcon"] andHighlightImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] andTarget:self andSelector:@selector(recommend)];
}
-(void)recommend{
    CHBFunc
}

- (IBAction)loginOrRegist:(UIButton *)sender {
    CHBLoginOrRegisterController *logOrReg = [[CHBLoginOrRegisterController alloc]init];
    [self presentViewController:logOrReg animated:YES completion:nil];
}


@end
