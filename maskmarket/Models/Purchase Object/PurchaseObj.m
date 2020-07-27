//
//  PurchaseObj.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/20/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "PurchaseObj.h"

@implementation PurchaseObj

- (instancetype)initWithUserId:(NSString *)userID
                 purchaseObjID:(NSString *)purchaseObjID
                     listingID:(NSString *)listingID
                  maskQuantity:(int)maskQuantity
                         spent:(int)spent
               purchasedOnDate:(NSDate *)purchasedOnDate
                 buyerUsername:(NSString *)buyerUsername
                trackingNumber:(NSString *)trackingNumber
                     completed:(BOOL)completed;
{
    self = [super init];
    
    if (self) {
        _userID = userID;
        _purchaseObjID = purchaseObjID; 
        _listingID = listingID;
        _maskQuantity = maskQuantity;
        _spent = spent;
        _purchasedOnDate = purchasedOnDate;
        _buyerUsername = buyerUsername;
        _trackingNumber = trackingNumber;
        _completed = completed;
    }
    
    return self;
}

@end
