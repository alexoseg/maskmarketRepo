//
//  PurchasedObjBuilder.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/20/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "PurchasedObjBuilder.h"

static NSString *const kUserID = @"userID";
static NSString *const klistingID = @"listingID";
static NSString *const kMaskQuantity = @"maskQuantity";

@implementation PurchasedObjBuilder

+ (PurchaseObj *)buildPurchaseObjFromPFObject:(PFObject *)object
{
    NSString *const userIDString = object[kUserID];
    NSString *const listingIDString = object[klistingID];
    NSNumber *const maskQuantityCopy = object[kMaskQuantity];
       
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

+ (NSArray<PurchaseObj *> *)buildPurchaseObjArrayfromArray:(NSArray<PFObject *> *)objects
{
    NSMutableArray<PurchaseObj *> *const arrayOfPurchaseObjs = [NSMutableArray new];
    for (PFObject *const object in objects) {
        PurchaseObj *const purchasObj = [self buildPurchaseObjFromPFObject:object];
        if (purchasObj == nil) {
            return nil;
        }
        [arrayOfPurchaseObjs addObject:purchasObj];
    }
    
    return [arrayOfPurchaseObjs copy];
}

@end
