//
//  ErrorPopupView.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/28/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "ErrorPopupView.h"
#import "UIColor+AppColors.h"

@implementation ErrorPopupView

- (instancetype)initWithMessage:(NSString *)message
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setUpViewsWithMessage:message];
    }
    return self;
}
                   
- (void)setUpViewsWithMessage:(NSString *)message
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundColor = [UIColor primaryAppColor];
    self.layer.cornerRadius = 10.0;
    self.clipsToBounds = YES;
    
    UIImageView *const iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    iconImageView.clipsToBounds = YES;
    iconImageView.image = [UIImage imageNamed:@"warning"];
    iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:iconImageView];
    
    [iconImageView.heightAnchor constraintEqualToConstant:80].active = YES;
    [iconImageView.widthAnchor constraintEqualToConstant:80].active = YES;
    [iconImageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [iconImageView.topAnchor constraintEqualToAnchor:self.topAnchor
                                            constant:15].active = YES;
    
    UILabel *const messageLabel = [UILabel new];
    messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    messageLabel.numberOfLines = 0;
    messageLabel.text = message;
    messageLabel.textColor = UIColor.whiteColor;
    messageLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:14.0f];
    [self addSubview:messageLabel];
    
    [messageLabel.topAnchor constraintEqualToAnchor:iconImageView.bottomAnchor
                                           constant:30].active = YES;
    [messageLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor
                                               constant:15].active = YES;
    [messageLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor
                                                constant:15].active = YES;
    
    _tryAgainButton = [UIButton new];
    _tryAgainButton.translatesAutoresizingMaskIntoConstraints = NO;
    _tryAgainButton.backgroundColor = [UIColor popUpViewBackgroundAlphaHalf];
    [_tryAgainButton setTitle:@"Try Again"
                     forState:UIControlStateNormal];
    [_tryAgainButton setTitleColor:UIColor.whiteColor
                          forState:UIControlStateNormal];
    _tryAgainButton.titleLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:14.0f];
    _tryAgainButton.userInteractionEnabled = YES;
    [self addSubview:_tryAgainButton];
    
    [_tryAgainButton.heightAnchor constraintEqualToConstant:40].active = YES;
    [_tryAgainButton.topAnchor constraintGreaterThanOrEqualToAnchor:messageLabel.bottomAnchor
                                                          constant:15].active = YES;
    [_tryAgainButton.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [_tryAgainButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [_tryAgainButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
}

@end
