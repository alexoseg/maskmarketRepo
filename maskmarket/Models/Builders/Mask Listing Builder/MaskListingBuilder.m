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
static NSString *const kAuthorUsername = @"authorUsername";
static NSString *const kAuthorEmail = @"authorEmail";
static NSString *const kAuthorID = @"authorID";
static NSString *const kPrice = @"price";
static NSString *const kPurchased = @"purchased";
static NSString *const kPurchasedUsername = @"purchasedUsername";
static NSString *const kPurchasedEmail = @"purchasedEmail";
static NSString *const kPurchasedID = @"purchasedID";
static NSString *const kImage = @"image";

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
    NSNumber *const purchased = object[kPurchased];
    PFFileObject *const image = object[kImage];
    
    User *const author = [UserBuilder buildUserFromUserID:object[kAuthorID]
                                                 username:object[kAuthorUsername]
                                                    email:object[kAuthorEmail]];
    User *const purchasedBy = [UserBuilder buildUserFromUserID:object[kPurchasedID]
                                                      username:object[kPurchasedUsername]
                                                         email:object[kPurchasedEmail]];
    
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
    
    
    return [[ParseMaskListing alloc] initWithListingId:objectId
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

- (MaskListing *)buildLocalMaskListing
{
    if (self.listingTitle == nil
        || self.listingImage == nil
        || self.listingCity == nil
        || self.listingState == nil
        || self.listingDescription == nil
        || self.listingPrice == nil ) {

        return nil;
    }
    
    User *const currentUser = [UserBuilder buildUserfromPFUser:[PFUser currentUser]];
    
    NSData *const imageData = UIImagePNGRepresentation(self.listingImage);
    PFFileObject *const fileObject = [PFFileObject fileObjectWithName:@"image.png" data:imageData];
    
    return [[MaskListing alloc] initWithMaskDescription:self.listingTitle
                                                  title:self.listingTitle
                                                   city:self.listingCity
                                                  state:self.listingState
                                                 author:currentUser
                                                  price:[self.listingPrice intValue]
                                              purchased:[@0 boolValue]
                                              maskImage:fileObject];
}

+ (NSArray<ParseMaskListing *> *)buildParseMaskListingsFromArray:(NSArray<PFObject *> *)listings
{
    NSMutableArray<ParseMaskListing *> *const arrayOfMaskListings = [NSMutableArray new];
    for (PFObject *listingObject in listings) {
        ParseMaskListing *const listing = (ParseMaskListing *)[self buildMaskListingFromPFObject:listingObject];
        if (listing == nil) {
            return nil;
        }
        [arrayOfMaskListings addObject:listing];
    }
    
    return [arrayOfMaskListings copy];
}

@end
