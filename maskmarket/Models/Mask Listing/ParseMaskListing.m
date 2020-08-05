//
//  ParseMaskListing.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/15/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "ParseMaskListing.h"

@implementation ParseMaskListing

- (instancetype)initWithListingId:(NSString *)listingId
                        createdAt:(NSDate *)createdAt
                  maskDescription:(NSString *)maskDescription
                            title:(NSString *)title
                             city:(NSString *)city
                            state:(NSString *)state
                           author:(ParseUser *)author
                            price:(int)price
                     maskQuantity:(int)maskQuantity
                    purchasedDict:(NSDictionary<NSString *, NSNumber *> *)purchasedDict
                        maskImage:(PFFileObject *)maskImage
                   actionRequired:(BOOL)actionRequired;
{
    self = [super initWithMaskDescription:maskDescription
                                    title:title
                                     city:city
                                    state:state
                                   author:author
                                    price:price
                                maskQuantity:maskQuantity
                                maskImage:maskImage];
    
    if (self) {
        _listingId = listingId;
        _createdAt = createdAt;
        _purchasedDict = purchasedDict;
        _actionRequired = actionRequired; 
    }
    
    return self;
}

@end
