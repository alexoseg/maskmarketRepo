//
//  QueryBuilder.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/27/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface QueryBuilder : NSObject

+ (nullable PFQuery *)buildQueryWithClassName:(NSString *)className
                            whereKey:(NSString *)key
                         greaterThan:(id)object
                       includingKeys:(NSArray<NSString *> *)keys
                               limit:(NSInteger)limit;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
