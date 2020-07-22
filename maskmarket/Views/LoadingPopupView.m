//
//  LoadingPopupView.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/22/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "LoadingPopupView.h"
#import <Lottie/Lottie.h>

@implementation LoadingPopupView

+ (void)showLoadingPopupAddedTo:(UIView *)parentView
             withMessage:(NSString *)message
{
    UIColor *const parentColor = [UIColor colorWithRed:0.5
                                                 green:0.5
                                                  blue:0.5
                                                 alpha:0];
    UIColor *const modalColor = [UIColor colorWithRed:38.0f/255.0f
                                                green:184.0f/255.0f
                                                 blue:153.0f/255.0f
                                                alpha:0];
    
    UIView *const screenView = [[UIView alloc] initWithFrame:CGRectZero];
    screenView.backgroundColor = parentColor;
    screenView.translatesAutoresizingMaskIntoConstraints = NO;
    [parentView addSubview:screenView];
    [screenView.widthAnchor constraintEqualToAnchor:parentView.widthAnchor
                                         multiplier:1.0].active = YES;
    [screenView.heightAnchor constraintEqualToAnchor:parentView.heightAnchor
                                          multiplier:1.0].active = YES;
    
    UIView *const modalView = [[UIView alloc] initWithFrame:CGRectZero];
    modalView.backgroundColor = modalColor;
    modalView.translatesAutoresizingMaskIntoConstraints = NO;
    modalView.clipsToBounds = YES;
    modalView.layer.cornerRadius = 8;
    [screenView addSubview:modalView];
    [modalView.centerXAnchor constraintEqualToAnchor:screenView.centerXAnchor].active = YES;
    [modalView.centerYAnchor constraintEqualToAnchor:screenView.centerYAnchor].active = YES;
    [modalView.widthAnchor constraintEqualToAnchor:screenView.widthAnchor
                                        multiplier:0.5].active = YES;
    [modalView.heightAnchor constraintEqualToAnchor:screenView.heightAnchor
                                         multiplier:0.23].active = YES;
    
    LOTAnimationView *const animation = [LOTAnimationView animationNamed:@"loadwheel"];
    animation.loopAnimation = YES;
    animation.translatesAutoresizingMaskIntoConstraints = NO;
    [modalView addSubview:animation];
    [animation.centerXAnchor constraintEqualToAnchor:modalView.centerXAnchor].active = YES;
    [animation.topAnchor constraintEqualToAnchor:modalView.topAnchor
                                        constant:0].active = YES;
    [animation.widthAnchor constraintEqualToConstant:100].active = YES;
    [animation.heightAnchor constraintEqualToConstant:100].active = YES;
    [animation play];
    
    UILabel *const messageLabel = [UILabel new];
    messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    messageLabel.text = message;
    messageLabel.textColor = UIColor.whiteColor;
    messageLabel.font = [UIFont fontWithName:@"Montserrat-SemiBold" size:14.0f];
    [modalView addSubview:messageLabel];
    [messageLabel.centerXAnchor constraintEqualToAnchor:modalView.centerXAnchor].active = YES;
    [messageLabel.topAnchor constraintEqualToAnchor:animation.bottomAnchor
                                           constant:15].active = YES;
    
    
    [UIView animateWithDuration:0.3
                     animations:^{
        screenView.backgroundColor = [UIColor colorWithRed:0.5
                                                     green:0.5
                                                      blue:0.5
                                                     alpha:0.5];
        modalView.backgroundColor = [UIColor colorWithRed:38.0f/255.0f
                                                    green:184.0f/255.0f
                                                     blue:153.0f/255.0f
                                                    alpha:1.0];
    }];
    
}

@end
