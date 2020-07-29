//
//  CreateAccountViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/13/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "CreateAccountViewController.h"
#import "ParsePoster.h"
#import "SceneDelegate.h"
#import "LoadingPopupView.h"
#import "ErrorPopupViewController2.h"

#pragma mark - Interface

@interface CreateAccountViewController () <UITextFieldDelegate>

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

#pragma mark - Implementation

@implementation CreateAccountViewController

#pragma mark - Lifecycle

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
    [self registerForKeyboardNotifications];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self deregisterForKeyboardNotifications];
}

#pragma mark - Notification Registration

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)deregisterForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

#pragma mark - Notification Actions

- (void)keyboardWasShown:(NSNotification *)aNotification
{
    NSDictionary *const info = [aNotification userInfo];
    CGSize const keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets const contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height + 10.0, 0.0);
    _scrollView.contentInset = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    if (!CGRectContainsPoint(aRect, _passwordTextField.frame.origin)) {
        [_scrollView scrollRectToVisible:_passwordTextField.frame
                                animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark - Gesture Handlers

- (IBAction)onTapSignUp:(id)sender
{
    [self dismissKeyboard];
    
    if (_usernameTextField.text.length == 0
        || _emailTextField.text.length == 0
        || _passwordTextField.text.length == 0)
    {
        ErrorPopupViewController2 *const errorViewController = [[ErrorPopupViewController2 alloc] initWithMessage:@"Oops! You have to fill in all the fields in order to create an account."];
        [self presentViewController:errorViewController
                           animated:YES
                         completion:nil];
        return;
    }
    
    [LoadingPopupView showLoadingPopupAddedTo:self.view
                                  withMessage:@"Signing Up..."];
    typeof(self) __weak weakSelf = self;
    [ParsePoster createAccountWithUsername:_usernameTextField.text
                                     email:_emailTextField.text
                                  password:_passwordTextField.text
                            withCompletion:^(BOOL succeeded, NSError * _Nullable error)
    {
        typeof(weakSelf) strongSelf = weakSelf;
        if(strongSelf == nil) {
            return;
        }
        [LoadingPopupView hideLoadingPopupAddedTo:strongSelf.view];
        if (error) {
            ErrorPopupViewController2 *const errorViewController = [[ErrorPopupViewController2 alloc] initWithMessage:error.localizedDescription];
            [strongSelf presentViewController:errorViewController
                                     animated:YES
                                   completion:nil];
        } else {
            SceneDelegate *const sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
            UIStoryboard *const storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                       bundle:nil];
            sceneDelegate.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"homeTabController"];
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

- (IBAction)onSignInTap:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
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
    _emailTextField.delegate = self;
    _passwordTextField.delegate = self;
    UITapGestureRecognizer *const screenTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:screenTap];
}

@end
