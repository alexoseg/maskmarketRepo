//
//  PurchaseViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/17/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "PurchaseViewController.h"
#import "ParsePoster.h"
#import "LoadingPopupView.h"
#import <PassKit/PassKit.h>
#import "ErrorPopupViewController.h"
#import "SceneDelegate.h"
#import "SuccessPopupViewController.h"

#pragma mark - Interface

@interface PurchaseViewController ()
<PKPaymentAuthorizationViewControllerDelegate,
SuccessPopupDelegate>

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UIView *itemContainerView;
@property (weak, nonatomic) IBOutlet UIView *deliveryContainerView;
@property (weak, nonatomic) IBOutlet UIView *costContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *maskImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *taxesLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityInputLabel;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UIButton *buyButtone;

@end

#pragma mark - Constants

static NSString *const kCurrencyCode = @"USD";
static NSString *const kCountryCode = @"US";
static NSString *const kMerchantIdentifier = @"merchant.com.alexoseg.maskmarket2";

#pragma mark - Implementation

@implementation PurchaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpViews];
}

#pragma mark - Networking

- (void)performPurchase
{
    NSString *const summaryLabel = _maskListing.title;
    NSString *const extractedTotal = [_totalLabel.text stringByReplacingOccurrencesOfString:@"$"
                                                                                 withString:@""];
    NSDecimalNumber *const amount = [NSDecimalNumber decimalNumberWithString:extractedTotal];
    PKPaymentSummaryItem *const paymentItem = [PKPaymentSummaryItem summaryItemWithLabel:summaryLabel
                                                                                  amount:amount];
    NSArray<PKPaymentNetwork> *const paymentNetworks = @[PKPaymentNetworkAmex, PKPaymentNetworkVisa];
    
    if (![PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:paymentNetworks]) {
        ErrorPopupViewController *const errorPopupViewController = [[ErrorPopupViewController alloc] initWithMessage:@"Unable to make Apple Pay transaction"
                                                                                                           addCancel:NO];
        [self presentViewController:errorPopupViewController
                                 animated:YES
                               completion:nil];
        return;
    }
    
    PKPaymentRequest *const paymentRequest = [PKPaymentRequest new];
    paymentRequest.currencyCode = kCurrencyCode;
    paymentRequest.countryCode = kCountryCode;
    paymentRequest.merchantIdentifier = kMerchantIdentifier;
    paymentRequest.merchantCapabilities = PKMerchantCapability3DS;
    paymentRequest.supportedNetworks = paymentNetworks;
    paymentRequest.paymentSummaryItems = @[paymentItem];
    
    PKPaymentAuthorizationViewController *const paymentViewController = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:paymentRequest];
    
    if (paymentViewController == nil) {
        ErrorPopupViewController *const errorPopupViewController = [[ErrorPopupViewController alloc] initWithMessage:@"Could not display Apple Pay View Controller"
                                                                                                           addCancel:NO];
        [self presentViewController:errorPopupViewController
                                 animated:YES
                               completion:nil];
        return;
    }
    
    paymentViewController.delegate = self;
    [self presentViewController:paymentViewController
                       animated:YES
                     completion:nil];
}

#pragma mark - Gesture Recognizers

- (IBAction)onTapBuy:(id)sender
{
    [self performPurchase];
}

- (IBAction)onTapPlus:(id)sender
{
    NSInteger const maskPrice = _maskListing.price;
    NSInteger const maskQuantityAvailable = _maskListing.maskQuantity;
    
    NSInteger const previousQuantity = [_quantityInputLabel.text intValue];
    if (previousQuantity + 1 > maskQuantityAvailable) {
        return;
    }
    
    NSInteger const newSubtotal = (previousQuantity + 1) * maskPrice;
    NSInteger const newTotal = newSubtotal + 2;
    NSInteger const newQuantity = previousQuantity + 1;
    
    _quantityInputLabel.text = [NSString stringWithFormat:@"%ld", newQuantity];
    _subTotalLabel.text = [NSString stringWithFormat:@"$%.2ld", newSubtotal];
    _totalLabel.text = [NSString stringWithFormat:@"$%.2ld", newTotal];
}

- (IBAction)onTapMinus:(id)sender
{
    NSInteger const maskPrice = _maskListing.price;
       
    NSInteger const previousQuantity = [_quantityInputLabel.text intValue];
    if (previousQuantity - 1 == 0) {
        return;
    }
       
    NSInteger const newSubtotal = (previousQuantity - 1) * maskPrice;
    NSInteger const newTotal = newSubtotal + 2;
    NSInteger const newQuantity = previousQuantity - 1;
       
    _quantityInputLabel.text = [NSString stringWithFormat:@"%ld", newQuantity];
    _subTotalLabel.text = [NSString stringWithFormat:@"$%.2ld", newSubtotal];
    _totalLabel.text = [NSString stringWithFormat:@"$%.2ld", newTotal];
}

#pragma mark - Set Up

- (void)setUpViews
{
    _itemContainerView.layer.cornerRadius = 5.0;
    _itemContainerView.layer.shadowColor = [UIColor blackColor].CGColor;
    _itemContainerView.layer.shadowOffset = CGSizeMake(0, 4);
    _itemContainerView.layer.shadowRadius = 5;
    _itemContainerView.layer.shadowOpacity = 0.25;
    
    _deliveryContainerView.layer.cornerRadius = 5.0;
    _deliveryContainerView.layer.shadowColor = [UIColor blackColor].CGColor;
    _deliveryContainerView.layer.shadowOffset = CGSizeMake(0, 4);
    _deliveryContainerView.layer.shadowRadius = 5;
    _deliveryContainerView.layer.shadowOpacity = 0.25;
    
    _costContainerView.layer.cornerRadius = 5.0;
    _costContainerView.layer.shadowColor = [UIColor blackColor].CGColor;
    _costContainerView.layer.shadowOffset = CGSizeMake(0, 4);
    _costContainerView.layer.shadowRadius = 5;
    _costContainerView.layer.shadowOpacity = 0.25;
    
    _plusButton.layer.cornerRadius = _plusButton.frame.size.width / 2;
    _plusButton.layer.shadowColor = [UIColor blackColor].CGColor;
    _plusButton.layer.shadowOffset = CGSizeMake(0, 4);
    _plusButton.layer.shadowRadius = 4;
    _plusButton.layer.shadowOpacity = 0.25;
    
    _minusButton.layer.cornerRadius = _minusButton.frame.size.width / 2;
    _minusButton.layer.shadowColor = [UIColor blackColor].CGColor;
    _minusButton.layer.shadowOffset = CGSizeMake(0, 4);
    _minusButton.layer.shadowRadius = 4;
    _minusButton.layer.shadowOpacity = 0.25;
    
    _maskImageView.layer.cornerRadius = 5.0;
    _buyButtone.layer.cornerRadius = 8;
    
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
    
    _titleLabel.text = _maskListing.title;
    _descriptionLabel.text = _maskListing.maskDescription;
    _quantityLabel.text = [NSString stringWithFormat:@"%d", _maskListing.maskQuantity];
    _subTotalLabel.text = [NSString stringWithFormat:@"$%.2d", _maskListing.price];
    _taxesLabel.text = @"$2.00";
    
    NSInteger const total = _maskListing.price + 2;
    _totalLabel.text = [NSString stringWithFormat:@"$%.2ld", total];
}

#pragma mark - Apple Pay Delegate Code

- (void)paymentAuthorizationViewControllerDidFinish:(nonnull PKPaymentAuthorizationViewController *)controller {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller
                       didAuthorizePayment:(PKPayment *)payment
                                   handler:(void (^)(PKPaymentAuthorizationResult * _Nonnull))completion
{
    typeof(self) __weak weakSelf = self;
    [self dismissViewControllerAnimated:YES
                             completion:^{
        typeof(weakSelf) strongSelf = self;
        if (strongSelf == nil) {
            return;
        }
        [LoadingPopupView showLoadingPopupAddedTo:strongSelf.view
                                      withMessage:@"Purchasing"];
        
        NSString *const purchaseListID = strongSelf.maskListing.listingId;
        int const amountToPurchase = [strongSelf.quantityInputLabel.text intValue];
        int const amountSpent = [[strongSelf.totalLabel.text stringByReplacingOccurrencesOfString:@"$" withString:@""] intValue];
        
        [ParsePoster purchaseListingWithId:purchaseListID
                          amountToPurchase:amountToPurchase
                               amountSpent:amountSpent
                            withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            
            [LoadingPopupView hideLoadingPopupAddedTo:strongSelf.view];
            if (error) {
                ErrorPopupViewController *const errorPopupViewController = [[ErrorPopupViewController alloc] initWithMessage:error.localizedDescription
                                                                                                                   addCancel:NO];
                [strongSelf presentViewController:errorPopupViewController
                                         animated:YES
                                       completion:nil];
            } else {
                SuccessPopupViewController *const successPopupViewController = [[SuccessPopupViewController alloc] initWithMessage:@"Your purchase was successful! Let's navigate back to the home screen."];
                successPopupViewController.delegate = strongSelf;
                [strongSelf presentViewController:successPopupViewController
                                         animated:YES
                                       completion:nil];
            }
        }];
    }];
}

#pragma mark - Success Popup Delegate Methods

- (void)okayAction
{
    SceneDelegate *const sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    UIStoryboard *const storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
    UINavigationController *const navigationController = [storyboard instantiateViewControllerWithIdentifier:@"homeTabController"];
    sceneDelegate.window.rootViewController = navigationController;
}


@end
