//
//  ErrorPopupCViewController2.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/28/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "ErrorPopupViewController2.h"
#import "UIColor+AppColors.h"
#import "ErrorPopupView.h"

#pragma mark - Interface

@interface ErrorPopupViewController2 ()

#pragma mark - Properties

@property (nonatomic, strong) NSString *popUpMessage;

@end

#pragma mark - Implementation

@implementation ErrorPopupViewController2

#pragma mark - Initializers

- (instancetype)initWithMessage:(NSString *)message
{
    self = [super init];
    if (self) {
        _popUpMessage = [message copy];
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    
    return self;
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpViews];
}

#pragma mark - Gesture Actions

- (void)onTapTryAgain
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    if (self.delegate != nil) {
        [self performTryAgainAction];
    }
}

#pragma mark - Delegate Methods

- (void)performTryAgainAction
{
    [self.delegate tryAgainAction];
}

#pragma mark - Setup

- (void)setUpViews
{
    self.view.backgroundColor = [UIColor popUpViewBackgroundAlphaHalf];
    ErrorPopupView *const popupView = [[ErrorPopupView alloc] initWithMessage:_popUpMessage];
    [self.view addSubview:popupView];
    
    [popupView.heightAnchor constraintEqualToConstant:250].active = YES;
    [popupView.widthAnchor constraintEqualToConstant:250].active = YES;
    [popupView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [popupView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [popupView.tryAgainButton addTarget:self
                                 action:@selector(onTapTryAgain)
                       forControlEvents:UIControlEventTouchUpInside];
}

@end
