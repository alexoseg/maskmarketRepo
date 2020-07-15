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
static NSString *const kPurchased = @"purchased";
static NSString *const kPurchasedUsername = @"purchasedUsername";
static NSString *const kPurchasedEmail = @"purchasedEmail";
static NSString *const kPurchasedID = @"purchasedID";
static NSString *const kImage = @"image";

@implementation ParsePoster

+(void)createListingFromListing:(MaskListing *)maskListing
                 withCompletion:(nonnull PFBooleanResultBlock)completion
{
    PFObject *const listing = [PFObject objectWithClassName:@"Listings"];
    listing[kDescription] = maskListing.maskDescription;
    listing[kTitle] = maskListing.title;
    listing[kCity] = maskListing.city;
    listing[kState] = maskListing.state;
    listing[kAuthorUsername] = maskListing.author.username;
    listing[kAuthorEmail] = maskListing.author.email;
    listing[kAuthorID] = maskListing.author.userID;
    listing[kPrice] = [NSNumber numberWithInt:maskListing.price];
    listing[kPurchased] = [NSNumber numberWithBool:maskListing.purchased];
    listing[kImage] = maskListing.maskImage;
    
    listing[kPurchasedUsername] = @"";
    listing[kPurchasedEmail] = @"";
    listing[kPurchasedID] = @"";
    
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
