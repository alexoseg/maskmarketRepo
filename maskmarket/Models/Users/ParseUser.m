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
         shippingStreetAddress:(NSString *)shippingStreetAddress
                  shippingCity:(NSString *)shippingCity
                 shippingState:(NSString *)shippingState
               shippingZipCode:(NSString *)shippingZipCode
{
    self = [super initWithUsername:username
                             email:email
             shippingStreetAddress:shippingStreetAddress
                      shippingCity:shippingCity
                     shippingState:shippingState
                   shippingZipCode:shippingZipCode];
    
    if (self) {
        _userID = userID;
    }
    
    return self;
}

@end
