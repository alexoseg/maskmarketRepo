//
//  PurchaseObj.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/20/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PurchaseObj : NSObject

@property (nonatomic, strong, readonly) NSString *userID;
@property (nonatomic, strong, readonly) NSString *listingID;
@property (nonatomic, readonly) int maskQuantity;
@property (nonatomic, readonly) int spent;
@property (nonatomic, strong, readonly) NSDate *purchasedOnDate;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithUserId:(NSString *)userID
                     listingID:(NSString *)listingID
                  maskQuantity:(int)maskQuantity
                         spent:(int)spent
               purchasedOnDate:(NSDate *)purchasedOnDate;

@end

NS_ASSUME_NONNULL_END
