//
//  MaskListingBuilder.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/14/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MaskListing.h"
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface MaskListingBuilder : NSObject

+ (nullable MaskListing *)buildMaskListingFromPFObject:(PFObject *)object;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
