//
//  EmptySellingView.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/30/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "EmptyBackgroundView.h"

@implementation EmptyBackgroundView

- (instancetype)initWithImageName:(NSString *)imageName
                            title:(NSString *)title
                          message:(NSString *)message
{
    self = [super initWithFrame:CGRectMake(0, 0, 300, 600)];
    if (self) {
        [self setUpViewWithImageName:imageName
                               title:title
                             message:message];
    }
    
    return self;
}

- (void)setUpViewWithImageName:(NSString *)imageName
                         title:(NSString *)title
                       message:(NSString *)message
{
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *const iconImageView = [UIImageView new];
    iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    iconImageView.clipsToBounds = YES;
    iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    iconImageView.image = [UIImage imageNamed:imageName];
    [self addSubview:iconImageView];
    
    [iconImageView.heightAnchor constraintEqualToConstant:100].active = YES;
    [iconImageView.widthAnchor constraintEqualToConstant:100].active = YES;
    [iconImageView.topAnchor constraintEqualToAnchor:self.topAnchor
                                            constant:100].active = YES;
    [iconImageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    
    UILabel *const titleLabel = [UILabel new];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.numberOfLines = 1;
    titleLabel.text = title;
    titleLabel.textColor = UIColor.blackColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Montserrat-SemiBold" size:18.0f];
    [self addSubview:titleLabel];
    
    [titleLabel.topAnchor constraintEqualToAnchor:iconImageView.bottomAnchor
                                         constant:15].active = YES;
    [titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor
                                             constant:15].active = YES;
    [titleLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor
                                              constant:-15].active = YES;
    
    
    UILabel *const messageLabel = [UILabel new];
    messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    messageLabel.numberOfLines = 0;
    messageLabel.text = message;
    messageLabel.textColor = UIColor.blackColor;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:16.0f];
    [self addSubview:messageLabel];
    
    [messageLabel.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor
                                         constant:15].active = YES;
    [messageLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor
                                             constant:15].active = YES;
    [messageLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor
                                              constant:-15].active = YES;
}

@end
