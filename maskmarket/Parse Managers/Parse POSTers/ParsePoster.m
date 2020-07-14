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
static NSString *const kAuthor = @"author";
static NSString *const kPrice = @"price";
static NSString *const kPurchased = @"purchased";
static NSString *const kPurchasedBy = @"purchasedBy";
static NSString *const kImage = @"image";

@implementation ParsePoster

+ (void)createListingFrom:(NSString *)title
                     city:(NSString *)city
                    state:(NSString *)state
              description:(NSString *)description
                    price:(NSNumber *)price
                    image:(UIImage *)image
                   author:(PFUser *)author
           withCompletion:(PFBooleanResultBlock)completion
{
    PFObject *const listing = [PFObject objectWithClassName:@"Listings"];
    listing[kDescription] = description;
    listing[kTitle] = title;
    listing[kCity] = city;
    listing[kState] = state;
    listing[kAuthor] = PFUser.currentUser;
    listing[kPrice] = price;
    listing[kPurchased] = @NO;
    listing[kPurchasedBy] = [PFUser new];
    
    NSData *const imageData = UIImagePNGRepresentation(image);
    listing[kImage] = [PFFileObject fileObjectWithName:@"image.png" data:imageData];
    
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
