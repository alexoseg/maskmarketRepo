//
//  PasswordCreationViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 8/4/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "PasswordCreationViewController.h"
#import "AddressCreationViewController.h"
#import "ErrorPopupViewController.h"

@interface PasswordCreationViewController () <UITextFieldDelegate>

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

#pragma mark - Constants

static NSString *const kAddressSegue = @"addressSegue";

#pragma mark - Implementation

@implementation PasswordCreationViewController

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

- (IBAction)onTapNext:(id)sender
{
    if (_passwordTextField.text.length == 0) {
        ErrorPopupViewController *const errorPopup = [[ErrorPopupViewController alloc] initWithMessage:@"Make sure to fill in the password field."
                                                                                             addCancel:NO];
        [self presentViewController:errorPopup
                           animated:YES
                         completion:nil];
        return;
    }
    
    [self performSegueWithIdentifier:kAddressSegue
                              sender:nil];
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.identifier isEqualToString:kAddressSegue]) {
        _userBuilder.password = _passwordTextField.text;
        AddressCreationViewController *const viewController = [segue destinationViewController];
        viewController.userBuilder = _userBuilder;
    }
}

#pragma mark - Setup

- (void)setUpViews
{
    UITapGestureRecognizer *const screenTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:screenTap];
    _passwordTextField.delegate = self;
}


@end
