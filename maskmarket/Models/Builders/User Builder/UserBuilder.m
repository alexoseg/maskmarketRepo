//
//  UserBuilder.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/15/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "UserBuilder.h"

@implementation UserBuilder

+ (User *)buildUserfromPFUser:(PFUser *)user
{
    if (user == nil) {
        return nil;
    }
    
    return [[User alloc] initWithUserID:user.objectId
                               username:user.username
                                  email:user.email];
}

+ (User *)buildUserFromUserID:(NSString *)userID
               username:(NSString *)username
                  email:(NSString *)email
{
    if ([userID length] == 0
        || [username length] == 0
        || [username length] == 0) {
        
        return nil;
    }
    
    return [[User alloc] initWithUserID:userID
                               username:username
                                  email:email];
}

@end
