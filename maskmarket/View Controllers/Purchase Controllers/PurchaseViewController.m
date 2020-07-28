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

#pragma mark - Interface

@interface PurchaseViewController ()
<UITextFieldDelegate,
PKPaymentAuthorizationViewControllerDelegate>

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UIImageView *maskImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UITextField *quantityTextField;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;

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
    NSDecimalNumber *const amount = [NSDecimalNumber decimalNumberWithString:_priceLabel.text];
    PKPaymentSummaryItem *const paymentItem = [PKPaymentSummaryItem summaryItemWithLabel:summaryLabel
                                                                                  amount:amount];
    NSArray<PKPaymentNetwork> *const paymentNetworks = @[PKPaymentNetworkAmex, PKPaymentNetworkVisa];
    
    if (![PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:paymentNetworks]) {
        UIAlertAction *const alertAction = [UIAlertAction actionWithTitle:@"Dismiss"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:nil];
        [self displayAlertWithMessage:@"Unable to make Apple Pay Transaction"
                         titleMessage:@"Error:"
                               action:alertAction];
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
        UIAlertAction *const alertAction = [UIAlertAction actionWithTitle:@"Dismiss"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:nil];
        [self displayAlertWithMessage:@"Could not display Apple Pay View Controller"
                         titleMessage:@"Error"
                               action:alertAction];
        return;
    }
    
    paymentViewController.delegate = self;
    [self presentViewController:paymentViewController
                       animated:YES
                     completion:nil];
}

#pragma mark - Text Field Code

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
            replacementString:(NSString *)string
{
    if (textField.text.length != range.location
        && range.length == 0) {
        return NO;
    }
    
    NSNumberFormatter *const formatter = [[NSNumberFormatter alloc]init];
    NSString *const newString = [NSString stringWithFormat:@"%@%@", textField.text, string];
    int const enteredQuantity = [[formatter numberFromString:newString] intValue];
    int const quantity = _maskListing.maskQuantity;
    
    if (enteredQuantity > quantity) {
        return NO;
    }
    
    if (enteredQuantity == 1) {
        textField.text = @"1";
        _priceLabel.text = [NSString stringWithFormat:@"%d", _maskListing.price];
    } else {
        int const priceTotal = enteredQuantity * _maskListing.price;
        _priceLabel.text = [NSString stringWithFormat:@"%d", priceTotal];
    }
    
    return YES;
}

#pragma mark - Alert Code

- (void) displayAlertWithMessage:(NSString *)alertMessage
                    titleMessage:(NSString *)titleMessage
                          action:(UIAlertAction *)action
{
    UIAlertController *const alert = [UIAlertController alertControllerWithTitle:titleMessage
                                                                         message:alertMessage
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *const cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                                style:UIAlertActionStyleDefault
                                                               handler:nil];
    [alert addAction:cancelAction];
    [alert addAction:action];
    [self presentViewController:alert
                       animated:YES
                     completion:nil];
}

#pragma mark - Gesture Recognizers

- (IBAction)onTapBuy:(id)sender
{
    NSString *const alertMessage = [NSString stringWithFormat:@"Purchase %@?", _maskListing.title];
    UIAlertAction *const confirmAction = [UIAlertAction actionWithTitle:@"Confirm"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * _Nonnull action) {
           [self performPurchase];
    }];
    [self displayAlertWithMessage:alertMessage
                     titleMessage:@"Confirm Purchase?"
                           action:confirmAction];
}

- (void)dismissKeyboard
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
}

#pragma mark - Set Up

- (void)setUpViews
{
    UITapGestureRecognizer *const screenTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                         action:@selector(dismissKeyboard)];
       [self.view addGestureRecognizer:screenTap];
    
    _quantityTextField.delegate = self;
    
    _maskImageView.layer.cornerRadius = 5.0;
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
    
   
    _priceLabel.text = [NSString stringWithFormat:@"%d", _maskListing.price];
    _locationLabel.text = [NSString stringWithFormat:@"%@, %@", _maskListing.city, _maskListing.state];
    _titleLabel.text = _maskListing.title;
    _usernameLabel.text = _maskListing.author.username;
    _quantityLabel.text = [NSString stringWithFormat:@"%d", _maskListing.maskQuantity];
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
        int const amountToPurchase = [strongSelf.quantityTextField.text intValue];
        int const amountSpent = [strongSelf.priceLabel.text intValue];
        
        [ParsePoster purchaseListingWithId:purchaseListID
                          amountToPurchase:amountToPurchase
                               amountSpent:amountSpent
                            withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            
            [LoadingPopupView hideLoadingPopupAddedTo:strongSelf.view];
            if (error) {
                NSLog(@"%@", error.localizedDescription);
            } else {
                NSLog(@"Successful purchase!");
                [self dismissViewControllerAnimated:YES
                                         completion:nil];
            }
        }];
    }];
}
@end
