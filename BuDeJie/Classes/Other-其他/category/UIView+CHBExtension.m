//
//  UIView+CHBExtension.m
//  iOS_百思不得姐项目
//
//  Created by ibokanwisdom on 16/7/8.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import "UIView+CHBExtension.h"

@implementation UIView (CHBExtension)
-(void)setChb_x:(CGFloat)chb_x{
    CGRect frame = self.frame;
    frame.origin.x = chb_x;
    self.frame = frame;
}
-(CGFloat)chb_x{
    return self.frame.origin.x;
}
-(void)setChb_y:(CGFloat)chb_y{
    CGRect frame = self.frame;
    frame.origin.y = chb_y;
    self.frame = frame;
}
-(CGFloat)chb_y{
    return self.frame.origin.y;
}
-(void)setChb_width:(CGFloat)chb_width{
    CGRect frame = self.frame;
    frame.size.width = chb_width;
    self.frame = frame;
}
-(CGFloat)chb_width{
    return self.frame.size.width;
}
-(void)setChb_height:(CGFloat)chb_height{
    CGRect frame = self.frame;
    frame.size.height = chb_height;
    self.frame = frame;
}
-(CGFloat)chb_height{
    return self.frame.size.height;
}
-(void)setChb_bottom:(CGFloat)chb_bottom{
    self.chb_y = chb_bottom -self.chb_height;
}
-(CGFloat)chb_bottom{
    return self.chb_y+self.chb_height;
}
-(void)setChb_right:(CGFloat)chb_right{
    self.chb_x = chb_right - self.chb_width;
}
-(CGFloat)chb_right{
    return self.chb_x + self.chb_width;
}
-(CGFloat)chb_center_x{
    return self.center.x;
}
-(void)setChb_center_x:(CGFloat)chb_center_x{
    self.chb_x = chb_center_x - (self.chb_width /2);
}
-(CGFloat)chb_center_y{
    return self.center.y;
}
-(void)setChb_center_y:(CGFloat)chb_center_y{
    self.chb_y = chb_center_y - (self.chb_height /2);

}

+(instancetype)viewFromNib {
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}
@end
