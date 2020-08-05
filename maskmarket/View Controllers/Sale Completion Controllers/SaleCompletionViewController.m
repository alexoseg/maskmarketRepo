//
//  SaleCompletionViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/24/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "SaleCompletionViewController.h"
#import "ParsePoster.h"
#import "LoadingPopupView.h"
#import "UIColor+AppColors.h"
#import "ErrorPopupViewController.h"
#import "SuccessPopupViewController.h"
#import "ParseGetter.h"

#pragma mark - Interface

@interface SaleCompletionViewController () <SuccessPopupDelegate>

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UIView *infoContainerView;
@property (weak, nonatomic) IBOutlet UIView *trackingContainerView;
@property (weak, nonatomic) IBOutlet UILabel *maskTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@property (weak, nonatomic) IBOutlet UITextField *trackingTextField;
@property (strong, nonatomic) UIButton *completePurchaseButton;
@property (weak, nonatomic) IBOutlet UILabel *streetAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityStateZipLabel;

@end

#pragma mark - Constants

static NSString *const kShippingStreetAddress = @"shippingStreetAddress";
static NSString *const kShippingZipCode = @"shippingZipCode";
static NSString *const kShippingCity = @"shippingCity";
static NSString *const kShippingState = @"shippingState";

#pragma mark - Implementation

@implementation SaleCompletionViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpViews];
}

#pragma mark - Networking

- (void)fetchShippingInfo
{
    [LoadingPopupView showLoadingPopupAddedTo:self.view
                                  withMessage:@"Loading..."];
    NSString *const userID = _boughListing.buyerID;
    typeof(self) __weak weakSelf = self;
    [ParseGetter fetchUserWithID:userID
                  withCompletion:^(PFObject * _Nullable object, NSError * _Nullable error) {
        typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        
        [LoadingPopupView hideLoadingPopupAddedTo:strongSelf.view];
        strongSelf.streetAddressLabel.text = object[kShippingStreetAddress];
        NSString *const city = object[kShippingCity];
        NSString *const state = object[kShippingState];
        NSString *const zipCode = object[kShippingZipCode];
        strongSelf.cityStateZipLabel.text = [NSString stringWithFormat:@"%@, %@ %@", city, state, zipCode];
    }];
}

#pragma mark - Gesture Recognizers

- (void)onCompletePurchase
{
    if (_trackingTextField.text.length == 0) {
        ErrorPopupViewController *const errorPopupViewController = [[ErrorPopupViewController alloc] initWithMessage:@"Please enter a tracking number."
                                                                                                           addCancel:NO];
        [self presentViewController:errorPopupViewController
                                 animated:YES
                               completion:nil];
        return;
    }
    
    NSString *const purchaseObjID = _boughListing.purchaseObjID;
    NSString *const maskListingID = _boughListing.listingID;
    NSString *const trackingNumber = _trackingTextField.text;
    
    typeof(self) __weak weakSelf = self;
    [LoadingPopupView showLoadingPopupAddedTo:self.view
                                  withMessage:@"Completing Purchase..."];
    [ParsePoster setPurchaseCompleteWithID:purchaseObjID
                             maskListingID:maskListingID
                            trackingNumber:trackingNumber
                            withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        
        [LoadingPopupView hideLoadingPopupAddedTo:strongSelf.view];
        if (error) {
            ErrorPopupViewController *const errorPopupViewController = [[ErrorPopupViewController alloc] initWithMessage:error.localizedDescription
                                                                                                               addCancel:NO];
            [strongSelf presentViewController:errorPopupViewController
                                     animated:YES
                                   completion:nil];
        } else {
            SuccessPopupViewController *const successPopupViewController = [[SuccessPopupViewController alloc] initWithMessage:@"Success! Go back and take care of any others."];
            [strongSelf presentViewController:successPopupViewController
                                     animated:YES
                                   completion:nil];
            successPopupViewController.delegate = self;
        }
    }];
}

#pragma mark - Success Popup Delegate methods
- (void)okayAction
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate didCompleteSale];
}

#pragma mark - Setup

- (void)setUpViews
{
    [self fetchShippingInfo];
    _maskTitleLabel.text = _boughListing.title;
    _quantityLabel.text = [NSString stringWithFormat:@"%d", _boughListing.maskQuantity];
    
    _infoContainerView.layer.cornerRadius = 5;
    _infoContainerView.layer.borderWidth = 2;
    _infoContainerView.layer.borderColor = UIColor.systemGray6Color.CGColor;
    
    _trackingContainerView.layer.cornerRadius = 5;
    _trackingContainerView.layer.borderWidth = 2;
    _trackingContainerView.layer.borderColor = UIColor.systemGray6Color.CGColor;
    
    if (_boughListing.completed == NO) {
        _completePurchaseButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _completePurchaseButton.translatesAutoresizingMaskIntoConstraints = NO;
        _completePurchaseButton.backgroundColor = [UIColor primaryAppColor];;
        _completePurchaseButton.layer.cornerRadius = 5;
        [_completePurchaseButton setTitle:@"Complete Purchase"
                                 forState:UIControlStateNormal];
        [_completePurchaseButton addTarget:self
                                    action:@selector(onCompletePurchase)
                          forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_completePurchaseButton];
        [_completePurchaseButton.topAnchor constraintEqualToAnchor:_trackingContainerView.bottomAnchor
                                                          constant:25].active = YES;
        [_completePurchaseButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
        [_completePurchaseButton.widthAnchor constraintGreaterThanOrEqualToConstant:200].active = YES;
        [_completePurchaseButton.heightAnchor constraintEqualToConstant:40].active = YES;
    } else {
        _trackingTextField.placeholder = _boughListing.trackingNumber;
        _trackingTextField.userInteractionEnabled = NO;
    }
}

@end
