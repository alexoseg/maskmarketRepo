//
//  ErrorPopupView.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/28/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GeneralPopupView : UIView

@property (strong, nonatomic) UIButton *rightButton;
@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic, readonly) UIImageView *iconImageView;
@property (strong, nonatomic, readonly) UILabel *messageLabel;

- (instancetype)initErrorPopupWithMessage:(NSString *)message
                                addCancel:(BOOL)addCancel;

- (instancetype)initSuccessPopupWithMessage:(NSString *)message;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
