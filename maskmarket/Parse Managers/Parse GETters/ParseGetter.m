//
//  ParseGetter.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/15/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "ParseGetter.h"
#import "UserBuilder.h"

@implementation ParseGetter

static NSString *const kDescription = @"description";
static NSString *const kTitle = @"title";
static NSString *const kCity = @"city";
static NSString *const kState = @"state";
static NSString *const kAuthorUsername = @"authorUsername";
static NSString *const kAuthorEmail = @"authorEmail";
static NSString *const kAuthorID = @"authorID";
static NSString *const kPrice = @"price";
static NSString *const kImage = @"image";
static NSString *const kPurchasedArray = @"purchasedArray";
static NSString *const kMaskQuantity = @"maskQuantity";
static NSString *const kListings = @"Listings";

+ (void)fetchAllListingsWithCompletion:(void (^)(NSArray * _Nullable, NSError * _Nullable))completion
{
    PFQuery *const query = [PFQuery queryWithClassName:kListings];
    [query whereKey:kMaskQuantity greaterThan:@(0)];
    
    [query includeKey:kDescription];
    [query includeKey:kTitle];
    [query includeKey:kCity];
    [query includeKey:kState];
    [query includeKey:kAuthorUsername];
    [query includeKey:kAuthorEmail];
    [query includeKey:kAuthorID];
    [query includeKey:kPrice];
    [query includeKey:kPurchasedArray];
    [query includeKey:kMaskQuantity];
    [query includeKey:kImage];
    
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:completion];
}

+ (void)fetchCurrentUserSellingsWithCompletion:(void (^)(NSArray * _Nullable, NSError * _Nullable))completion
{
    PFQuery *const query = [PFQuery queryWithClassName:kListings];
    User *const currentUser = [UserBuilder buildUserfromPFUser:[PFUser currentUser]];
    
    [query whereKey:kAuthorID equalTo:currentUser.userID];
    
    [query includeKey:kDescription];
    [query includeKey:kTitle];
    [query includeKey:kCity];
    [query includeKey:kState];
    [query includeKey:kAuthorUsername];
    [query includeKey:kAuthorEmail];
    [query includeKey:kAuthorID];
    [query includeKey:kPrice];
    [query includeKey:kPurchasedArray];
    [query includeKey:kMaskQuantity];
    [query includeKey:kImage];
    
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:completion];
}

@end
