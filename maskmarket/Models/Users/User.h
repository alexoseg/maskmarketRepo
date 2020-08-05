//
//  User.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/15/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nonatomic, strong, readonly) NSString  * _Nullable username;
@property (nonatomic, strong, readonly) NSString  * _Nullable email;
@property (nonatomic, strong, readonly) NSString * shippingStreeetAddress;
@property (nonatomic, strong, readonly) NSString * shippingCity;
@property (nonatomic, strong, readonly) NSString * shippingState;
@property (nonatomic, strong, readonly) NSString * shippingZipCode;

- (instancetype)initWithUsername:(NSString *)username
                   email:(NSString *)email
   shippingStreetAddress:(NSString *)shippingStreetAddress
            shippingCity:(NSString *)shippingCity
           shippingState:(NSString *)shippingState
         shippingZipCode:(NSString *)shippingZipCode;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
