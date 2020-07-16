//
//  ParseGetter.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/15/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface ParseGetter : NSObject

+ (void)fetchCurrentUserSellingsWithCompletion:(void (^)(NSArray * _Nullable, NSError * _Nullable))completion;

+ (void)fetchAllListingsWithCompletion:(void (^)(NSArray * _Nullable objects, NSError * _Nullable error))completion;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE; 

@end

NS_ASSUME_NONNULL_END
