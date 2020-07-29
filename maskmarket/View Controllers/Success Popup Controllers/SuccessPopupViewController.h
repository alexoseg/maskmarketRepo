//
//  SuccessPopupViewController.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/29/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SuccessPopupDelegate;

@interface SuccessPopupViewController : UIViewController

@property (nonatomic, weak) id<SuccessPopupDelegate> delegate;

- (instancetype)initWithMessage:(NSString *)message;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

@protocol SuccessPopupDelegate

- (void)okayAction;

@end

NS_ASSUME_NONNULL_END
