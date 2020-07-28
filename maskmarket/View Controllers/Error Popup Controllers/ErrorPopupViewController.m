//
//  ErrorPopupViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/28/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "ErrorPopupViewController.h"

#pragma mark - Interface

@interface ErrorPopupViewController ()

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UIView *popUpView;

@end

#pragma mark - Implementation

@implementation ErrorPopupViewController

#pragma mark - Lifecylce

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpViews];
}

#pragma mark - Gesture Recognizers

- (IBAction)onTapTryAgain:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

#pragma mark - Setup

- (void)setUpViews
{
    _popUpView.layer.cornerRadius = 5.0;
}

@end
