//
//  PriceViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/14/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "PriceViewController.h"
#import "ParsePoster.h"
#import "MaskListing.h"
#import "LoadingPopupView.h"
#import "ErrorPopupViewController.h"

#pragma mark - Interface

@interface PriceViewController () <UITextFieldDelegate>

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UITextField *maskQuantityTextField;

@end

#pragma mark - Constants

static NSString *const kErrorSegue = @"errorPopUpSegue";

#pragma mark - Implementation

@implementation PriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
}

#pragma mark - Gesture Recognizers

- (IBAction)onTapPost:(id)sender
{
    [self dismissKeyboard];
    
    if (_priceTextField.text.length == 0
        || _maskQuantityTextField.text.length == 0)
    {
        [self performSegueWithIdentifier:kErrorSegue
                                  sender:@"Make sure to fill in all fields before continuing."];
        return;
    }
    
    NSNumberFormatter *const formatter = [[NSNumberFormatter alloc]init];
    self.builder.listingPrice = [formatter numberFromString:_priceTextField.text];
    self.builder.listingMaskQuantity = [formatter numberFromString:_maskQuantityTextField.text];
    MaskListing *const maskListing = [self.builder buildLocalMaskListing];
    
    [LoadingPopupView showLoadingPopupAddedTo:self.view
                                  withMessage:@"Posting"];
    typeof(self) __weak weakSelf = self;
    [ParsePoster createListingFromListing:maskListing
                           withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        [LoadingPopupView hideLoadingPopupAddedTo:strongSelf.view];
        if (error) {
            [strongSelf performSegueWithIdentifier:kErrorSegue
                                            sender:error.localizedDescription];
        } else {
            NSLog(@"Successfully created a listing!");
        }
    }];
}

- (void)dismissKeyboard
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
}

- (IBAction)onTapClose:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

#pragma mark - Text Field Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_priceTextField resignFirstResponder];
    return YES;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.identifier isEqualToString:kErrorSegue]) {
        ErrorPopupViewController *const destinationViewController = [segue destinationViewController];
        destinationViewController.popUpMessage = (NSString *)sender;
    }
}

#pragma mark - Setup

- (void)setUpViews
{
    _priceTextField.delegate = self;
    _priceTextField.adjustsFontSizeToFitWidth = NO;
    UITapGestureRecognizer *const screenTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:screenTap];
}

@end
