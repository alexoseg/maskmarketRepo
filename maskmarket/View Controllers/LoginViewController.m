//
//  LoginViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/13/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "LoginViewController.h"
#import "ParsePoster.h"
#import "SceneDelegate.h"
#import "LoadingPopupView.h"
#import "ErrorPopupViewController.h"

#pragma mark - Interface

@interface LoginViewController () <UITextFieldDelegate>

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

#pragma mark - Implementation

@implementation LoginViewController

#pragma mark - Lifecyle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
}

#pragma mark - Touch Recognizers

- (IBAction)onLoginTap:(id)sender
{
    [self dismissKeyboard];
    
    if (_usernameTextField.text.length == 0
        || _passwordTextField.text.length == 0)
    {
        ErrorPopupViewController *const errorViewController = [[ErrorPopupViewController alloc] initWithMessage:@"Oops! You have to fill in all the fields in order to login."];
        [self presentViewController:errorViewController
                           animated:YES
                         completion:nil];
        return;
    }
    
    [LoadingPopupView showLoadingPopupAddedTo:self.view
                                  withMessage:@"Logging In..."];
    typeof(self) __weak weakSelf = self;
    [ParsePoster loginWithUsername:_usernameTextField.text
                          password:_passwordTextField.text
                    withCompletion:^(PFUser * _Nullable user, NSError * _Nullable error) {
        typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        [LoadingPopupView hideLoadingPopupAddedTo:strongSelf.view];
        if (error) {
            ErrorPopupViewController *const errorViewController = [[ErrorPopupViewController alloc] initWithMessage:error.localizedDescription];
            [strongSelf presentViewController:errorViewController
                               animated:YES
                             completion:nil];
        } else {
            SceneDelegate *const sceneDelegate = (SceneDelegate *)strongSelf.view.window.windowScene.delegate;
            UIStoryboard *const storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                       bundle:nil];
            sceneDelegate.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"homeTabController"];
        }
    }];
}

- (IBAction)onSignUpTap:(id)sender
{
    [self performSegueWithIdentifier:@"showSignUpSegue"
                              sender:nil];
}

- (void)dismissKeyboard
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
}

#pragma mark - Textfield Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Setup

- (void)setupViews
{
    _usernameTextField.delegate = self;
    _passwordTextField.delegate = self;
    UITapGestureRecognizer *const screenTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:screenTap];
}

@end
