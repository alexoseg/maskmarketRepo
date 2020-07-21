//
//  BuyingListingCell.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/20/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoughtListing.h"

NS_ASSUME_NONNULL_BEGIN

@interface BuyingListingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *maskImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;

- (void)setUpCellWithBoughtListing:(BoughtListing *)maskListing;

@end

NS_ASSUME_NONNULL_END
