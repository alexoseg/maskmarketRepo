//
//  User.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/15/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithUsername:(NSString *)username
                           email:(NSString *)email
           shippingStreetAddress:(NSString *)shippingStreetAddress
                    shippingCity:(NSString *)shippingCity
                   shippingState:(NSString *)shippingState
                 shippingZipCode:(NSString *)shippingZipCode
{
    self = [super init];
    
    if (self) {
        _username = username;
        _email = email;
        _shippingStreeetAddress = shippingStreetAddress;
        _shippingCity = shippingCity;
        _shippingState = shippingState;
        _shippingZipCode = shippingZipCode;
    }
    
    return self;
}

@end
