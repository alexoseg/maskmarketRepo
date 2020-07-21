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

+ (void)fetchAllListingsWithCompletion:(void (^)(NSArray * _Nullable, NSError * _Nullable))completion
{
    PFQuery *const query = [PFQuery queryWithClassName:kListings];
    [query whereKey:kMaskQuantity greaterThan:@(0)];
    
    [query includeKey:kDescription];
    [query includeKey:kTitle];
    [query includeKey:kCity];
    [query includeKey:kState];
    [query includeKey:kAuthorUsername];
    [query includeKey:kAuthorEmail];
    [query includeKey:kAuthorID];
    [query includeKey:kPrice];
    [query includeKey:kPurchasedArray];
    [query includeKey:kMaskQuantity];
    [query includeKey:kImage];
    
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:completion];
}

+ (void)fetchCurrentUserSellingsWithCompletion:(void (^)(NSArray * _Nullable, NSError * _Nullable))completion
{
    PFQuery *const query = [PFQuery queryWithClassName:kListings];
    User *const currentUser = [UserBuilder buildUserfromPFUser:[PFUser currentUser]];
    
    [query whereKey:kAuthorID equalTo:currentUser.userID];
    
    [query includeKey:kDescription];
    [query includeKey:kTitle];
    [query includeKey:kCity];
    [query includeKey:kState];
    [query includeKey:kAuthorUsername];
    [query includeKey:kAuthorEmail];
    [query includeKey:kAuthorID];
    [query includeKey:kPrice];
    [query includeKey:kPurchasedArray];
    [query includeKey:kMaskQuantity];
    [query includeKey:kImage];
    
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:completion];
}

+ (void)fetchListingsBoughtByUserID:(NSString *)userID
                     withCompletion:(void (^)(NSArray<BoughtListing *> * _Nullable objects, NSError * _Nullable error))completion
{
    PFQuery *const query = [PFQuery queryWithClassName:kPurchasedObjs];
    [query whereKey:kUserID equalTo:userID];
    [query includeKey:kListingID];
    [query includeKey:kUserID];
    [query includeKey:kMaskQuantity];
    query.limit = 20;
    
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
        NSArray<PFQuery *> *const queryObjects = [strongSelf buildQueryArrayFromPurchasedArray:purchasedObjs];
        NSDictionary<NSString *, NSArray<PurchaseObj *> *> *const purchaseMap = [strongSelf mapListingsToPurchasedObjs:purchasedObjs];
        
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
    }];
}

+ (NSArray<PFQuery *> *)buildQueryArrayFromPurchasedArray:(NSArray<PurchaseObj *> *)purchasedObjs
{
    NSMutableArray<PFQuery *> *const queryObjects = [NSMutableArray new];
    
    for (PurchaseObj *const purchasedObj in purchasedObjs) {
        PFQuery *const subQuery = [PFQuery queryWithClassName:kListings];
        [subQuery whereKey:kObjectID equalTo:purchasedObj.listingID];
        [queryObjects addObject:subQuery];
    }
    
    return [queryObjects copy];
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
