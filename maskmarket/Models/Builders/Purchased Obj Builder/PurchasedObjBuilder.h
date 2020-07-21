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

+ (nullable PurchaseObj *)buildPurchaseObjFromPFObject:(PFObject *)object;

+ (NSArray<PurchaseObj *> *)buildPurchaseObjArrayfromArray:(NSArray<PFObject *> *) objects; 

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
