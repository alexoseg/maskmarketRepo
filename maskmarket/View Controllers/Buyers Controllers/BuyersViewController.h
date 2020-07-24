//
//  BuyersViewController.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/23/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseMaskListing.h"

NS_ASSUME_NONNULL_BEGIN

@interface BuyersViewController : UIViewController

@property (nonatomic, strong) ParseMaskListing* maskListing;

@end

NS_ASSUME_NONNULL_END
