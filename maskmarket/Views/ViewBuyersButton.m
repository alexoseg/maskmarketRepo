//
//  ViewBuyersButton.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/23/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "ViewBuyersButton.h"

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
    [self.layer setBorderColor:[UIColor colorWithRed:38.0f/255.0f
                                               green:184.0f/255.0f
                                                blue:153.0f/255.0f
                                               alpha:1.0f].CGColor];
}

@end
