//
//  SellingViewController2.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/31/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "SellingViewController2.h"
#import "SellingCustomCell.h"
#import "ParseMaskListing.h"
#import "ParseGetter.h"
#import "MaskListingBuilder.h"
#import "LoadingPopupView.h"
#import "SellingDetailsViewController.h"
#import "UIColor+AppColors.h"
#import "ErrorPopupViewController.h"
#import "EmptyBackgroundView.h"
#import "PriceViewController.h"
#import "ImageTitleViewController.h"

#pragma mark - Interface

@interface SellingViewController2 ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
ErrorPopupViewControllerDelegate,
PriceViewControllerDelegate>

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray<ParseMaskListing *> *sellingListings;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

#pragma mark - Constants

static NSString *const kSellingReuseIdentifier = @"SellingCustomCell";
static NSInteger const kLeftRightCellPadding = 15;
static NSInteger const kTopPadding = 15;
static NSInteger const kBottomPadding = 15;
static NSString *const kCreationSegue = @"creationSegue";

#pragma mark - Implementation

@implementation SellingViewController2

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpViews];
    [LoadingPopupView showLoadingPopupAddedTo:self.view
                                  withMessage:@"Loading"];
    [self fetchListings];
}

#pragma mark - Networking

- (void)fetchListings
{
    typeof(self) __weak weakSelf = self;
    [ParseGetter fetchCurrentUserSellingsWithCompletion:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        
        [strongSelf.refreshControl endRefreshing];
        [LoadingPopupView hideLoadingPopupAddedTo:strongSelf.view];
        if (error) {
            ErrorPopupViewController *const errorPopupViewController = [[ErrorPopupViewController
                                                                         alloc] initWithMessage:error.localizedDescription
                                                                        addCancel:YES];
            errorPopupViewController.delegate = strongSelf;
            [strongSelf presentViewController:errorPopupViewController
                                     animated:YES
                                   completion:nil];
        } else {
            strongSelf.sellingListings = [MaskListingBuilder buildParseMaskListingsFromArray:objects];
            if (strongSelf.sellingListings.count == 0) {
                EmptyBackgroundView *const emptyView = [[EmptyBackgroundView alloc] initWithImageName:@"mask_icon"
                                                                                                title:@"You aren't selling anything!" message:@"Once you create a mask listing, the listing itself will appear here."];
                strongSelf.collectionView.backgroundView = emptyView;
                [emptyView.topAnchor constraintEqualToAnchor:strongSelf.collectionView.topAnchor].active = YES;
                [emptyView.leadingAnchor constraintEqualToAnchor:strongSelf.collectionView.leadingAnchor].active = YES;
                [emptyView.bottomAnchor constraintEqualToAnchor:strongSelf.collectionView.bottomAnchor].active = YES;
                [emptyView.trailingAnchor constraintEqualToAnchor:strongSelf.collectionView.trailingAnchor].active = YES;
                strongSelf.collectionView.scrollEnabled = NO;
            } else {
                [strongSelf.collectionView setBackgroundView:nil];
                strongSelf.collectionView.scrollEnabled = YES;
            }
            
            [strongSelf.collectionView reloadData];
        }
    }];
}


#pragma mark - Collection View Code

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    SellingCustomCell *const cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSellingReuseIdentifier
                                                                              forIndexPath:indexPath];
    ParseMaskListing *const listing = _sellingListings[indexPath.item];
    [cell setUpWithParseMaskListing:listing];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return _sellingListings.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger const totalWidth = self.collectionView.bounds.size.width;
    NSInteger const cellWidth = totalWidth - (2 * kLeftRightCellPadding);
    CGFloat const cellHeight = totalWidth * 0.80;
    return CGSizeMake(cellWidth, cellHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kTopPadding, 0, kBottomPadding, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kTopPadding;
}

#pragma mark - Error Popup Delegate Methods

- (void)tryAgainAction
{
    [LoadingPopupView showLoadingPopupAddedTo:self.view
                                  withMessage:@"Loading..."];
    [self fetchListings];
}

#pragma mark - PriceViewController Delegate Methods

- (void)didCreateListing
{
    [self fetchListings];
}

#pragma mark - Gesture Recognizers

- (IBAction)onTapCreate:(id)sender
{
    [self performSegueWithIdentifier:kCreationSegue
                              sender:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"sellerDetailsSegue"]) {
        SellingDetailsViewController *const viewController = [segue destinationViewController];
        UICollectionViewCell *const tappedCell = sender;
        NSIndexPath *const indexPath = [self.collectionView indexPathForCell:tappedCell];
        ParseMaskListing *const maskListing = _sellingListings[indexPath.item];
        viewController.maskListing = maskListing;
    }
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
