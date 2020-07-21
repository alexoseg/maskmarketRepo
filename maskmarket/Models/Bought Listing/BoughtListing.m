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
                     maskQuantity:(int)maskQuantity
                  maskDescription:(NSString *)maskDescription
                            title:(NSString *)title
                             city:(NSString *)city
                            state:(NSString *)state
                        maskImage:(PFFileObject *)maskImage
{
    self = [super init];
    
    if (self) {
        _listingID = listingID;
        _maskQuantity = maskQuantity;
        _maskDescription = maskDescription;
        _title = title;
        _city = city;
        _state = state;
        _maskImage = maskImage;
    }
    
    return self;
}

@end
