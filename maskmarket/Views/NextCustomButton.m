//
//  NextCustomButton.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/13/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "NextCustomButton.h"

#pragma mark - Implementation

@implementation NextCustomButton

#pragma mark - Lifecycle

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUpButton];
}

#pragma mark - Setup

- (void)setUpButton
{
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.backgroundColor = [UIColor colorWithRed:38.0f/255.0f
                                              green:184.0f/255.0f
                                               blue:153.0f/255.0f
                                              alpha:1.0f];
    UIImage *const nextImage = [UIImage imageNamed:@"next.png"];
    [self setImage:nextImage forState:UIControlStateNormal];
    self.imageEdgeInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
}

@end
