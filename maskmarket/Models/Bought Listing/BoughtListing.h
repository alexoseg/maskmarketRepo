//
//  BoughtListing.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/21/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface BoughtListing : NSObject

@property (nonatomic, strong, readonly) NSString *listingID;
@property (nonatomic, readonly) int maskQuantity;
@property (nonatomic, strong, readonly) NSString *maskDescription;
@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *city;
@property (nonatomic, strong, readonly) NSString *state;
@property (nonatomic, strong, readonly) PFFileObject *maskImage;
@property (nonatomic, readonly) int spent;
@property (nonatomic, strong, readonly) NSDate *purchasedOn;
@property (nonatomic, strong, readonly) NSString *sellerUsername;
@property (nonatomic, readonly) int price;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithListingID:(NSString *)listingID
                     maskQuantity:(int)maskQuantity
                  maskDescription:(NSString *)maskDescription
                            title:(NSString *)title
                             city:(NSString *)city
                            state:(NSString *)state
                        maskImage:(PFFileObject *)maskImage
                            spent:(int)spent
                      purchasedOn:(NSDate *)purchasedOn
                   sellerUsername:(NSString *)sellerUsername
                            price:(int)price;

@end

NS_ASSUME_NONNULL_END
