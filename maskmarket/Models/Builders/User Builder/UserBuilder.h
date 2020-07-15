//
//  UserBuilder.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/15/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserBuilder : NSObject

+ (nullable User *)buildUserfromPFUser:(PFUser *)user;

+ (nullable User *)buildUserFromUserID:(NSString *)userID
                        username:(NSString *)username
                           email:(NSString *)email;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
