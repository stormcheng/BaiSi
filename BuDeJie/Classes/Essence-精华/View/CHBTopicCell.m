//
//  XMGTopicCell.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/23.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "CHBTopicCell.h"
#import "CHBTopic.h"
#import <UIImageView+WebCache.h>
#import "UIImage+CHBRender.h"
#import "CHBPictureView.h"
#import "CHBVideoView.h"
#import "CHBMusicView.h"
@interface CHBTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UILabel *commentLable;
/** 图片控件 */
@property (weak,nonatomic) CHBPictureView *pictureView;
/** 声音控件 */
@property (weak,nonatomic) CHBMusicView *musicView;
/** 视频控件 */
@property (weak,nonatomic)CHBVideoView *videoView;
@end

@implementation CHBTopicCell
#pragma mark - 懒加载
-(CHBPictureView *)pictureView{
    if (_pictureView == nil) {
        CHBPictureView *view = [CHBPictureView viewFromNib];
        _pictureView = view;
        [self addSubview:view];
    }
    return _pictureView;
}
-(CHBMusicView *)musicView{
    if (_musicView == nil) {
        CHBMusicView *view = [CHBMusicView viewFromNib];
        _musicView = view;
        [self addSubview:view];

    }
    return _musicView;
}
-(CHBVideoView *)videoView{
    if (_videoView==nil) {
        CHBVideoView *view = [CHBVideoView viewFromNib];
        _videoView = view;
        [self addSubview:view];
    }
    return _videoView;
}
#pragma mark - 初始化操作
- (void)awakeFromNib
{
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageFromOriginalWithName:@"mainCellBackground"]];
}
#pragma mark - 设置数据
- (void)setTopic:(CHBTopic *)topic
{
    _topic = topic;
    
    // 1.设置顶部控件的数据
    UIImage *placeholder = [UIImage circularImageWithImageName:@"defaultUserIcon"];
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:placeholder options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) {
            return;
        }
        self.profileImageView.image = [image circularImage];
    }];
    self.nameLabel.text = topic.name;
    self.passtimeLabel.text = topic.passtime;
    self.text_label.text = topic.text;
    // 2.设置最热评论
    if (topic.top_cmt.count) {
        self.commentView.hidden = NO;
        NSDictionary *cmt = topic.top_cmt.firstObject;
        NSString *content = cmt[@"content"];
        if (content.length == 0) { // 语音评论
            content = @"[语音评论]";
        }
        NSString *username = cmt[@"user"][@"username"];
        
        self.commentLable.text = [NSString stringWithFormat:@"%@ : %@", username, content];
    } else { // 没有最热评论
        self.commentView.hidden = YES;
    }
    
    // 3.设置底部按钮的文字
    [self setupButtonTitle:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton number:topic.comment placeholder:@"评论"];
    
    //4.设置需要显示的view
    if (topic.type == CHBTopicTypePicture) {
        self.pictureView.hidden = NO;
        self.musicView.hidden = YES;
        self.pictureView.topic = topic;
        self.videoView.hidden = YES;
    } else if (topic.type == CHBTopicTypeVoice) {
        self.pictureView.hidden = YES;
        self.musicView.hidden = NO;
        self.musicView.topic = topic;
        self.videoView.hidden = YES;
    } else if (topic.type == CHBTopicTypeVideo) {
        self.pictureView.hidden = YES;
        self.musicView.hidden = YES;
        self.videoView.topic = topic;
        self.videoView.hidden = NO;
    } else if (topic.type == CHBTopicTypeWord) { 
        self.pictureView.hidden = YES;
        self.musicView.hidden = YES;
        self.videoView.hidden = YES;
    }
}

/**
 *  设置按钮文字
 *  @param number      按钮的数字
 *  @param placeholder 数字为0时显示的文字
 */
- (void)setupButtonTitle:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}
#pragma mark - 布局子控件
-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.topic.type == CHBTopicTypePicture) { // 图片
        self.pictureView.frame = self.topic.centerFrame;
    } else if (self.topic.type == CHBTopicTypeVoice) { // 声音
        self.musicView.frame = self.topic.centerFrame;
    } else if (self.topic.type == CHBTopicTypeVideo) { // 视频
        self.videoView.frame = self.topic.centerFrame;
    }
}
#pragma mark - 重新计算cell的高度
-(void)setFrame:(CGRect)frame{
    frame.size.height -=10;
    [super setFrame:frame];
}
@end
