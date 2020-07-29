//
//  ErrorPopupView.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/28/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "GeneralPopupView.h"
#import "UIColor+AppColors.h"

@implementation GeneralPopupView

- (instancetype)initErrorPopupWithMessage:(NSString *)message
                                addCancel:(BOOL)addCancel
{
    self = [super initWithFrame:CGRectMake(0, 0, 250.0f, 250.0f)];
    if (self) {
        [self setUpGeneralViewsWithMessage:message];
        [self setUpErrorViewWithCancel:addCancel];
    }
    return self;
}

- (void)setUpGeneralViewsWithMessage:(NSString *)message
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundColor = [UIColor primaryAppColor];
    self.layer.cornerRadius = 10.0;
    self.clipsToBounds = YES;
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    _iconImageView.clipsToBounds = YES;
    _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_iconImageView];
    
    [_iconImageView.heightAnchor constraintEqualToConstant:80].active = YES;
    [_iconImageView.widthAnchor constraintEqualToConstant:80].active = YES;
    [_iconImageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [_iconImageView.topAnchor constraintEqualToAnchor:self.topAnchor
                                            constant:15].active = YES;
    
    _messageLabel = [UILabel new];
    _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _messageLabel.numberOfLines = 0;
    _messageLabel.text = message;
    _messageLabel.textColor = UIColor.whiteColor;
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:14.0f];
    [self addSubview:_messageLabel];
    
    [_messageLabel.topAnchor constraintEqualToAnchor:_iconImageView.bottomAnchor
                                           constant:25].active = YES;
    [_messageLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor
                                               constant:15].active = YES;
    [self.trailingAnchor constraintEqualToAnchor:_messageLabel.trailingAnchor
                                        constant:15].active = YES;
}
                   
- (void)setUpErrorViewWithCancel:(BOOL)cancel
{
    _iconImageView.image = [UIImage imageNamed:@"warning"];
    
    _rightButton = [UIButton new];
    _rightButton.translatesAutoresizingMaskIntoConstraints = NO;
    _rightButton.backgroundColor = [UIColor popUpViewBackgroundAlphaHalf];
    [_rightButton setTitle:@"Try Again"
                     forState:UIControlStateNormal];
    [_rightButton setTitleColor:UIColor.whiteColor
                          forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:14.0f];
    _rightButton.userInteractionEnabled = YES;
    [self addSubview:_rightButton];
    
    [_rightButton.heightAnchor constraintEqualToConstant:40].active = YES;
    [_rightButton.topAnchor constraintGreaterThanOrEqualToAnchor:_messageLabel.bottomAnchor
                                                           constant:15].active = YES;
    [_rightButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [_rightButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    
    if (!cancel) {
        [_rightButton.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
        UIView *const topBorderLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1.0f)];
        topBorderLine.backgroundColor = [UIColor popUpViewBackgroundAlphaHalf];
        [_rightButton addSubview:topBorderLine];
        return;
    }
    
    _leftButton = [UIButton new];
    _leftButton.translatesAutoresizingMaskIntoConstraints = NO;
    _leftButton.backgroundColor = [UIColor popUpViewBackgroundAlphaHalf];
    [_leftButton setTitle:@"Cancel"
                   forState:UIControlStateNormal];
    [_leftButton setTitleColor:UIColor.whiteColor
                        forState:UIControlStateNormal];
    _leftButton.titleLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:14.0f];
    _leftButton.userInteractionEnabled = YES;
    [self addSubview:_leftButton];
    
    [_leftButton.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [_leftButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [_leftButton.heightAnchor constraintEqualToConstant:40].active = YES;
    [_leftButton.trailingAnchor constraintEqualToAnchor:_rightButton.leadingAnchor
                                                 constant:0].active = YES;
    [_leftButton.widthAnchor constraintEqualToAnchor:self.widthAnchor
                                            multiplier:0.5].active = YES;

    UIView *const centerBorderLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1.0f, 40.0f)];
    centerBorderLine.backgroundColor = [UIColor popUpViewBackgroundAlphaHalf];
    [_rightButton addSubview:centerBorderLine];
    
    UIView *const topRightBorderLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 2, 1.0f)];
    topRightBorderLine.backgroundColor = [UIColor popUpViewBackgroundAlphaHalf];
    [_rightButton addSubview:topRightBorderLine];

    UIView *const topLeftBorderLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 2, 1.0f)];
    topLeftBorderLine.backgroundColor = [UIColor popUpViewBackgroundAlphaHalf];
    [_leftButton addSubview:topLeftBorderLine];
}



@end
