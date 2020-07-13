//
//  ParsePoster.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/13/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "ParsePoster.h"

@implementation ParsePoster

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
