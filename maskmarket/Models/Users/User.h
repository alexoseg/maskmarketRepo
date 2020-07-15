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

@property (nonatomic, strong, readonly) NSString  * _Nullable userID;
@property (nonatomic, strong, readonly) NSString  * _Nullable username;
@property (nonatomic, strong, readonly) NSString  * _Nullable email;

- (instancetype)initWithUserID:(NSString *)userID
                               username:(NSString *)username
                                  email:(NSString *)email;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
