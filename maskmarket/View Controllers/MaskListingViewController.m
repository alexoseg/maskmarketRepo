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
#import "ParseMaskListing.h"
#import "HomeListingCell.h"
#import "ParseGetter.h"
#import "MaskListingBuilder.h"
#import "BuyDetailViewController.h"
#import "LoadingPopupView.h"
#import "UIColor+AppColors.h"
#import "ErrorPopupViewController.h"

#pragma mark - Interface

@interface MaskListingViewController ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
ErrorPopupViewControllerDelegate>

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray<ParseMaskListing *> *listingsArray;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

#pragma mark - Implementation

@implementation MaskListingViewController

#pragma mark - Constants

static int const cellPaddingSize = 15;

#pragma mark - Lifecylce

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpViews];
    [LoadingPopupView showLoadingPopupAddedTo:self.view
                                  withMessage:@"Loading..."];
    [self fetchListings];
}

#pragma mark - Networking

-(void)fetchListings
{
    typeof(self) __weak weakSelf = self;
    [ParseGetter fetchAllListingsWithCompletion:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        
        [strongSelf.refreshControl endRefreshing];
        [LoadingPopupView hideLoadingPopupAddedTo:strongSelf.view];
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSLog(@"Fetched Listings!");
            strongSelf.listingsArray = [MaskListingBuilder buildParseMaskListingsFromArray:objects];
            [strongSelf.collectionView reloadData];
        }
    }];
}

#pragma mark - Error Popup delegate methods

- (void)tryAgainAction {
    [LoadingPopupView showLoadingPopupAddedTo:self.view
                                  withMessage:@"Loading..."];
    [self fetchListings];
}

#pragma mark - Collection View Code

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    HomeListingCell *const cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeListingCell"
                                                                      forIndexPath:indexPath];
    ParseMaskListing *const listing = self.listingsArray[indexPath.item];
    [cell setUpViewsWithParseMaskListing:listing];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return _listingsArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int totalwidth = self.collectionView.bounds.size.width;
    int numberOfCellsPerRow = 2;
    int paddingSize = cellPaddingSize * 3;
    int itemWidth = (CGFloat)((totalwidth - paddingSize) / numberOfCellsPerRow);
    int itemHeight = itemWidth * 1.05;
    
    return CGSizeMake(itemWidth, itemHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(cellPaddingSize, cellPaddingSize, 0, cellPaddingSize);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return cellPaddingSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return cellPaddingSize;
}

#pragma mark - Gesture Recognizers

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    UICollectionViewCell *const tappedCell = sender;
    NSIndexPath *const indexPath = [self.collectionView indexPathForCell:tappedCell];
    ParseMaskListing *const maskListing = self.listingsArray[indexPath.item];
    BuyDetailViewController *const destinationViewController = [segue destinationViewController];
    destinationViewController.maskListing = maskListing;
}

#pragma mark - Gesture Recognizers

- (IBAction)onTapLogout:(id)sender
{
    [LoadingPopupView showLoadingPopupAddedTo:self.view
                                  withMessage:@"Logging Out..."];
    typeof(self) __weak weakSelf = self;
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        [LoadingPopupView hideLoadingPopupAddedTo:strongSelf.view];
        SceneDelegate *const sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
        UIStoryboard *const storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                   bundle:nil];
        UIViewController *const viewController = [storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        sceneDelegate.window.rootViewController = viewController;
    }];
}

#pragma mark - Setup

- (void)setUpViews
{
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self
                       action:@selector(fetchListings)
             forControlEvents:UIControlEventValueChanged];
    _refreshControl.tintColor = [UIColor primaryAppColor];
    _refreshControl.layer.zPosition = -1;
    [_collectionView insertSubview:_refreshControl
                           atIndex:0];
}

@end
