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

- (IBAction)onPinchImage:(UIPinchGestureRecognizer *)pinch
{
    if (pinch.state == UIGestureRecognizerStateBegan
        || pinch.state == UIGestureRecognizerStateChanged )
    {
        
        UIView *const pinchView = pinch.view;
        CGRect const bounds = pinchView.bounds;
        CGPoint pinchCenter = [pinch locationInView:pinchView];
        
        pinchCenter.x -= CGRectGetMidX(bounds);
        pinchCenter.y -= CGRectGetMidY(bounds);
        CGAffineTransform transform = pinchView.transform;
        transform = CGAffineTransformTranslate(transform, pinchCenter.x, pinchCenter.y);
        
        CGFloat const scale = pinch.scale;
        transform = CGAffineTransformScale(transform, scale, scale);
        transform = CGAffineTransformTranslate(transform, -pinchCenter.x, -pinchCenter.y);
        pinchView.transform = transform;
        pinch.scale = 1.0;

    } else if (pinch.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3
                         animations:^{
            pinch.view.transform = CGAffineTransformIdentity;
        }];
    }
}


#pragma mark - Setup

- (void)setUpViews
{
    [_maskImageView setImage:_maskImage];
}

@end
