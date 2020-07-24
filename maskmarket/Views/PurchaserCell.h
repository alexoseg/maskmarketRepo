//
//  PurchaserCell.h
//  maskmarket
//
//  Created by Alex Oseguera on 7/23/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoughtListing.h"

NS_ASSUME_NONNULL_BEGIN

@interface PurchaserCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *purchasedOnLabel;
@property (weak, nonatomic) IBOutlet UILabel *completedLabel;

- (void)setUpPurchaseCellWithBoughtListing:(BoughtListing *)boughtListing;

@end

NS_ASSUME_NONNULL_END
