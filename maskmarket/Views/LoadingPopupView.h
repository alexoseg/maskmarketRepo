//
//  LoadingPopupView.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/22/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoadingPopupView : UIView

+ (void)showLoadingPopupAddedTo:(UIView *)parentView
                    withMessage:(NSString *)message; 

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
