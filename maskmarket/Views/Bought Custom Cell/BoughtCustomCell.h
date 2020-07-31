//
//  BoughtCustomCell.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/30/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoughtListing.h"

NS_ASSUME_NONNULL_BEGIN

@interface BoughtCustomCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *maskImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *trackingNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIView *usernameView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIView *separatorView;

- (void)setUpCellWithBoughtListing:(BoughtListing *)boughtListing;

@end

NS_ASSUME_NONNULL_END
