//
//  MaskListing.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/13/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface MaskListing : NSObject

@property (nonatomic, strong) NSString *listingId;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSString *maskDescription;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) PFUser *author;
@property (nonatomic) int price;
@property (nonatomic) BOOL purchased;
@property (nonatomic, strong) PFUser * _Nullable purchasedBy;
@property (nonatomic, strong) PFFileObject *maskImage;

- (instancetype)initWithListingId:(NSString *)listingId
                        createdAt:(NSDate *)createdAt
                  maskDescription:(NSString *)maskDescription
                            title:(NSString *)title
                             city:(NSString *)city
                            state:(NSString *)state
                           author:(PFUser *)author
                            price:(int)price
                        purchased:(BOOL)purchased
                      purchasedBy:(PFUser * _Nullable)purchasedBy
                        maskImage:(PFFileObject *)maskImage;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
