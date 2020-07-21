//
//  BoughtDetailsViewController.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/21/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoughtListing.h"

NS_ASSUME_NONNULL_BEGIN

@interface BoughtDetailsViewController : UIViewController

@property (nonatomic, strong) BoughtListing *boughtListing;

@end

NS_ASSUME_NONNULL_END
