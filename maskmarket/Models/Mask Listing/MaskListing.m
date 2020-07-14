//
//  MaskListing.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/13/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "MaskListing.h"

@implementation MaskListing

- (instancetype)initWithListingId:(NSString *)listingId
                        createdAt:(NSDate *)createdAt
                  maskDescription:(NSString *)maskDescription
                            title:(NSString *)title
                             city:(NSString *)city
                            state:(NSString *)state
                           author:(PFUser *)author
                            price:(int)price
                        purchased:(BOOL)purchased
                      purchasedBy:(PFUser *)purchasedBy
                        maskImage:(PFFileObject *)maskImage
{
    self = [super init];
    
    if (self) {
        _listingId = listingId;
        _createdAt = createdAt;
        _maskDescription = maskDescription;
        _title = title;
        _city = city;
        _state = state;
        _author = author;
        _price = price;
        _purchased = purchased;
        _purchasedBy = purchasedBy;
        _maskImage = maskImage;
    }
    
    return self;
}

@end
