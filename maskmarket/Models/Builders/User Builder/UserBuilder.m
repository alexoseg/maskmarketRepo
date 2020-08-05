//
//  UserBuilder.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/15/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "UserBuilder.h"

@implementation UserBuilder

+ (ParseUser *)builderParseUserFromID:(NSString *)userID
                             username:(NSString *)username
                                email:(NSString *)email
{
    NSString *const userIDCopy = [userID copy];
    NSString *const usernameCopy = [username copy];
    NSString *const emailCopy = [email copy];
    
    if (userIDCopy == nil
        || usernameCopy == nil
        || emailCopy == nil) {
        return nil;
    }
    
    return [[ParseUser alloc] initWithUserID:userIDCopy
                                    username:usernameCopy
                                       email:emailCopy];
}

+ (ParseUser *)buildUserfromPFUser:(PFUser *)user
{
    NSString *const username = user.username;
    NSString *const userID = user.objectId;
    NSString *const email = user.email;

    if (user == nil
        || username == nil
        || userID == nil
        || email == nil) {
        return nil;
    }

    return [[ParseUser alloc] initWithUserID:userID
                                    username:username
                                       email:email];
}


- (User *)buildLocalUser
{
    if  (self.email == nil
         || self.username == nil
         || self.password == nil
         || self.shippingStreetAddress == nil
         || self.shippingCity == nil
         || self.shippingState == nil
         || self.shippingZipCode == nil) {
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
