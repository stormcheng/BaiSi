//
//  CHBSubtagCell.m
//  BuDeJie11
//
//  Created by ibokanwisdom on 16/7/20.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import "CHBSubtagCell.h"
#import "CHBTagItem.h"
#import <UIButton+WebCache.h>
@interface CHBSubtagCell ()
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@property (weak, nonatomic) IBOutlet UILabel *followLable;
@end
@implementation CHBSubtagCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)setFrame:(CGRect)frame{
    frame.size.height -= 1;
    [super setFrame:frame];
}
-(void)setItem:(CHBTagItem *)item{
    _item = item;
    [self.iconBtn sd_setImageWithURL:[NSURL URLWithString:item.image_list] forState:UIControlStateNormal];
    self.iconBtn.layer.cornerRadius = 25;
    self.iconBtn.layer.masksToBounds = YES;
    self.nameLable.text = item.theme_name;
    CGFloat number = [item.sub_number intValue];
    if (number >= pow(10, 4)) {
        self.followLable.text = [NSString stringWithFormat:@"%.2f万",number/pow(10, 4)];
    }else{
    self.followLable.text = item.sub_number;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

@end
