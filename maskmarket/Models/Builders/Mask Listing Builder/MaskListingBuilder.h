//
//  MaskListingBuilder.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/14/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MaskListing.h"
#import "ParseMaskListing.h"
#import <Parse/Parse.h>
#import "UserBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface MaskListingBuilder : NSObject

@property (nonatomic, strong) NSString *listingTitle;
@property (nonatomic, strong) UIImage *listingImage;
@property (nonatomic, strong) NSString *listingCity;
@property (nonatomic, strong) NSString *listingState;
@property (nonatomic, strong) NSString *listingDescription;
@property (nonatomic, strong) NSNumber *listingPrice;

+ (nullable MaskListing *)buildMaskListingFromPFObject:(PFObject *)object;

- (nullable MaskListing *)buildLocalMaskListing;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
