//
//  QueryBuilder.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/27/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "QueryBuilder.h"

@implementation QueryBuilder

+ (PFQuery *)buildQueryWithClassName:(NSString *)className
                            whereKey:(NSString *)key
                         greaterThan:(id)object
                       includingKeys:(NSArray<NSString *> *)keys
                               limit:(NSInteger)limit
{
    NSString *const classNameCopy = [className copy];
    NSString *const keyCopy = [key copy];
    NSArray <NSString *> *const keysCopy = [keys copy];
    id const objectCopy = [object copy];
    
    if ( classNameCopy == nil
        || keyCopy == nil
        || objectCopy == nil
        || keysCopy == nil)
    {
        return nil;
    }
    
    PFQuery *const query = [PFQuery queryWithClassName:className];
    [query whereKey:keyCopy
        greaterThan:object];
    
    for (NSString *const key in keysCopy) {
        NSString *const stringToInclude = [key copy];
        [query includeKey:stringToInclude];
    }
    
    query.limit = limit;
    
    return query;
}


+ (PFQuery *)buildQueryWithClassName:(NSString *)className
                            whereKey:(NSString *)key
                             equalTo:(id)object
                       includingKeys:(NSArray<NSString *> *)keys
                               limit:(NSInteger)limit
{
    NSString *const classNameCopy = [className copy];
    NSString *const keyCopy = [key copy];
    NSArray <NSString *> *const keysCopy = [keys copy];
    id const objectCopy = [object copy];
    
    if ( classNameCopy == nil
        || keyCopy == nil
        || objectCopy == nil
        || keysCopy == nil)
    {
        return nil;
    }
    
    PFQuery *const query = [PFQuery queryWithClassName:className];
    [query whereKey:keyCopy
            equalTo:object];
    
    for (NSString *const key in keysCopy) {
        NSString *const stringToInclude = [key copy];
        [query includeKey:stringToInclude];
    }
    
    query.limit = limit;
    
    return query;
}

+ (NSArray<PFQuery *> *)buildQueryArrayFromPurchasedArray:(NSArray<PurchaseObj *> *)purchasedObjs
                                            withClassName:(NSString *)className
                                                 queryKey:(NSString *)key

{
    if (purchasedObjs == nil
        || className == nil
        || key == nil)
    {
        return nil;
    }
    
    NSArray<PurchaseObj *> *const purchaseObjsCopy = [purchasedObjs copy];
    NSString *const classNameCopy = [className copy];
    NSString *const keyCopy = [key copy];
    
    NSMutableArray<PFQuery *> *const queryObjects = [NSMutableArray new];
    
    for (PurchaseObj *const purchasedObj in purchaseObjsCopy) {
        PFQuery *const subQuery = [PFQuery queryWithClassName:classNameCopy];
        [subQuery whereKey:keyCopy equalTo:purchasedObj.listingID];
        [queryObjects addObject:subQuery];
    }
    
    return [queryObjects copy];
}

@end
