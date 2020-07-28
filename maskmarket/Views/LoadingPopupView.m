//
//  LoadingPopupView.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/22/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "LoadingPopupView.h"
#import "UIColor+AppColors.h"

#pragma mark - Implementation

@implementation LoadingPopupView

#pragma mark - Initializers

- (instancetype)initWithView:(UIView *)parentView
                     message:(NSString *)message
{
    self = [super initWithFrame:parentView.bounds];
    if (self) {
       [self setUpViewsWithMessage:message];
    }
    return self;
}

#pragma mark - Class Methods

+ (void)showLoadingPopupAddedTo:(UIView *)parentView
                    withMessage:(NSString *)message
{
    LoadingPopupView *const popUpView = [[LoadingPopupView alloc] initWithView:parentView
                                                                       message:message];
    [parentView addSubview:popUpView];
    [popUpView.widthAnchor constraintEqualToAnchor:parentView.widthAnchor
                                        multiplier:1.0].active = YES;
    [popUpView.heightAnchor constraintEqualToAnchor:parentView.heightAnchor
                                         multiplier:1.0].active = YES;
}

+ (void)hideLoadingPopupAddedTo:(UIView *)parentView
{
    LoadingPopupView *const popUpView = [self loadingPopUpInView:parentView];
    if (popUpView == nil) {
        return;
    }
    
    [UIView animateWithDuration:0.3
                     animations:^{
        popUpView.backgroundColor = [UIColor popUpViewBackgroundAlpha0];
        popUpView.modalView.backgroundColor = [UIColor primaryAppColorAlpha0];
    } completion:^(BOOL finished) {
        [popUpView removeFromSuperview];
    }];
}

+ (LoadingPopupView *)loadingPopUpInView:(UIView *)parentView
{
    for (UIView *const subview in parentView.subviews) {
        if ([subview isKindOfClass:self]) {
            LoadingPopupView *const popUpView = (LoadingPopupView *)subview;
            return popUpView;
        }
    }
    return nil;
}

#pragma mark - Set up

- (void)setUpViewsWithMessage:(NSString *)message
{
    UIColor *const parentColor = [UIColor popUpViewBackgroundAlpha0];
    UIColor *const modalColor = [UIColor primaryAppColorAlpha0];
    self.backgroundColor = parentColor;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.modalView = [[UIView alloc] initWithFrame:CGRectZero];
    self.modalView.backgroundColor = modalColor;
    self.modalView.translatesAutoresizingMaskIntoConstraints = NO;
    self.modalView.clipsToBounds = YES;
    self.modalView.layer.cornerRadius = 8;
    [self addSubview:self.modalView];
    [self.modalView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [self.modalView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    [self.modalView.widthAnchor constraintEqualToAnchor:self.widthAnchor
                                             multiplier:0.5].active = YES;
    [self.modalView.heightAnchor constraintEqualToAnchor:self.heightAnchor
                                              multiplier:0.23].active = YES;
    
    self.animation = [LOTAnimationView animationNamed:@"loadwheel"];
    self.animation.loopAnimation = YES;
    self.animation.translatesAutoresizingMaskIntoConstraints = NO;
    [self.modalView addSubview:self.animation];
    [self.animation.centerXAnchor constraintEqualToAnchor:self.modalView.centerXAnchor].active = YES;
    [self.animation.topAnchor constraintEqualToAnchor:self.modalView.topAnchor
                                             constant:0].active = YES;
    [self.animation.widthAnchor constraintEqualToConstant:100].active = YES;
    [self.animation.heightAnchor constraintEqualToConstant:100].active = YES;
    [self.animation play];
    
    self.messageLabel = [UILabel new];
    self.messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.messageLabel.text = message;
    self.messageLabel.textColor = UIColor.whiteColor;
    self.messageLabel.font = [UIFont fontWithName:@"Montserrat-SemiBold" size:14.0f];
    [self.modalView addSubview:self.messageLabel];
    [self.messageLabel.centerXAnchor constraintEqualToAnchor:self.modalView.centerXAnchor].active = YES;
    [self.messageLabel.topAnchor constraintEqualToAnchor:self.animation.bottomAnchor
                                                constant:15].active = YES;
    
    typeof(self) __weak weakSelf = self;
    [UIView animateWithDuration:0.3
                     animations:^{
        typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        strongSelf.backgroundColor = [UIColor popUpViewBackgroundAlphaHalf];
        strongSelf.modalView.backgroundColor = [UIColor primaryAppColor];
    }];
}

@end
