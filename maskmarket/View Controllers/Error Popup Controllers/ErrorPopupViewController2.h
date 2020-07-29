//
//  ErrorPopupCViewController2.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/28/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ErrorPopupViewControllerDelegate;

@interface ErrorPopupViewController2 : UIViewController

@property (nonatomic, weak) id<ErrorPopupViewControllerDelegate> delegate;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithMessage:(NSString *)message;

@end

@protocol ErrorPopupViewControllerDelegate

- (void)tryAgainAction;

@end

NS_ASSUME_NONNULL_END
