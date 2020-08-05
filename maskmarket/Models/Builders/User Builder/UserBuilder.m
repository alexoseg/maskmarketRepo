//
//  UserBuilder.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/15/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "UserBuilder.h"

static NSString *const kShippingStreetAddress = @"shippingStreetAddress";
static NSString *const kShippingZipCode = @"shippingZipCode";
static NSString *const kShippingCity = @"shippingCity";
static NSString *const kShippingState = @"shippingState";

@implementation UserBuilder

+ (ParseUser *)buildUserfromPFUser:(PFUser *)user
{
    NSString *const shippingStreetAddress = [user[kShippingStreetAddress] copy];
    NSString *const shippingZipCode = [user[kShippingZipCode] copy];
    NSString *const shippingCity = [user[kShippingCity] copy];
    NSString *const shippingState = [user[kShippingState] copy];
    
    if (user == nil
        || shippingStreetAddress == nil
        || shippingCity == nil
        || shippingState == nil
        || shippingZipCode == nil) {
        return nil;
    }
    
    return [[ParseUser alloc] initWithUserID:user.objectId
                                    username:user.username
                                       email:user.email
                       shippingStreetAddress:shippingStreetAddress
                                shippingCity:shippingCity
                               shippingState:shippingState
                             shippingZipCode:shippingZipCode];
}


- (User *)buildLocalUser
{
    if  (self.email == nil
         || self.username == nil
         || self.password == nil
         || self.shippingStreetAddress == nil
         || self.shippingCity == nil
         || self.shippingState == nil
         || self.shippingZipCode) {
        return nil;
    }
    
    return [[User alloc] initWithUsername:self.username
                                    email:self.email
                    shippingStreetAddress:self.shippingStreetAddress
                             shippingCity:self.shippingCity
                            shippingState:self.shippingState
                          shippingZipCode:self.shippingZipCode];
}

@end
