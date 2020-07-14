//
//  DescLocViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/14/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "DescLocViewController.h"
#import "PriceViewController.h"

#pragma mark - Interface

@interface DescLocViewController () <UITextFieldDelegate>

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@end

#pragma mark - Implementation

@implementation DescLocViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpViews];
}

#pragma mark - Gesture Recognizers

- (IBAction)onTapClose:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:nil]; 
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
    self.builder.listingCity = _cityTextField.text;
    self.builder.listingState = _stateTextField.text;
    self.builder.listingDescription = _descriptionTextView.text;
    
    PriceViewController *const viewController = [segue destinationViewController];
    viewController.builder = self.builder;
}

#pragma mark - Text Field Code

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_cityTextField resignFirstResponder];
    [_stateTextField resignFirstResponder];
    
    return YES;
}

#pragma mark - Setup

 - (void)setUpViews
{
    _cityTextField.delegate = self;
    _stateTextField.delegate = self;
    
    UITapGestureRecognizer *const screenTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:screenTap];
    
    self.descriptionTextView.layer.borderWidth = 1.25;
    self.descriptionTextView.layer.cornerRadius = 5.0;
    UIColor *const borderColor = [UIColor colorWithRed:0.85
                                     green:0.85
                                      blue:0.85
                                     alpha:1.0];
    self.descriptionTextView.layer.borderColor = borderColor.CGColor;
}

@end
