//
//  CHBBottomUpStyleButton.m
//  BuDeJie11
//
//  Created by ibokanwisdom on 16/7/21.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import "CHBBottomUpStyleButton.h"

@implementation CHBBottomUpStyleButton
-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.chb_center_x = self.chb_width/2;
    [self.titleLabel sizeToFit];
    self.titleLabel.chb_y = self.imageView.chb_bottom+5;
    self.titleLabel.chb_center_x = self.chb_width/2;
}
@end
