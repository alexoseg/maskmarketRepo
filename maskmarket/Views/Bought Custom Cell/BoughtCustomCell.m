//
//  BoughtCustomCell.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/30/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "BoughtCustomCell.h"
#import "UIColor+AppColors.h"
#import "DateTools.h"

@implementation BoughtCustomCell

- (void)setUpCellWithBoughtListing:(BoughtListing *)boughtListing
{
    self.layer.cornerRadius = 10;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.shadowColor = UIColor.blackColor.CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 3);
    self.layer.shadowRadius = 4.65;
    self.layer.shadowOpacity = 0.29;
    self.layer.masksToBounds = false;
    
    _separatorView.layer.cornerRadius = _separatorView.frame.size.width / 2;
    _statusView.layer.cornerRadius = 8;
    _usernameView.layer.cornerRadius = 8;
    _maskImageView.layer.cornerRadius = 5;
    
    _titleLabel.text = boughtListing.title;
    _priceLabel.text = [NSString stringWithFormat:@"$%d", boughtListing.price];
    _usernameLabel.text = boughtListing.sellerUsername;
    _dateLabel.text = [NSDate shortTimeAgoSinceDate:boughtListing.purchasedOn];
    
    if (boughtListing.completed) {
        _statusView.backgroundColor = [UIColor greenViewBackgroundColor];
        _statusLabel.textColor = [UIColor greenLabelColor];
        _statusLabel.text = @"Shipped";
        _trackingNumberLabel.text = [NSString stringWithFormat:@"#%@", boughtListing.trackingNumber];
    } else {
        _statusView.backgroundColor = [UIColor orangeViewBackgroundColor];
        _statusLabel.textColor = [UIColor orangeLabelColor];
        _statusLabel.text = @"Pending";
        _trackingNumberLabel.text = @"No Tracking Number";
    }
    
    typeof(self) __weak weakSelf = self;
    [boughtListing.maskImage getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        UIImage *const image = [UIImage imageWithData:data];
        [strongSelf.maskImageView setImage:image];
    }];
}

@end
