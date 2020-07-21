//
//  BoughtDetailsViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/21/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "BoughtDetailsViewController.h"

#pragma mark - Interface

@interface BoughtDetailsViewController ()

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UIImageView *maskImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *sellerUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountPaidLabel;

@end

#pragma mark - Implementation

@implementation BoughtDetailsViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpViews];
}

#pragma mark - Setup

- (void)setUpViews
{
    typeof(self) __weak weakSelf = self;
    [self.boughtListing.maskImage getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil ) {
            return;
        }
        
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            UIImage *const image = [UIImage imageWithData:data];
            [strongSelf.maskImageView setImage:image];
        }
    }];
    
    
    _profileImageView.layer.cornerRadius = _profileImageView.frame.size.width / 2;
    _locationLabel.text = [NSString stringWithFormat:@"%@, %@", _boughtListing.city, _boughtListing.state];
    _titleLabel.text = _boughtListing.title;
    _descriptionLabel.text = _boughtListing.maskDescription;
}

@end
