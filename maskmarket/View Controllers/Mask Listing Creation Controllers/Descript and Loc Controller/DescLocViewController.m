//
//  DescLocViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/14/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "DescLocViewController.h"
#import "PriceViewController.h"
#import "UIColor+AppColors.h"
#import "ErrorPopupViewController.h"

#pragma mark - Interface

@interface DescLocViewController () <UITextFieldDelegate>

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@end

#pragma mark - Constants

static NSString *const kPricingSegue = @"pricingSegue";
static NSString *const kErrorSegue = @"errorPopUpSegue";

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

- (IBAction)onTapNext:(id)sender
{
    if (_cityTextField.text.length == 0
        || _stateTextField.text.length == 0
        || _descriptionTextView.text.length == 0)
    {
        [self performSegueWithIdentifier:kErrorSegue
                                  sender:@"Make sure to fill in all fields before continuing."];
        return;
    }
    [self performSegueWithIdentifier:kPricingSegue
                              sender:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.identifier isEqualToString:kPricingSegue]) {
        _builder.listingCity = _cityTextField.text;
        _builder.listingState = _stateTextField.text;
        _builder.listingDescription = _descriptionTextView.text;
        
        PriceViewController *const viewController = [segue destinationViewController];
        viewController.builder = self.builder;
    } else if ([segue.identifier isEqualToString:kErrorSegue]) {
        ErrorPopupViewController *const destinationViewController = [segue destinationViewController];
        destinationViewController.popUpMessage = (NSString *)sender;
    }
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
    self.descriptionTextView.layer.borderColor = [UIColor borderColorGrey].CGColor;
}

@end
