//
//  BuyersViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/23/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "BuyersViewController.h"
#import "ParseGetter.h"
#import "BoughtListingBuilder.h"
#import "PurchaserCell.h"
#import "SaleCompletionViewController.h"
#import "UIColor+AppColors.h"
#import "ErrorPopupViewController.h"
#import "LoadingPopupView.h"

#pragma mark - Interface

@interface BuyersViewController ()
<UITableViewDelegate,
UITableViewDataSource,
ErrorPopupViewControllerDelegate>

#pragma mark - Properties

@property (nonatomic, strong) NSArray<BoughtListing *> *listings;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

#pragma mark - Implementation

@implementation BuyersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpViews];
    [LoadingPopupView showLoadingPopupAddedTo:self.view
                                  withMessage:@"Loading..."];
    [self fetchPurchasers];
}

#pragma mark - Networking

- (void)fetchPurchasers
{
    typeof(self) __weak weakSelf = self;
    [ParseGetter fetchPurchasedObjectsWithListingID:_maskListing.listingId
                                     withCompletion:^(NSArray<PurchaseObj *> * _Nullable objects, NSError * _Nullable error) {
        typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        
        [LoadingPopupView hideLoadingPopupAddedTo:strongSelf.view];
        if (error) {
            ErrorPopupViewController *const errorPopupViewController = [[ErrorPopupViewController alloc] initWithMessage:error.localizedDescription
                                                                                                               addCancel:YES];
            errorPopupViewController.delegate = strongSelf;
            [strongSelf presentViewController:errorPopupViewController
                                     animated:YES
                                   completion:nil];
        } else {
            strongSelf.listings = [BoughtListingBuilder buildBoughtListingArrayFromArray:objects
                                                 associatedListing:strongSelf.maskListing];
            [strongSelf.tableView reloadData];
        }
        [strongSelf.refreshControl endRefreshing];
    }];
}

#pragma mark - Error Popup Delegate Methods

- (void)tryAgainAction
{
    [LoadingPopupView showLoadingPopupAddedTo:self.view
                                  withMessage:@"Loading..."];
    [self fetchPurchasers];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    SaleCompletionViewController *const viewController = [segue destinationViewController];
    UITableViewCell *const tappedCell = sender;
    NSIndexPath *const indexPath = [_tableView indexPathForCell:tappedCell];
    BoughtListing *const boughtListing = _listings[indexPath.row];
    viewController.boughListing = boughtListing;
}

#pragma mark - Setup

-(void)setUpViews
{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self
                       action:@selector(fetchPurchasers)
             forControlEvents:UIControlEventValueChanged];
    _refreshControl.tintColor = [UIColor primaryAppColor];
    _refreshControl.layer.zPosition = -1;
    [_tableView insertSubview:_refreshControl
                           atIndex:0];
}

#pragma mark - Tableview Code

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    PurchaserCell *const cell = [tableView dequeueReusableCellWithIdentifier:@"PurchasedObjCell"];
    BoughtListing *const boughtListing = _listings[indexPath.row];
    [cell setUpPurchaseCellWithBoughtListing:boughtListing];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return _listings.count;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
}

@end
