//
//  ParseUser.h
//  maskmarket
//
//  Created by Alex Oseguera on 8/5/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface ParseUser : User

@property (nonatomic, strong, readonly) NSString *userID; 

- (instancetype)initWithUserID:(NSString *)userID
                      username:(NSString *)username
                         email:(NSString *)email
         shippingStreetAddress:(NSString *)shippingStreetAddress
                  shippingCity:(NSString *)shippingCity
                 shippingState:(NSString *)shippingState
               shippingZipCode:(NSString *)shippingZipCode;

+ (instancetype)init NS_UNAVAILABLE;

- (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
