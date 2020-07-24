//
//  BoughtListingBuilder.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/21/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoughtListing.h"
#import "PurchaseObj.h"
#import "ParseMaskListing.h"

NS_ASSUME_NONNULL_BEGIN

@interface BoughtListingBuilder : NSObject

+ (nullable BoughtListing *)buildBoughtListingFromPurchased:(PurchaseObj *)purchaseObj
                                           parseMaskListing:(ParseMaskListing *)maskListing;

+ (nullable NSArray<BoughtListing *> *)buildBoughtListingArrayFromArray:(NSArray<PurchaseObj *> *)purchasedObjs
                                                      associatedListing:(ParseMaskListing *)maskListing;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
