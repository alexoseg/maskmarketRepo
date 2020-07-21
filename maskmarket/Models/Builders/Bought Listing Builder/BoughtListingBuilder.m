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
    int const maskQuantity = purchaseObj.maskQuantity;
    NSString *const maskDescription = maskListing.maskDescription;
    NSString *const title = maskListing.title;
    NSString *const city = maskListing.city;
    NSString *const state = maskListing.state;
    PFFileObject *const maskImage = maskListing.maskImage;
    
    if (listingID == nil
        || maskDescription == nil
        || title == nil
        || city == nil
        || state == nil
        || maskImage == nil
        || maskQuantity == 0)
    {
        return nil;
    }
    
    return [[BoughtListing alloc] initWithListingID:listingID
                                       maskQuantity:maskQuantity
                                    maskDescription:maskDescription
                                              title:title
                                               city:city
                                              state:state
                                          maskImage:maskImage]; 
}

@end
