//
//  ErrorPopupView.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/28/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ErrorPopupView : UIView

@property (strong, nonatomic) UIButton *tryAgainButton;
@property (strong, nonatomic) UIButton *cancelButton;

- (instancetype)initWithMessage:(NSString *)message
                      addCancel:(BOOL)addCancel;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
