//
//  MaskListingBuilder.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/14/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "MaskListingBuilder.h"
#import "PurchasedObjBuilder.h"
#import "ParseGetter.h"

static NSString *const kDescription = @"description";
static NSString *const kTitle = @"title";
static NSString *const kCity = @"city";
static NSString *const kState = @"state";
static NSString *const kAuthorUsername = @"authorUsername";
static NSString *const kAuthorEmail = @"authorEmail";
static NSString *const kAuthorID = @"authorID";
static NSString *const kPrice = @"price";
static NSString *const kImage = @"image";
static NSString *const kMaskQuantity = @"maskQuantity";
static NSString *const kPurchasedDict = @"purchasedDict";

@implementation MaskListingBuilder

+ (ParseMaskListing *)buildMaskListingFromPFObject:(PFObject *)object
{
    NSString *const objectId = object.objectId;
    NSDate *const createdAt = object.createdAt;
    NSString *const description = object[kDescription];
    NSString *const title = object[kTitle];
    NSString *const city = object[kCity];
    NSString *const state = object[kState];
    NSNumber *const price = object[kPrice];
    NSNumber *const maskQuantity = object[kMaskQuantity];
    NSDictionary<NSString *, NSNumber *> *const purchasedObjs = object[kPurchasedDict];
    
    
    PFFileObject *const image = object[kImage];
    ParseUser *const author = [UserBuilder builderParseUserFromID:object[kAuthorID]
                                                         username:object[kAuthorUsername]
                                                            email:object[kAuthorEmail]];
  
    if ( objectId == nil
        || createdAt == nil
        || description == nil
        || title == nil
        || city == nil
        || state == nil
        || author == nil
        || price == nil
        || maskQuantity == nil
        || image == nil ) {
        
        return nil;
    }
    
    BOOL actionRequired = NO;
    for (NSString *const listingID in purchasedObjs) {
        BOOL value = [purchasedObjs[listingID] boolValue];
        if (value == NO) {
            actionRequired = YES;
            break;
        }
    }
    
    return [[ParseMaskListing alloc] initWithListingId:objectId
                                             createdAt:createdAt
                                       maskDescription:description
                                                 title:title
                                                  city:city
                                                 state:state
                                                author:author
                                                 price:[price intValue]
                                          maskQuantity:[maskQuantity intValue]
                                        purchasedDict:purchasedObjs
                                             maskImage:image
                                        actionRequired:actionRequired];
}

- (MaskListing *)buildLocalMaskListing
{
    if (self.listingTitle == nil
        || self.listingImage == nil
        || self.listingCity == nil
        || self.listingState == nil
        || self.listingDescription == nil
        || self.listingPrice == nil
        || self.listingMaskQuantity == nil) {

        return nil;
    }
    
    ParseUser *const currentUser = [UserBuilder buildUserfromPFUser:[PFUser currentUser]];
    
    NSData *const imageData = UIImagePNGRepresentation(self.listingImage);
    PFFileObject *const fileObject = [PFFileObject fileObjectWithName:@"image.png" data:imageData];
    
    return [[MaskListing alloc] initWithMaskDescription:self.listingDescription
                                                  title:self.listingTitle
                                                   city:self.listingCity
                                                  state:self.listingState
                                                 author:currentUser
                                                  price:[self.listingPrice intValue]
                                           maskQuantity:[self.listingMaskQuantity intValue]
                                              maskImage:fileObject];
}

+ (NSArray<ParseMaskListing *> *)buildParseMaskListingsFromArray:(NSArray<PFObject *> *)listings
{
    NSMutableArray<ParseMaskListing *> *const arrayOfMaskListings = [NSMutableArray new];
    for (PFObject *const listingObject in listings) {
        ParseMaskListing *const listing = (ParseMaskListing *)[self buildMaskListingFromPFObject:listingObject];
        if (listing == nil) {
            return nil;
        }
        [arrayOfMaskListings addObject:listing];
    }
    
    return [arrayOfMaskListings copy];
}
@end
