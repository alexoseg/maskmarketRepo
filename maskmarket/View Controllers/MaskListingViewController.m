//
//  MaskListingViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/13/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "MaskListingViewController.h"
#import "SceneDelegate.h"
#import <Parse/Parse.h>

#pragma mark - Interface

@interface MaskListingViewController ()

@end

#pragma mark - Implementation

@implementation MaskListingViewController

#pragma mark - Gesture Recognizers

- (IBAction)onTapLogout:(id)sender
{
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
           SceneDelegate *const sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
           UIStoryboard *const storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                      bundle:nil];
           UIViewController *const viewController = [storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
           sceneDelegate.window.rootViewController = viewController;
       }];
}

@end
