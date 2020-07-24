//
//  PurchaserCell.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/23/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "PurchaserCell.h"

@implementation PurchaserCell

- (void)setUpPurchaseCellWithBoughtListing:(BoughtListing *)boughtListing
{
    _profileImageView.layer.cornerRadius = _profileImageView.layer.frame.size.width / 2;
    _usernameLabel.text = boughtListing.buyerUsername;
    _completedLabel.text = (boughtListing.completed) ? @"Yes" : @"No";
    
    NSDateFormatter *const formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, yyyy"];
    NSString *const formattedDateString = [formatter stringFromDate:boughtListing.purchasedOn];
    _purchasedOnLabel.text = [NSString stringWithFormat:@"%@", formattedDateString];
}

@end
