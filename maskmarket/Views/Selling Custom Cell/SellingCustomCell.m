//
//  SellingCustomCell.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/31/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "SellingCustomCell.h"

@implementation SellingCustomCell

- (void)setUpWithParseMaskListing:(ParseMaskListing *)maskListing
{
    self.layer.cornerRadius = 10;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.shadowColor = UIColor.blackColor.CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 3);
    self.layer.shadowRadius = 4.65;
    self.layer.shadowOpacity = 0.29;
    self.layer.masksToBounds = false;
    
    _containerView.layer.masksToBounds = YES;
    _containerView.layer.cornerRadius = 10;
    _priceContainerView.layer.cornerRadius = 8;
    _maskQuantityContainerView.layer.cornerRadius = 8;
    _thirdContainerView.layer.cornerRadius = 8;

    _titleLabel.text = maskListing.title;
    _descriptionLabel.text = maskListing.maskDescription;
    _priceLabel.text = [NSString stringWithFormat:@"$%d", maskListing.price];
    _maskQuantityLabel.text = [NSString stringWithFormat:@"%d masks", maskListing.maskQuantity];

    if (maskListing.actionRequired) {
        _thirdContainerView.backgroundColor = [UIColor colorWithRed:219.0f/255.0f
                                              green:22.0f/255.0f
                                               blue:47.0f/255.0f
                                              alpha:0.2];
        _thirdLabel.text = @"Action Required";
        _thirdLabel.textColor = [UIColor colorWithRed:219.0f/255.0f
                                                green:22.0f/255.0f
                                                 blue:47.0f/255.0f
                                                alpha:1.0];
    } else {
        NSDateFormatter *const formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, yyyy"];
        NSString *const formattedDateString = [formatter stringFromDate:maskListing.createdAt];
        _thirdLabel.text = [NSString stringWithFormat:@"%@", formattedDateString];
        _thirdContainerView.backgroundColor = [UIColor systemGray5Color];
        _thirdLabel.textColor = [UIColor blackColor]; 
    }
    
    typeof(self) __weak weakSelf = self;
    [maskListing.maskImage getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        UIImage *const image = [UIImage imageWithData:data];
        [strongSelf.maskImageView setImage:image];
    }];
}

@end
