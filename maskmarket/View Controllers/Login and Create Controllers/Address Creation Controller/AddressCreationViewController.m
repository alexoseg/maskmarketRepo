//
//  AddressCreationViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 8/4/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "AddressCreationViewController.h"
#import "ErrorPopupViewController.h"

#pragma mark - Interface

@interface AddressCreationViewController () <UITextFieldDelegate>

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UITextField *streetAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UITextField *zipCodeTextField;

@end

#pragma mark - Implementation

@implementation AddressCreationViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpViews];
}

#pragma mark - Gesture Recognizers

- (IBAction)onTapBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onTapFinish:(id)sender
{
    if (_streetAddressTextField.text.length == 0
        || _cityTextField.text.length == 0
        || _stateTextField.text.length == 0
        || _zipCodeTextField.text.length == 0) {
        ErrorPopupViewController *const errorPopup = [[ErrorPopupViewController alloc] initWithMessage:@"Make sure to fill in all fields."
                                                                                             addCancel:NO];
        [self presentViewController:errorPopup
                           animated:YES
                         completion:nil];
        return;
    }
    
    _userBuilder.shippingStreetAddress = _streetAddressTextField.text;
    _userBuilder.shippingCity = _cityTextField.text;
    _userBuilder.shippingState = _stateTextField.text;
    _userBuilder.shippingZipCode = _zipCodeTextField.text;
}

#pragma mark - Textfield Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)dismissKeyboard
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
}

#pragma mark - Setup

- (void)setUpViews
{
    UITapGestureRecognizer *const screenTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:screenTap];
    _streetAddressTextField.delegate = self;
    _cityTextField.delegate = self;
    _stateTextField.delegate = self;
    _zipCodeTextField.delegate = self;
}


@end
