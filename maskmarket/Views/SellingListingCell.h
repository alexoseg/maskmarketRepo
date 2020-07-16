//
//  SellingListingCell.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/16/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseMaskListing.h"

NS_ASSUME_NONNULL_BEGIN

@interface SellingListingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *maskImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (void)setUpCellWithParseMaskListing:(ParseMaskListing *)maskListing;

@end

NS_ASSUME_NONNULL_END
