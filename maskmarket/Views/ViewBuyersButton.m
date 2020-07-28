//
//  ViewBuyersButton.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/23/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "ViewBuyersButton.h"
#import "UIColor+AppColors.h"

@implementation ViewBuyersButton

#pragma mark - Lifecycle

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUpButton];
}

#pragma mark - Setup

- (void)setUpButton
{
    self.layer.cornerRadius = 5;
    self.contentEdgeInsets = UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
    [self.layer setBorderWidth:1.0f];
    [self.layer setBorderColor:[UIColor primaryAppColor].CGColor];
}

@end
