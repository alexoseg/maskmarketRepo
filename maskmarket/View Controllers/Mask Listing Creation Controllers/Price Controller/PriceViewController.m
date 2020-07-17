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

#pragma mark - Interface

@interface PriceViewController () <UITextFieldDelegate>

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UITextField *maskQuantityTextField;

@end

#pragma mark - Implementation

@implementation PriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
}

#pragma mark - Gesture Recognizers

- (IBAction)onTapPost:(id)sender
{
    NSNumberFormatter *const formatter = [[NSNumberFormatter alloc]init];
    self.builder.listingPrice = [formatter numberFromString:_priceTextField.text];
    self.builder.listingMaskQuantity = [formatter numberFromString:_maskQuantityTextField.text];
    MaskListing *const maskListing = [self.builder buildLocalMaskListing];
    
    [ParsePoster createListingFromListing:maskListing
                           withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
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
