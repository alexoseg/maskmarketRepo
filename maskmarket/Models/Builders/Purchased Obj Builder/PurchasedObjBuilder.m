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
static NSString *const kSpent = @"spent";
static NSString *const kBuyerUsername = @"buyerUsername";
static NSString *const kCompleted = @"completed";
static NSString *const kTrackingNumber = @"trackingNumber";

@implementation PurchasedObjBuilder

+ (PurchaseObj *)buildPurchaseObjFromPFObject:(PFObject *)object
{
    NSString *const purchaseObjID = object.objectId;
    NSString *const userIDString = object[kUserID];
    NSString *const listingIDString = object[klistingID];
    NSNumber *const maskQuantityCopy = object[kMaskQuantity];
    NSNumber *const spent = object[kSpent];
    NSDate *const purchasedOnDate = object.createdAt;
    NSString *const buyerUsername = object[kBuyerUsername];
    NSNumber *const completed = object[kCompleted];
    NSString *const trackingNumber = object[kTrackingNumber];
       
    if (userIDString == nil
        || purchaseObjID == nil
        || listingIDString == nil
        || maskQuantityCopy == nil
        || spent == nil
        || purchasedOnDate == nil
        || buyerUsername == nil
        || completed == nil
        || trackingNumber == nil)
    {
        return nil;
    }
       
    return [[PurchaseObj alloc] initWithUserId:userIDString
                                 purchaseObjID:purchaseObjID
                                     listingID:listingIDString
                                  maskQuantity:[maskQuantityCopy intValue]
                                         spent:[spent intValue]
                                purchasedOnDate:purchasedOnDate
                                 buyerUsername:buyerUsername
                                trackingNumber:trackingNumber
                                     completed:[completed boolValue]];
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
