//
//  ErrorPopupCViewController2.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/28/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "ErrorPopupViewController.h"
#import "UIColor+AppColors.h"
#import "ErrorPopupView.h"

#pragma mark - Interface

@interface ErrorPopupViewController ()

#pragma mark - Properties

@property (nonatomic, strong) NSString *popUpMessage;
@property (nonatomic) BOOL addCancel;

@end

#pragma mark - Implementation

@implementation ErrorPopupViewController

#pragma mark - Initializers

- (instancetype)initWithMessage:(NSString *)message
                      addCancel:(BOOL)addCancel
{
    self = [super init];
    if (self) {
        _popUpMessage = [message copy];
        _addCancel = addCancel;
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

- (void)onTapCancel
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
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
    ErrorPopupView *const popupView = [[ErrorPopupView alloc] initWithMessage:_popUpMessage addCancel:_addCancel];
    [self.view addSubview:popupView];
    
    [popupView.heightAnchor constraintEqualToConstant:250].active = YES;
    [popupView.widthAnchor constraintEqualToConstant:250].active = YES;
    [popupView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [popupView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [popupView.tryAgainButton addTarget:self
                                 action:@selector(onTapTryAgain)
                       forControlEvents:UIControlEventTouchUpInside];
    if (_addCancel) {
        [popupView.cancelButton addTarget:self
                                   action:@selector(onTapCancel)
                         forControlEvents:UIControlEventTouchUpInside];
    }
}

@end
