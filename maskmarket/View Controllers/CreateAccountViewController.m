//
//  CreateAccountViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/13/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "CreateAccountViewController.h"
#import "ParsePoster.h"

#pragma mark - Interface

@interface CreateAccountViewController ()

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
    [ParsePoster createAccountWithUsername:_usernameTextField.text
                                     email:_emailTextField.text
                                  password:_passwordTextField.text
                            withCompletion:^(BOOL succeeded, NSError * _Nullable error)
    {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSLog(@"Create Account Successful!");
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

#pragma mark - Setup

- (void)setupViews
{
    UITapGestureRecognizer *const screenTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:screenTap];
//    [self setUpButton];
}

//- (void)setUpButton
//{
//    self.nextButton.layer.cornerRadius = self.nextButton.frame.size.width / 2;
//    UIColor *const appGreen = [UIColor colorWithRed:38.0f/255.0f
//                                              green:184.0f/255.0f
//                                               blue:153.0f/255.0f
//                                              alpha:1.0f];
//    UIImage *const nextImage = [UIImage imageNamed:@"next.png"];
//    UIImageView *const myImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
//    self.nextButton.backgroundColor = appGreen;
//    self.nextButton.imageView = ;
//}

@end
