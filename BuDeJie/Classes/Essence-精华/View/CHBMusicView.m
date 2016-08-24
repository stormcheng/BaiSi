//
//  CHBMusicCell.m
//  BuDeJie11
//
//  Created by ibokanwisdom on 16/7/28.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import "CHBMusicView.h"
#import "CHBTopic.h"
#import "UIImageView+CHBDownloadImage.h"
#import "CHBGetBigViewController.h"
@interface CHBMusicView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;
@end

@implementation CHBMusicView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getBig)]];
}
#pragma mark - 获取大图
-(void)getBig{
    CHBGetBigViewController *bigVC = [[CHBGetBigViewController alloc]init];
    bigVC.topic = self.topic;
    [self.window.rootViewController presentViewController:bigVC animated:YES completion:nil];
}
-(void)setTopic:(CHBTopic *)topic{
    _topic = topic;
    
    [self.imageView chb_setOriginImage:topic.image1 thumbnailImage:topic.image0 placeholder:nil];
    // 播放数量
    if (topic.playcount >= 10000) {
        self.playcountLabel.text = [NSString stringWithFormat:@"%.1f万播放", topic.playcount / 10000.0];
    } else {
        self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    }
    // %04d : 占据4位，多余的空位用0填补
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", topic.voicetime / 60, topic.voicetime % 60];
    
}

@end
