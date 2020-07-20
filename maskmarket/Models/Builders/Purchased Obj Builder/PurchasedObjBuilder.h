//
//  PurchasedObjBuilder.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/20/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PurchaseObj.h"
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface PurchasedObjBuilder : NSObject

+ (nullable PurchaseObj *)buildPurchasObjWithUserID:(NSString *)userID
                                          listingID:(NSString *)listingID
                                       maskQuantity:(NSNumber *)maskQuantity;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
