//
//  ParseMaskListing.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/15/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MaskListing.h"

NS_ASSUME_NONNULL_BEGIN

@interface ParseMaskListing : MaskListing

@property (nonatomic, strong, readonly) NSString *listingId;
@property (nonatomic, strong, readonly) NSDate *createdAt;
@property (nonatomic, strong, readonly) User * _Nullable purchasedBy;

- (instancetype)initWithListingId:(NSString *)listingId
                        createdAt:(NSDate *)createdAt
                  maskDescription:(NSString *)maskDescription
                            title:(NSString *)title
                             city:(NSString *)city
                            state:(NSString *)state
                           author:(User *)author
                            price:(int)price
                        purchased:(BOOL)purchased
                      purchasedBy:(User * _Nullable)purchasedBy
                        maskImage:(PFFileObject *)maskImage;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
