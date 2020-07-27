//
//  FullImageViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/27/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "FullImageViewController.h"

#pragma mark - Interface

@interface FullImageViewController ()

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UIImageView *maskImageView;

@end

#pragma mark - Implementation

@implementation FullImageViewController

#pragma mark - Lifecycles

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpViews];
}

#pragma mark - Gesture Recognizers

- (IBAction)onPinchImage:(UIPinchGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan
        || sender.state == UIGestureRecognizerStateChanged )
    {
        CGFloat const currentScale = self.maskImageView.frame.size.width / self.maskImageView.bounds.size.width;
        CGFloat newScale = currentScale * sender.scale;
        
        if (newScale < 1.0) {
            newScale = 1.0;
        }
        
        if (newScale > 2.0) {
            newScale = 2.0;
        }
        
        self.maskImageView.transform = CGAffineTransformMakeScale(newScale, newScale);
        sender.scale = 1;
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        typeof(self) __weak weakSelf = self;
        [UIView animateWithDuration:0.3
                         animations:^{
            typeof(weakSelf) strongSelf = weakSelf;
            if (weakSelf == nil) {
                return;
            }
            
            strongSelf.maskImageView.transform = CGAffineTransformIdentity;
        }];
    }
}


#pragma mark - Setup

- (void)setUpViews
{
    [_maskImageView setImage:_maskImage];
}

@end
