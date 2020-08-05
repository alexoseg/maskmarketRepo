//
//  ParseUser.m
//  maskmarket
//
//  Created by Alex Oseguera on 8/5/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "ParseUser.h"

@implementation ParseUser

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
