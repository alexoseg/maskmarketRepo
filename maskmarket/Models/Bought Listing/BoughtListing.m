//
//  BoughtListing.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/21/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "BoughtListing.h"

@implementation BoughtListing

- (instancetype)initWithListingID:(NSString *)listingID
                    purchaseObjID:(NSString *)purchaseObjID
                     maskQuantity:(int)maskQuantity
                  maskDescription:(NSString *)maskDescription
                            title:(NSString *)title
                             city:(NSString *)city
                            state:(NSString *)state
                        maskImage:(PFFileObject *)maskImage
                            spent:(int)spent
                      purchasedOn:(NSDate *)purchasedOn
                   sellerUsername:(NSString *)sellerUsername
                            price:(int)price
                    buyerUsername:(NSString *)buyerUsername
                   trackingNumber:(NSString *)trackingNumber
                        completed:(BOOL)completed
{
    self = [super init];
    
    if (self) {
        _listingID = listingID;
        _purchaseObjID = purchaseObjID;
        _maskQuantity = maskQuantity;
        _maskDescription = maskDescription;
        _title = title;
        _city = city;
        _state = state;
        _maskImage = maskImage;
        _spent = spent;
        _purchasedOn = purchasedOn;
        _sellerUsername = sellerUsername;
        _price = price;
        _buyerUsername = buyerUsername;
        _trackingNumber = trackingNumber;
        _completed = completed;
    }
    
    return self;
}

@end
