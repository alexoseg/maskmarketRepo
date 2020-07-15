//
//  ParseGetter.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/15/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "ParseGetter.h"

@implementation ParseGetter

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

+ (void)fetchAllListingsWithCompletion:(void (^)(NSArray * _Nullable, NSError * _Nullable))completion
{
    PFQuery *const query = [PFQuery queryWithClassName:@"Listings"];
    [query whereKey:@"purchased" equalTo:@NO];
    
    [query includeKey:kDescription];
    [query includeKey:kTitle];
    [query includeKey:kCity];
    [query includeKey:kState];
    [query includeKey:kAuthorUsername];
    [query includeKey:kAuthorEmail];
    [query includeKey:kAuthorID];
    [query includeKey:kPrice];
    [query includeKey:kPurchased];
    [query includeKey:kPurchasedUsername];
    [query includeKey:kPurchasedEmail];
    [query includeKey:kPurchasedID];
    [query includeKey:kImage];
    
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:completion];
}

@end
