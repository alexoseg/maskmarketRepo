//
//  BuyingListingCell.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/20/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "BuyingListingCell.h"

#pragma mark - Implementation

@implementation BuyingListingCell

#pragma mark - Setup

- (void)setUpCellWithBoughtListing:(BoughtListing *)boughtListing
{
    _maskImageView.layer.cornerRadius = 5;
    _maskImageView.image = nil;
    typeof(self) __weak weakSelf = self;
    [boughtListing.maskImage getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        UIImage *const image = [UIImage imageWithData:data];
        [strongSelf.maskImageView setImage:image];
    }];
    
    _quantityLabel.text = [NSString stringWithFormat:@"Quantity bought %d", boughtListing.maskQuantity];
    _titleLabel.text = boughtListing.title;
    _locationLabel.text = [NSString stringWithFormat:@"%@, %@", boughtListing.city, boughtListing.state];
}

@end

