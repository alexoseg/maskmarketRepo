//
//  UsernameCreationViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 8/4/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "UsernameCreationViewController.h"
#import "PasswordCreationViewController.h"
#import "ErrorPopupViewController.h"

#pragma mark - Interface

@interface UsernameCreationViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@end

#pragma mark - Constants

static NSString *const kPasswordSegue = @"passwordSegue";

#pragma mark - Implementation

@implementation UsernameCreationViewController

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
    if (_usernameTextField.text.length == 0) {
        ErrorPopupViewController *const errorPopup = [[ErrorPopupViewController alloc] initWithMessage:@"Make sure to fill in the username field."
                                                                                             addCancel:NO];
        [self presentViewController:errorPopup
                           animated:YES
                         completion:nil];
        return;
    }
    
    [self performSegueWithIdentifier:kPasswordSegue
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
    if ([segue.identifier isEqualToString:kPasswordSegue]) {
        _userBuilder.username = _usernameTextField.text;
        PasswordCreationViewController *const viewController = [segue destinationViewController];
        viewController.userBuilder = _userBuilder; 
    }
}

#pragma mark - Setup

- (void)setUpViews
{
    UITapGestureRecognizer *const screenTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:screenTap];
    _usernameTextField.delegate = self;
}

@end
