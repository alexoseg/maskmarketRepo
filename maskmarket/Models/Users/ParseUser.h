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

@interface ParseUser : NSObject

@property (nonatomic, strong, readonly) NSString *userID;
@property (nonatomic, strong, readonly) NSString *username;
@property (nonatomic, strong, readonly) NSString *email;

- (instancetype)initWithUserID:(NSString *)userID
                      username:(NSString *)username
                         email:(NSString *)email;

+ (instancetype)init NS_UNAVAILABLE;

- (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
