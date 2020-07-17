//
//  MaskListing.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/13/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "MaskListing.h"

@implementation MaskListing

- (instancetype)initWithMaskDescription:(NSString *)maskDescription
                                  title:(NSString *)title
                                   city:(NSString *)city
                                  state:(NSString *)state
                                 author:(User *)author
                                  price:(int)price
                           maskQuantity:(int)maskQuantity
                              maskImage:(PFFileObject *)maskImage
{
    self = [super init];
    
    if (self) {
        _maskDescription = maskDescription;
        _title = title;
        _city = city;
        _state = state;
        _author = author;
        _price = price;
        _maskQuantity = maskQuantity;
        _maskImage = maskImage;
    }
    
    return self;
}

@end
