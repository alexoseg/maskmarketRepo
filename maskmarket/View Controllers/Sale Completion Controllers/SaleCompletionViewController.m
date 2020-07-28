//
//  SaleCompletionViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/24/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "SaleCompletionViewController.h"
#import "ParsePoster.h"
#import "LoadingPopupView.h"
#import "UIColor+AppColors.h"

#pragma mark - Interface

@interface SaleCompletionViewController ()

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UIView *infoContainerView;
@property (weak, nonatomic) IBOutlet UIView *trackingContainerView;
@property (weak, nonatomic) IBOutlet UILabel *maskTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@property (weak, nonatomic) IBOutlet UITextField *trackingTextField;
@property (strong, nonatomic) UIButton *completePurchaseButton;

@end

#pragma mark - Implementation

@implementation SaleCompletionViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpViews];
}

#pragma mark - Gesture Recognizers

- (void)onCompletePurchase
{
    if (_trackingTextField.text.length == 0) {
        NSLog(@"Please enter a tracking number");
        return;
    }
    
    NSString *const purchaseObjID = _boughListing.purchaseObjID;
    NSString *const trackingNumber = _trackingTextField.text;
    
    typeof(self) __weak weakSelf = self;
    [LoadingPopupView showLoadingPopupAddedTo:self.view
                                  withMessage:@"Completing Purchase..."];
    [ParsePoster setPurchaseCompleteWithID:purchaseObjID
                            trackingNumber:trackingNumber
                            withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        
        [LoadingPopupView hideLoadingPopupAddedTo:strongSelf.view];
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSLog(@"Successful Completion");
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}

#pragma mark - Setup

- (void)setUpViews
{
    _maskTitleLabel.text = _boughListing.title;
    _quantityLabel.text = [NSString stringWithFormat:@"%d", _boughListing.maskQuantity];
    
    _infoContainerView.layer.cornerRadius = 5;
    _infoContainerView.layer.borderWidth = 2;
    _infoContainerView.layer.borderColor = UIColor.systemGray6Color.CGColor;
    
    _trackingContainerView.layer.cornerRadius = 5;
    _trackingContainerView.layer.borderWidth = 2;
    _trackingContainerView.layer.borderColor = UIColor.systemGray6Color.CGColor;
    
    if (_boughListing.completed == NO) {
        _completePurchaseButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _completePurchaseButton.translatesAutoresizingMaskIntoConstraints = NO;
        _completePurchaseButton.backgroundColor = [UIColor primaryAppColor];;
        _completePurchaseButton.layer.cornerRadius = 5;
        [_completePurchaseButton setTitle:@"Complete Purchase"
                                 forState:UIControlStateNormal];
        [_completePurchaseButton addTarget:self
                                    action:@selector(onCompletePurchase)
                          forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_completePurchaseButton];
        [_completePurchaseButton.topAnchor constraintEqualToAnchor:_trackingContainerView.bottomAnchor
                                                          constant:25].active = YES;
        [_completePurchaseButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
        [_completePurchaseButton.widthAnchor constraintGreaterThanOrEqualToConstant:200].active = YES;
        [_completePurchaseButton.heightAnchor constraintEqualToConstant:40].active = YES;
    } else {
        _trackingTextField.placeholder = _boughListing.trackingNumber;
        _trackingTextField.userInteractionEnabled = NO;
    }
}

@end
