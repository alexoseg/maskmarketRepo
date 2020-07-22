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
                     listingID:(NSString *)listingID
                  maskQuantity:(int)maskQuantity
                         spent:(int)spent
               purchasedOnDate:(NSDate *)purchasedOnDate;
{
    self = [super init];
    
    if (self) {
        _userID = userID;
        _listingID = listingID;
        _maskQuantity = maskQuantity;
        _spent = spent;
        _purchasedOnDate = purchasedOnDate;
    }
    
    return self;
}

@end
