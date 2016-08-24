//
//  CHBCollectionViewCell.m
//  BuDeJie11
//
//  Created by ibokanwisdom on 16/7/21.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import "CHBCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "CHBCollectionItem.h"
@interface CHBCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *iconLable;

@end

@implementation CHBCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)setItem:(CHBCollectionItem *)item{
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:item.icon] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.iconLable.text = item.name;
    [self sizeToFit];
}
@end
