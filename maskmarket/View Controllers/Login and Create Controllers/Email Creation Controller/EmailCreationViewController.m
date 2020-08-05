//
//  EmailCreationViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 8/4/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "EmailCreationViewController.h"
#import "UserBuilder.h"
#import "UsernameCreationViewController.h"
#import "ErrorPopupViewController.h"

#pragma mark - Interface

@interface EmailCreationViewController () <UITextFieldDelegate>

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end

#pragma mark - Constants

static NSString *const kUsernameSegue = @"usernameSegue";

#pragma mark - Implementation

@implementation EmailCreationViewController

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
    if (_emailTextField.text.length == 0) {
        ErrorPopupViewController *const errorPopup = [[ErrorPopupViewController alloc] initWithMessage:@"Make sure to fill in the email field."
                                                                                             addCancel:NO];
        [self presentViewController:errorPopup
                           animated:YES
                         completion:nil];
        return;
    }
    
    [self performSegueWithIdentifier:kUsernameSegue
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
    if ([segue.identifier isEqualToString:kUsernameSegue]) {
        UserBuilder *const userBuilder = [[UserBuilder alloc] init];
        userBuilder.email = _emailTextField.text;
        UsernameCreationViewController *viewController = [segue destinationViewController];
        viewController.userBuilder = userBuilder; 
    }
}

#pragma mark - Setup

- (void)setUpViews
{
    UITapGestureRecognizer *const screenTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:screenTap];
    _emailTextField.delegate = self;
}

@end
