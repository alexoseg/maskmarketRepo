//
//  ParseMaskListing.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/15/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MaskListing.h"
#import "PurchaseObj.h"

NS_ASSUME_NONNULL_BEGIN

@interface ParseMaskListing : MaskListing

@property (nonatomic, strong, readonly) NSString *listingId;
@property (nonatomic, strong, readonly) NSDate *createdAt;
@property (nonatomic, strong, readonly) NSDictionary<NSString *, NSNumber *> *purchasedDict;
@property (nonatomic, readonly) BOOL actionRequired;

- (instancetype)initWithListingId:(NSString *)listingId
                        createdAt:(NSDate *)createdAt
                  maskDescription:(NSString *)maskDescription
                            title:(NSString *)title
                             city:(NSString *)city
                            state:(NSString *)state
                           author:(ParseUser *)author
                            price:(int)price
                     maskQuantity:(int)maskQuantity
                   purchasedDict:(NSDictionary<NSString *, NSNumber *> *)purchasedDict
                        maskImage:(PFFileObject *)maskImage
                   actionRequired:(BOOL)actionRequired;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
