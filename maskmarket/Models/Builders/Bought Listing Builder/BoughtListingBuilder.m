//
//  BoughtListingBuilder.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/21/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "BoughtListingBuilder.h"

@implementation BoughtListingBuilder

+ (nullable BoughtListing *)buildBoughtListingFromPurchased:(PurchaseObj *)purchaseObj
                                             parseMaskListing:(ParseMaskListing *)maskListing
{
    NSString *const listingID = purchaseObj.listingID;
    NSString *const purchaseObjID = purchaseObj.purchaseObjID;
    int const maskQuantity = purchaseObj.maskQuantity;
    int const spent = purchaseObj.spent;
    NSDate *const purchasedOnDate = purchaseObj.purchasedOnDate;
    NSString *const buyerUsername = purchaseObj.buyerUsername;
    NSString *const trackingNumber = purchaseObj.trackingNumber;
    NSString *const maskDescription = maskListing.maskDescription;
    NSString *const title = maskListing.title;
    NSString *const city = maskListing.city;
    NSString *const state = maskListing.state;
    PFFileObject *const maskImage = maskListing.maskImage;
    NSString *const sellerUsername = maskListing.author.username;
    int const price = maskListing.price;
    BOOL const completed = purchaseObj.completed;
    
    if (listingID == nil
        || purchaseObjID == nil
        || maskDescription == nil
        || title == nil
        || city == nil
        || state == nil
        || maskImage == nil
        || maskQuantity == 0
        || purchasedOnDate == nil
        || sellerUsername == nil
        || buyerUsername == nil
        || trackingNumber == nil)
    {
        return nil;
    }
    
    return [[BoughtListing alloc] initWithListingID:listingID
                                      purchaseObjID:purchaseObjID
                                       maskQuantity:maskQuantity
                                    maskDescription:maskDescription
                                              title:title
                                               city:city
                                              state:state
                                          maskImage:maskImage
                                              spent:spent
                                        purchasedOn:purchasedOnDate
                                     sellerUsername:sellerUsername
                                              price:price
                                      buyerUsername:buyerUsername
                                     trackingNumber:trackingNumber
                                          completed:completed];
}

+ (NSArray<BoughtListing *> *)buildBoughtListingArrayFromArray:(NSArray<PurchaseObj *> *)purchasedObjs
                                             associatedListing:(ParseMaskListing *)maskListing
{
    NSMutableArray<BoughtListing *> *const boughtListings = [NSMutableArray new];
    for (PurchaseObj *const purchaseObj in purchasedObjs) {
        BoughtListing *const boughtListing = [self buildBoughtListingFromPurchased:purchaseObj
                                                                  parseMaskListing:maskListing];
        if (boughtListing == nil) {
            return nil;
        }
        [boughtListings addObject:boughtListing];
    }
    
    return [boughtListings copy];
}

@end
