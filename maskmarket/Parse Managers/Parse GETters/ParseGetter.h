//
//  ParseGetter.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/15/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "BoughtListing.h"
#import "PurchasedObjBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface ParseGetter : NSObject

+ (void)fetchCurrentUserSellingsWithCompletion:(void (^)(NSArray * _Nullable, NSError * _Nullable))completion;

+ (void)fetchAllListingsWithCompletion:(void (^)(NSArray * _Nullable objects, NSError * _Nullable error))completion;

+ (void)fetchListingsBoughtByUserID:(NSString *)userID
                     withCompletion:(void (^)(NSArray<BoughtListing *> * _Nullable objects, NSError * _Nullable error))completion;

+ (void)fetchPurchasedObjectsWithListingID:(NSString *)listingID
                            withCompletion:(void (^)(NSArray<PurchaseObj *> * _Nullable objects, NSError * _Nullable error))completion;

+ (void)fetchUserWithID:(NSString *)userID
         withCompletion:(void (^)(PFObject * _Nullable object, NSError * _Nullable error))completion;

+ (void)fetchListingsBoughtAfter:(NSDate *)date
                  withCompletion:(void (^)(NSArray * _Nullable objects, NSError * _Nullable error))completion;
        
- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
