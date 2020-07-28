//
//  ImageTitleViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/14/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "ImageTitleViewController.h"
#import "DescLocViewController.h"
#import "MaskListingBuilder.h"

#pragma mark - Interface

@interface ImageTitleViewController ()
<UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
UITextFieldDelegate>

#pragma mark - Properties

@property (strong, nonatomic) UIImagePickerController *imagePickerVC;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIImageView *maskImageView;

@end

#pragma mark - Constants

static NSString *const kDescLocSegue = @"descLocSegue";

#pragma mark - Implementation

@implementation ImageTitleViewController

#pragma mark - Lifecycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpViews];
}

#pragma mark - Camera Code

- (void) imagePickerController:(UIImagePickerController *)picker
 didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    UIImage *const originalImage = info[UIImagePickerControllerOriginalImage];
    [self.maskImageView setImage:originalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image
                withSize:(CGSize)size
{
    UIImageView *const resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *const newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - Gesture Handlers

- (IBAction)onTapClose:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (IBAction)onTapImage:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:self.imagePickerVC
                       animated:YES
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
    [self performSegueWithIdentifier:kDescLocSegue
                              sender:nil];
}


#pragma mark - Text Field Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_titleTextField resignFirstResponder];
    return YES;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.identifier isEqualToString:kDescLocSegue]) {
        MaskListingBuilder *const builder = [[MaskListingBuilder alloc] init];
        builder.listingTitle = _titleTextField.text;
        
        UIImage *const resizedImage = [self resizeImage:self.maskImageView.image
                                               withSize:CGSizeMake(500, 500)];
        builder.listingImage = resizedImage;

        DescLocViewController *const viewControlller = [segue destinationViewController];
        viewControlller.builder = builder;
    }
}

#pragma mark - Setup

- (void)setUpViews
{
    _imagePickerVC = [UIImagePickerController new];
    _imagePickerVC.delegate = self;
    _imagePickerVC.allowsEditing = self;
    
    UITapGestureRecognizer *const screenTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:screenTap];
    _titleTextField.delegate = self;
}

@end
