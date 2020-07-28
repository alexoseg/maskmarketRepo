//
//  ParseGetter.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/15/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "ParseGetter.h"
#import "UserBuilder.h"
#import "PurchasedObjBuilder.h"
#import "MaskListingBuilder.h"
#import "BoughtListingBuilder.h"
#import "QueryBuilder.h"

@implementation ParseGetter

static NSString *const kDescription = @"description";
static NSString *const kTitle = @"title";
static NSString *const kCity = @"city";
static NSString *const kState = @"state";
static NSString *const kAuthorUsername = @"authorUsername";
static NSString *const kAuthorEmail = @"authorEmail";
static NSString *const kAuthorID = @"authorID";
static NSString *const kPrice = @"price";
static NSString *const kImage = @"image";
static NSString *const kPurchasedArray = @"purchasedArray";
static NSString *const kMaskQuantity = @"maskQuantity";
static NSString *const kListings = @"Listings";
static NSString *const kPurchasedObjs = @"PurchasedObjs";
static NSString *const kUserID = @"userID";
static NSString *const kListingID = @"listingID";
static NSString *const kObjectID = @"objectId";
static NSString *const kSpent = @"spent";
static NSString *const kBuyerUsername = @"buyerUsername";
static NSString *const kCompleted = @"completed";
static NSString *const kTrackingNumber = @"trackingNumber";

+ (void)fetchAllListingsWithCompletion:(void (^)(NSArray * _Nullable, NSError * _Nullable))completion
{
    NSArray<NSString *> *const keyArray = @[kDescription, kTitle, kCity, kState, kAuthorUsername, kAuthorEmail, kAuthorID, kPrice, kPurchasedArray, kMaskQuantity, kImage];
    PFQuery *const query = [QueryBuilder buildQueryWithClassName:kListings
                                                        whereKey:kMaskQuantity
                                                     greaterThan:@0
                                                   includingKeys:keyArray
                                                           limit:20];
    
    [query findObjectsInBackgroundWithBlock:completion];
}

+ (void)fetchCurrentUserSellingsWithCompletion:(void (^)(NSArray * _Nullable, NSError * _Nullable))completion
{
    User *const currentUser = [UserBuilder buildUserfromPFUser:[PFUser currentUser]];
    NSArray<NSString *> *const keyArray = @[kDescription, kTitle, kCity, kState, kAuthorUsername, kAuthorEmail, kAuthorID, kPrice, kPurchasedArray, kMaskQuantity, kImage];
    PFQuery *const query = [QueryBuilder buildQueryWithClassName:kListings
                                                        whereKey:kAuthorID
                                                         equalTo:currentUser.userID
                                                   includingKeys:keyArray
                                                           limit:20];
    [query findObjectsInBackgroundWithBlock:completion];
}

+ (void)fetchListingsBoughtByUserID:(NSString *)userID
                     withCompletion:(void (^)(NSArray<BoughtListing *> * _Nullable objects, NSError * _Nullable error))completion
{
    NSArray<NSString *> *const keyArray = @[kListingID, kUserID, kMaskQuantity, kSpent, kBuyerUsername, kCompleted, kTrackingNumber];
    PFQuery *const query = [QueryBuilder buildQueryWithClassName:kPurchasedObjs
                                                        whereKey:kUserID
                                                         equalTo:userID
                                                   includingKeys:keyArray
                                                           limit:20];
    
    typeof(self) __weak weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        typeof(weakSelf) strongSelf = weakSelf;
        if(strongSelf == nil){
            return;
        }
        if(error) {
            completion(nil, error);
            return;
        }
        
        NSArray<PurchaseObj *> *const purchasedObjs = [PurchasedObjBuilder buildPurchaseObjArrayfromArray:objects];
        NSArray<PFQuery *> *const queryObjects = [QueryBuilder buildQueryArrayFromPurchasedArray:purchasedObjs
                                                                                   withClassName:kListings
                                                                                        queryKey:kObjectID];
        NSDictionary<NSString *, NSArray<PurchaseObj *> *> *const purchaseMap = [strongSelf mapListingsToPurchasedObjs:purchasedObjs];
        
        if (queryObjects.count != 0) {
            PFQuery *const listingsQuery = [PFQuery orQueryWithSubqueries:queryObjects];
            [listingsQuery findObjectsInBackgroundWithBlock:^(NSArray<PFObject *> * _Nullable maskListings, NSError * _Nullable error) {
                if(error) {
                    completion(nil, error);
                    return;
                }
                NSMutableArray<BoughtListing *> *const boughtListingArray = [NSMutableArray new];
                for (PFObject *const mask in maskListings) {
                    ParseMaskListing *const maskListing = [MaskListingBuilder buildMaskListingFromPFObject:mask];
                    NSArray<PurchaseObj *> *const purchases = purchaseMap[maskListing.listingId];
                    for (PurchaseObj *const purchased in purchases) {
                        BoughtListing *const boughtListing = [BoughtListingBuilder buildBoughtListingFromPurchased:purchased
                                                                                                  parseMaskListing:maskListing];
                        [boughtListingArray addObject:boughtListing];
                    }
                }
                completion(boughtListingArray, nil);
            }];
        } else {
            completion([NSArray new], nil);
        }
    }];
}

+ (void)fetchPurchasedObjectsWithListingID:(NSString *)listingID
                            withCompletion:(void (^)(NSArray<PurchaseObj *> * _Nullable, NSError * _Nullable))completion
{
    NSArray<NSString *> *const keyArray = @[kListingID, kUserID, kMaskQuantity, kSpent];
    PFQuery *const query = [QueryBuilder buildQueryWithClassName:kPurchasedObjs
                                                        whereKey:kListingID
                                                         equalTo:listingID
                                                   includingKeys:keyArray
                                                           limit:20];
    [query findObjectsInBackgroundWithBlock:^(NSArray<PFObject *> * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
        } else {
            NSArray<PurchaseObj *> *const purchaseObjs = [PurchasedObjBuilder buildPurchaseObjArrayfromArray:objects];
            completion(purchaseObjs, nil);
        }
    }];
}

+ (NSDictionary<NSString *, NSArray<PurchaseObj *> *> *)mapListingsToPurchasedObjs:(NSArray<PurchaseObj *> *)purchasedObjs
{
    NSMutableDictionary<NSString *, NSMutableArray<PurchaseObj *> *> *const purchaseMap = [NSMutableDictionary new];
    
    for (PurchaseObj *const purchasedObj in purchasedObjs) {
        NSString *const maskListingID = purchasedObj.listingID;
        NSMutableArray<PurchaseObj *> *purchases = purchaseMap[maskListingID];
        if (purchases == nil) {
            purchases = [NSMutableArray new];
            purchaseMap[maskListingID] = purchases;
        }
        [purchases addObject:purchasedObj];
    }
    
    return [purchaseMap copy];
}

@end
