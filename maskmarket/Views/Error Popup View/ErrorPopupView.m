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
                      addCancel:(BOOL)addCancel
{
    self = [super initWithFrame:CGRectMake(0, 0, 250.0f, 250.0f)];
    if (self) {
        [self setUpViewsWithMessage:message
                          addCancel:addCancel];
    }
    return self;
}
                   
- (void)setUpViewsWithMessage:(NSString *)message
                    addCancel:(BOOL)addCancel
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
    [_tryAgainButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [_tryAgainButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    
    if (!addCancel) {
        [_tryAgainButton.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
        UIView *const topBorderLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1.0f)];
        topBorderLine.backgroundColor = [UIColor popUpViewBackgroundAlphaHalf];
        [_tryAgainButton addSubview:topBorderLine];
        return;
    }
    
    _cancelButton = [UIButton new];
    _cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
    _cancelButton.backgroundColor = [UIColor popUpViewBackgroundAlphaHalf];
    [_cancelButton setTitle:@"Cancel"
                   forState:UIControlStateNormal];
    [_cancelButton setTitleColor:UIColor.whiteColor
                        forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:14.0f];
    _cancelButton.userInteractionEnabled = YES;
    [self addSubview:_cancelButton];
    
    [_cancelButton.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [_cancelButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [_cancelButton.heightAnchor constraintEqualToConstant:40].active = YES;
    [_cancelButton.trailingAnchor constraintEqualToAnchor:_tryAgainButton.leadingAnchor
                                                 constant:0].active = YES;
    [_cancelButton.widthAnchor constraintEqualToAnchor:self.widthAnchor
                                            multiplier:0.5].active = YES;

    UIView *const centerBorderLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1.0f, 40.0f)];
    centerBorderLine.backgroundColor = [UIColor popUpViewBackgroundAlphaHalf];
    [_tryAgainButton addSubview:centerBorderLine];
    
    UIView *const topRightBorderLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 2, 1.0f)];
    topRightBorderLine.backgroundColor = [UIColor popUpViewBackgroundAlphaHalf];
    [_tryAgainButton addSubview:topRightBorderLine];

    UIView *const topLeftBorderLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 2, 1.0f)];
    topLeftBorderLine.backgroundColor = [UIColor popUpViewBackgroundAlphaHalf];
    [_cancelButton addSubview:topLeftBorderLine];
}

@end
