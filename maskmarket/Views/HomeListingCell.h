//
//  HomeListingCell.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/15/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseMaskListing.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeListingCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *listingImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleTextField;
@property (weak, nonatomic) IBOutlet UILabel *locationTextField;
@property (weak, nonatomic) IBOutlet UILabel *priceTextField;

- (void)setUpViewsWithParseMaskListing:(ParseMaskListing *)listing;

@end

NS_ASSUME_NONNULL_END
