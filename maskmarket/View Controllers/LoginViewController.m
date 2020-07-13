//
//  LoginViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/13/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "LoginViewController.h"
#import "ParsePoster.h"

#pragma mark - Interface

@interface LoginViewController ()

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
    [ParsePoster loginWithUsername:_usernameTextField.text
                          password:_passwordTextField.text
                    withCompletion:^(PFUser * _Nullable user, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSLog(@"Successfully logged in!");
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

#pragma mark - Setup

- (void)setupViews
{
    UITapGestureRecognizer *const screenTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:screenTap];
}

@end
