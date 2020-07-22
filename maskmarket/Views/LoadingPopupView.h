//
//  LoadingPopupView.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/22/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <Lottie/Lottie.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoadingPopupView : UIView

@property (nonatomic, strong) UIView *modalView;
@property (nonatomic, strong) LOTAnimationView *animation;
@property (nonatomic, strong) UILabel *messageLabel;

+ (void)showLoadingPopupAddedTo:(UIView *)parentView
                    withMessage:(NSString *)message;

+ (void)hideLoadingPopupAddedTo:(UIView *)parentView;

- (instancetype)initWithView:(UIView *)parentView
                     message:(NSString *)message;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
