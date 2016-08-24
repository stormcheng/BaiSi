//
//  CHBPictureCell.m
//  BuDeJie11
//
//  Created by ibokanwisdom on 16/7/28.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import "CHBPictureView.h"
#import "CHBTopic.h"
#import "UIImageView+CHBDownloadImage.h"
#import "CHBGetBigViewController.h"
@interface CHBPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;
@end

@implementation CHBPictureView
#pragma mark - 初始化
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
#pragma mark - 设置数据
-(void)setTopic:(CHBTopic *)topic{
    _topic = topic;
    
    // 设置图片
    self.placeholderView.hidden = NO;
    [self.imageView chb_setOriginImage:topic.image1 thumbnailImage:topic.image0 placeholder:nil];
    self.gifView.hidden = !topic.is_gif;
    
    
    // 点击查看大图
    if (topic.isBigPicture) { // 超长图
        self.seeBigPictureButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
        
        // 处理超长图片的大小
        if (self.imageView.image) {
            CGFloat imageW = topic.centerFrame.size.width;
            CGFloat imageH = imageW * topic.height / topic.width;
            // 开启上下文
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            // 绘制图片到上下文中
            [self.imageView.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            // 关闭上下文
            UIGraphicsEndImageContext();
        }
    } else {
        self.seeBigPictureButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
        
    }}

@end
