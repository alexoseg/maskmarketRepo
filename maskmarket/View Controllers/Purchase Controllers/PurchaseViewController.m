//
//  PurchaseViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/17/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "PurchaseViewController.h"
#import "ParsePoster.h"

#pragma mark - Interface

@interface PurchaseViewController () <UITextFieldDelegate>

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UIImageView *maskImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UITextField *quantityTextField;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;

@end

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
    typeof(self) __weak weakSelf = self;
    [ParsePoster purchaseListingWithId:_maskListing.listingId
                      amountToPurchase:[_quantityTextField.text intValue]
                           amountSpent:[_priceLabel.text intValue]
                        withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        typeof(weakSelf) strongSelf = self;
        if (strongSelf == nil) {
            return;
        }
        
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSLog(@"Successful purchase!");
            [self dismissViewControllerAnimated:YES
                                     completion:nil];
        }
    }];
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

@end
