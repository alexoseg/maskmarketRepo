//
//  FloatingActionButton.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/29/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "FloatingActionButton.h"
#import "UIColor+AppColors.h"

@implementation FloatingActionButton

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUpButton];
}

- (void)setUpButton
{
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.shadowOpacity = 0.25;
    self.layer.shadowRadius = 5;
    self.layer.shadowOffset = CGSizeMake(0, 5);
    
    self.backgroundColor = [UIColor primaryAppColor];
    self.tintColor = UIColor.whiteColor;
    UIImage *const nextImage = [UIImage imageNamed:@"plus"];
    [self setImage:nextImage forState:UIControlStateNormal];
    self.imageEdgeInsets = UIEdgeInsetsMake(18.0f, 18.0f, 18.0f, 18.0f);
}

@end
