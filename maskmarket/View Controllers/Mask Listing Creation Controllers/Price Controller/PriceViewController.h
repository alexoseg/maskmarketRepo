//
//  PriceViewController.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/14/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaskListingBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PriceViewControllerDelegate;

@interface PriceViewController : UIViewController

@property (nonatomic, strong) MaskListingBuilder *builder;
@property (nonatomic, weak) id<PriceViewControllerDelegate> delegate;

@end

@protocol PriceViewControllerDelegate

- (void)didCreateListing;

@end

NS_ASSUME_NONNULL_END
