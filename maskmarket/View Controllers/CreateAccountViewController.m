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

#pragma mark - Interface

@interface CreateAccountViewController () <UITextFieldDelegate>

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

#pragma mark - Implementation

@implementation CreateAccountViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
}

#pragma mark - Gesture Handlers

- (IBAction)onTapSignUp:(id)sender
{
    [self dismissKeyboard];
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
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSLog(@"Create Account Successful!");
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

#pragma mark - Setup

- (void)setupViews
{
    UITapGestureRecognizer *const screenTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:screenTap];
}

@end
