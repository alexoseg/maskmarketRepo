//
//  SellingCustomCell.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/31/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseMaskListing.h"

NS_ASSUME_NONNULL_BEGIN

@interface SellingCustomCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *maskImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIView *priceContainerView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIView *maskQuantityContainerView;
@property (weak, nonatomic) IBOutlet UILabel *maskQuantityLabel;
@property (weak, nonatomic) IBOutlet UIView *thirdContainerView;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;

- (void)setUpWithParseMaskListing:(ParseMaskListing *)maskListing; 

@end

NS_ASSUME_NONNULL_END
