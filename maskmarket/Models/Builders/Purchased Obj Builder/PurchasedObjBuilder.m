//
//  PurchasedObjBuilder.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/20/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "PurchasedObjBuilder.h"

static NSString *const kUserID = @"userID";
static NSString *const kMaskID = @"maskID";
static NSString *const kMaskQuantity = @"maskQuantity";

@implementation PurchasedObjBuilder

+ (PurchaseObj *)buildPurchasObjWithUserID:(NSString *)userID
                                 listingID:(NSString *)listingID
                              maskQuantity:(NSNumber *)maskQuantity
{
    NSString *const userIDString = [userID copy];
    NSString *const listingIDString = [listingID copy];
    NSNumber *const maskQuantityCopy = maskQuantity;
    
    if (userIDString == nil
        || listingIDString == nil
        || maskQuantityCopy == nil)
    {
        return nil;
    }
    
    return [[PurchaseObj alloc] initWithUserId:userIDString
                                     listingID:listingIDString
                                  maskQuantity:[maskQuantityCopy intValue]];
}

@end
