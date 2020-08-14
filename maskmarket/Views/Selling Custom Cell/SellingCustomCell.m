//
//  SellingCustomCell.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/31/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "SellingCustomCell.h"
#import "UIColor+AppColors.h"

static NSInteger const kCornerRadius = 10;
static NSInteger const kContainerCornerRadius = 8;
static double const kShadowRadius = 4.65;
static double const kShadowOpacity = 0.29;

@implementation SellingCustomCell

- (void)prepareForReuse
{
    [super prepareForReuse];
    _maskImageView.image = nil;
}

- (void)setUpWithParseMaskListing:(ParseMaskListing *)maskListing
{
    self.layer.cornerRadius = kCornerRadius;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.shadowColor = UIColor.blackColor.CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 3);
    self.layer.shadowRadius = kShadowRadius;
    self.layer.shadowOpacity = kShadowOpacity;
    self.layer.masksToBounds = false;
    
    _containerView.layer.masksToBounds = YES;
    _containerView.layer.cornerRadius = kCornerRadius;
    _priceContainerView.layer.cornerRadius = kContainerCornerRadius;
    _maskQuantityContainerView.layer.cornerRadius = kContainerCornerRadius;
    _thirdContainerView.layer.cornerRadius = kContainerCornerRadius;

    _titleLabel.text = maskListing.title;
    _descriptionLabel.text = maskListing.maskDescription;
    _priceLabel.text = [NSString stringWithFormat:@"$%d", maskListing.price];
    _maskQuantityLabel.text = [NSString stringWithFormat:@"%d masks", maskListing.maskQuantity];

    if (maskListing.actionRequired) {
        _thirdContainerView.backgroundColor = [UIColor redViewBackgroundColor];
        _thirdLabel.text = @"Action Required";
        _thirdLabel.textColor = [UIColor redLabelColor];
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
