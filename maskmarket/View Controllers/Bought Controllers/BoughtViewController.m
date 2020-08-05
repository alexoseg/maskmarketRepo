//
//  BoughtViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/30/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "BoughtViewController.h"
#import "BoughtListing.h"
#import "ErrorPopupViewController.h"
#import "LoadingPopupView.h"
#import "UserBuilder.h"
#import "ParseGetter.h"
#import "BoughtCustomCell.h"
#import "BoughtDetailsViewController.h"
#import "UIColor+AppColors.h"

#pragma mark - Interface

@interface BoughtViewController ()
<ErrorPopupViewControllerDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray<BoughtListing *> *maskListings;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

#pragma mark - Constants

static NSString *const kBoughtCustomCellIdentifier = @"BoughtCustomCell";
static NSInteger const kLeftRightCellPadding = 15;

#pragma mark - Implementation

@implementation BoughtViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpViews];
    [LoadingPopupView showLoadingPopupAddedTo:self.view
                                  withMessage:@"Loading..."];
    [self fetchBoughtListings];
}

#pragma mark - Networking

- (void)fetchBoughtListings
{
    User *const currentUser = [UserBuilder buildUserfromPFUser:[PFUser currentUser]];
    
    typeof(self) __weak weakSelf = self;
    [ParseGetter fetchListingsBoughtByUserID:currentUser.userID
                              withCompletion:^(NSArray<BoughtListing *> * _Nullable objects, NSError * _Nullable error) {
        typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        
        [strongSelf.refreshControl endRefreshing];
        [LoadingPopupView hideLoadingPopupAddedTo:strongSelf.view];
        if (error) {
            ErrorPopupViewController *const errorPopupViewController = [[ErrorPopupViewController alloc] initWithMessage:error.localizedDescription
                                                                                                               addCancel:YES];
            errorPopupViewController.delegate = strongSelf;
            [strongSelf presentViewController:errorPopupViewController
                                     animated:YES
                                   completion:nil];
        } else {
            strongSelf.maskListings = objects;
            [strongSelf.collectionView reloadData];
        }
    }];
}

#pragma mark - Collection View Code

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    BoughtCustomCell *const cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBoughtCustomCellIdentifier
                                                                      forIndexPath:indexPath];
    BoughtListing *const listing = self.maskListings[indexPath.item];
    [cell setUpCellWithBoughtListing:listing];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return _maskListings.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger const totalWidth = self.collectionView.bounds.size.width;
    NSInteger const cellWidth = totalWidth - (2 * kLeftRightCellPadding);
    CGFloat const cellHeight = totalWidth * 0.30;
    
    return CGSizeMake(cellWidth, cellHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kLeftRightCellPadding, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kLeftRightCellPadding;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    UICollectionViewCell *const tappedCell = sender;
    NSIndexPath *const indexPath = [self.collectionView indexPathForCell:tappedCell];
    BoughtListing *const boughtListing = self.maskListings[indexPath.item];
    BoughtDetailsViewController *const destinationViewController = [segue destinationViewController];
    destinationViewController.boughtListing = boughtListing;
}

#pragma mark - Error Popup Delegate Methods

- (void)tryAgainAction
{
    [LoadingPopupView showLoadingPopupAddedTo:self.view
                                  withMessage:@"Loading..."];
    [self fetchBoughtListings];
}

#pragma mark - Setup

- (void)setUpViews
{
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self
                        action:@selector(fetchBoughtListings)
              forControlEvents:UIControlEventValueChanged];
    _refreshControl.tintColor = [UIColor primaryAppColor];
    _refreshControl.layer.zPosition = -1;
    [_collectionView insertSubview:_refreshControl
                      atIndex:0];
}

@end
