//
//  FullImageViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/27/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "FullImageViewController.h"

#pragma mark - Interface

@interface FullImageViewController ()

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UIImageView *maskImageView;

@end

#pragma mark - Implementation

@implementation FullImageViewController

#pragma mark - Lifecycles

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpViews];
}

#pragma mark - Setup

- (void)setUpViews
{
    [_maskImageView setImage:_maskImage];
}

@end
