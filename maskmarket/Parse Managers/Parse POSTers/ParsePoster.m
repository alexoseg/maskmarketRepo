//
//  ParsePoster.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/13/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "ParsePoster.h"

static NSString *const kDescription = @"description";
static NSString *const kTitle = @"title";
static NSString *const kCity = @"city";
static NSString *const kState = @"state";
static NSString *const kAuthorUsername = @"authorUsername";
static NSString *const kAuthorEmail = @"authorEmail";
static NSString *const kAuthorID = @"authorID";
static NSString *const kPrice = @"price";
static NSString *const kMaskQuantity = @"maskQuantity";
static NSString *const kImage = @"image";
static NSString *const kListings = @"Listings";
static NSString *const kPurchasedArray = @"purchasedArray";
static NSString *const kPurchasedObjs = @"PurchasedObjs";
static NSString *const kUserID = @"userID";
static NSString *const kListingID = @"listingID";
static NSString *const kSpent = @"spent";

@implementation ParsePoster

+ (void)purchaseListingWithId:(NSString *)maskListingId
            amountToPurchase:(int)amountToPurchase
                  amountSpent:(int)amountSpent
               withCompletion:(PFBooleanResultBlock _Nullable)completion
{
    PFQuery *const query = [PFQuery queryWithClassName:kListings];
    [query getObjectInBackgroundWithId:maskListingId
                                 block:^(PFObject * _Nullable listing, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            User *const purchasedByUser = [UserBuilder buildUserfromPFUser:[PFUser currentUser]];
            int const updatedQuantity = [listing[kMaskQuantity] intValue] - amountToPurchase;
            listing[kMaskQuantity] = [NSNumber numberWithInt:updatedQuantity];
            
            PFObject *const purchasedObject = [PFObject objectWithClassName:kPurchasedObjs];
            purchasedObject[kUserID] = purchasedByUser.userID;
            purchasedObject[kListingID] = maskListingId;
            purchasedObject[kMaskQuantity] = [NSNumber numberWithInt:amountToPurchase];
            purchasedObject[kSpent] = [NSNumber numberWithInt:amountSpent];
            
            [purchasedObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                [listing addObject:purchasedObject.objectId forKey:kPurchasedArray];
                [listing saveInBackgroundWithBlock:completion];
            }];
        }
    }];
}

+ (void)createListingFromListing:(MaskListing *)maskListing
                 withCompletion:(nonnull PFBooleanResultBlock)completion
{
    PFObject *const listing = [PFObject objectWithClassName:kListings];
    
    listing[kDescription] = maskListing.maskDescription;
    listing[kTitle] = maskListing.title;
    listing[kCity] = maskListing.city;
    listing[kState] = maskListing.state;
    listing[kAuthorUsername] = maskListing.author.username;
    listing[kAuthorEmail] = maskListing.author.email;
    listing[kAuthorID] = maskListing.author.userID;
    listing[kPrice] = [NSNumber numberWithInt:maskListing.price];
    listing[kMaskQuantity] = [NSNumber numberWithInt:maskListing.maskQuantity];
    listing[kImage] = maskListing.maskImage;
    listing[kPurchasedArray] = @[];
    
    [listing saveInBackgroundWithBlock:completion];
}

+ (void)createAccountWithUsername:(NSString *)username
                            email:(NSString *)email
                         password:(NSString *)password
                   withCompletion:(PFBooleanResultBlock)completion
{
    PFUser *const user = [PFUser user];
    user.username = [username copy];
    user.email = [email copy];
    user.password = [password copy];
    
    [user signUpInBackgroundWithBlock:completion];
}

+ (void)loginWithUsername:(NSString *)username
              password:(NSString *)password
        withCompletion:(void (^)(PFUser * _Nullable, NSError * _Nullable))completion
{
    NSString *const copyUsername = [username copy];
    NSString *const copyPassword = [password copy];
    
    [PFUser logInWithUsernameInBackground:copyUsername
                                 password:copyPassword
                                    block:completion];
}

@end
