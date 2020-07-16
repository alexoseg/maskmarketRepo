//
//  BuyDetailViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/16/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "BuyDetailViewController.h"
#import "ParsePoster.h"

#pragma mark - Interface

@interface BuyDetailViewController ()

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UIImageView *maskImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

#pragma mark - Implementation

@implementation BuyDetailViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpViews];
}

#pragma mark - Networking
- (void)performPurchase
{
    [ParsePoster purchaseListingWithId:_maskListing.listingId
                        withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSLog(@"Successful Purchase!");
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

#pragma mark - Alert Code

- (void) displayAlertWithMessage:(NSString *)alertMessage
{
    NSString *const titleMessage = @"Confirm Purchase?";
    UIAlertController *const alert = [UIAlertController alertControllerWithTitle:titleMessage
                                                                         message:alertMessage
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *const confirmAction = [UIAlertAction actionWithTitle:@"Confirm"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
        [self performPurchase];
    }];
    UIAlertAction *const cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                                style:UIAlertActionStyleDefault
                                                               handler:nil];
    [alert addAction:cancelAction];
    [alert addAction:confirmAction];
    [self presentViewController:alert
                       animated:YES
                     completion:nil];
}

#pragma mark - Gesture Recognizers

- (IBAction)onTapBuy:(id)sender
{
    NSString *const alertMessage = [NSString stringWithFormat:@"Purchase %@?", _maskListing.title];
    [self displayAlertWithMessage:alertMessage];
}

#pragma mark - Setup Views

- (void)setUpViews
{
    typeof(self) __weak weakSelf = self;
    [self.maskListing.maskImage getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
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
    
    NSDateFormatter *const formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, yyyy"];
    NSString *const formattedDateString = [formatter stringFromDate:_maskListing.createdAt];
    _dateLabel.text = [NSString stringWithFormat:@"Posted on %@", formattedDateString];
    
    _profileImageView.layer.cornerRadius = _profileImageView.frame.size.width / 2;
    _priceLabel.text = [NSString stringWithFormat:@"$%d", _maskListing.price];
    _locationLabel.text = [NSString stringWithFormat:@"%@, %@", _maskListing.city, _maskListing.state];
    _titleLabel.text = _maskListing.title;
    _usernameLabel.text = _maskListing.author.username;
    _descriptionLabel.text = _maskListing.maskDescription;
}

@end
