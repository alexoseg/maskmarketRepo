//
//  SaleCompletionViewController.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/24/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoughtListing.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SaleCompletionDelegate

- (void)didCompleteSale;

@end

@interface SaleCompletionViewController : UIViewController

@property (nonatomic, strong) BoughtListing *boughListing;
@property (nonatomic, weak) id<SaleCompletionDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
