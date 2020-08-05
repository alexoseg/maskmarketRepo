//
//  User.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/15/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithUserID:(NSString *)userID
                      username:(NSString *)username
                         email:(NSString *)email
{
    self = [super init];
    
    if (self) {
        _userID = userID;
        _username = username;
        _email = email;
    }
    
    return self;
}

@end
