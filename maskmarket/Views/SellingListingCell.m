//
//  SellingListingCell.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/16/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "SellingListingCell.h"

#pragma mark - Implementation

@implementation SellingListingCell

#pragma mark - Setup

- (void)setUpCellWithParseMaskListing:(ParseMaskListing *)maskListing
{
    _maskImageView.layer.cornerRadius = 5;
    _maskImageView.image = nil;
    typeof(self) __weak weakSelf = self;
    [maskListing.maskImage getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        UIImage *const image = [UIImage imageWithData:data];
        [strongSelf.maskImageView setImage:image];
    }];
    
    NSDateFormatter *const formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, yyyy"];
    NSString *const formattedDateString = [formatter stringFromDate:maskListing.createdAt];
    _dateLabel.text = [NSString stringWithFormat:@"Posted on %@", formattedDateString];
    
    _titleLabel.text = maskListing.title;
    _locationLabel.text = [NSString stringWithFormat:@"%@, %@", maskListing.city, maskListing.state];
}

@end
