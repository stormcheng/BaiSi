//
//  CHBLoginTextField.m
//  BuDeJie11
//
//  Created by ibokanwisdom on 16/7/21.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import "CHBLoginTextField.h"
#import "UITextField+CHBPlaceholderColor.h"
@implementation CHBLoginTextFiled

-(void)awakeFromNib{
    self.tintColor = [UIColor whiteColor];
    [self addTarget:self action:@selector(beginEditing) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(endEditing) forControlEvents:UIControlEventEditingDidEnd];
}
-(void)beginEditing{
    self.chb_placeholderColor = [UIColor whiteColor];
}
-(void)endEditing{
    self.chb_placeholderColor = nil;
}
@end
