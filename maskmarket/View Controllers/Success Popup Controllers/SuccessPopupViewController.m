//
//  SuccessPopupViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/29/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "SuccessPopupViewController.h"
#import "GeneralPopupView.h"
#import "UIColor+AppColors.h"

#pragma mark - Interface

@interface SuccessPopupViewController ()

#pragma mark - Properties

@property (strong, nonatomic) NSString *popupMessage;

@end

#pragma mark - Implementation

@implementation SuccessPopupViewController

#pragma mark - Initializers

- (instancetype)initWithMessage:(NSString *)message
{
    self = [super init];
    if (self) {
        _popupMessage = message;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    
    return self;
}

#pragma mark - Lifecylce

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpViews];
}

#pragma mark - Action Methods

- (void)onTapOkay
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    if (self.delegate != nil) {
        [self.delegate okayAction];
    }
}

#pragma mark - Setup

- (void)setUpViews
{
    self.view.backgroundColor = [UIColor popUpViewBackgroundAlphaHalf];
    GeneralPopupView *const popupView = [[GeneralPopupView alloc] initSuccessPopupWithMessage:_popupMessage];
    [self.view addSubview:popupView];
    
    [popupView.heightAnchor constraintEqualToConstant:250].active = YES;
    [popupView.widthAnchor constraintEqualToConstant:250].active = YES;
    [popupView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [popupView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [popupView.rightButton addTarget:self
                                 action:@selector(onTapOkay)
                       forControlEvents:UIControlEventTouchUpInside];
}

@end
