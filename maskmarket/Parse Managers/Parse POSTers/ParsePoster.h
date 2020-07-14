//
//  ParsePoster.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/13/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface ParsePoster : NSObject

+ (void)createListingFromTitle:(NSString *)title
                     city:(NSString *)city
                    state:(NSString *)state
              description:(NSString *)description
                    price:(NSNumber *)price
                    image:(UIImage *)image
                   author:(PFUser *)author
           withCompletion:(PFBooleanResultBlock)completion;

+ (void)createAccountWithUsername:(NSString *)username
                            email:(NSString *)email
                         password:(NSString *)password
                   withCompletion:(PFBooleanResultBlock _Nullable)completion;

+ (void)loginWithUsername:(NSString *)username
              password:(NSString *)password
        withCompletion:(void (^)(PFUser * _Nullable, NSError * _Nullable))completion;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
