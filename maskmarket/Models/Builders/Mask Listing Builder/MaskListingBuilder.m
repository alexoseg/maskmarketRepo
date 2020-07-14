//
//  MaskListingBuilder.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/14/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "MaskListingBuilder.h"

static NSString *const kDescription = @"description";
static NSString *const kTitle = @"title";
static NSString *const kCity = @"city";
static NSString *const kState = @"state";
static NSString *const kAuthor = @"author";
static NSString *const kPrice = @"price";
static NSString *const kPurchased = @"purchased";
static NSString *const kPurchasedBy = @"purchasedBy";
static NSString *const kImage = @"image";

@implementation MaskListingBuilder

+ (MaskListing *)buildMaskListingFromPFObject:(PFObject *)object
{
    NSString *const objectId = object.objectId;
    NSDate *const createdAt = object.createdAt;
    NSString *const description = object[kDescription];
    NSString *const title = object[kTitle];
    NSString *const city = object[kCity];
    NSString *const state = object[kState];
    PFUser *const author = object[kAuthor];
    NSNumber *const price = object[kPrice];
    NSNumber *const purchased = object[kPurchased];
    PFUser *const purchasedBy = object[kPurchasedBy];
    PFFileObject *const image = object[kImage];
    
    if ( objectId == nil
        || createdAt == nil
        || description == nil
        || title == nil
        || city == nil
        || state == nil
        || author == nil
        || price == nil
        || purchased == nil
        || image == nil ) {
        
        return nil;
    }
    
    return [[MaskListing alloc] initWithListingId:objectId
                                        createdAt:createdAt
                                  maskDescription:description
                                            title:title
                                             city:city
                                            state:state
                                           author:author
                                            price:[price intValue]
                                        purchased:[purchased boolValue]
                                      purchasedBy:purchasedBy
                                        maskImage:image];
}

@end
