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
#import "ParseUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserBuilder : NSObject

@property (nonatomic, strong) NSString *const email;
@property (nonatomic, strong) NSString *const username;
@property (nonatomic, strong) NSString *const password;
@property (nonatomic, strong) NSString *const shippingStreetAddress;
@property (nonatomic, strong) NSString *const shippingCity;
@property (nonatomic, strong) NSString *const shippingState;
@property (nonatomic, strong) NSString *const shippingZipCode;

+ (nullable ParseUser *)buildUserfromPFUser:(PFUser *)user;

- (nullable User *)buildLocalUser; 

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
