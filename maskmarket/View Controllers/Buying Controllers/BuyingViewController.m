//
//  BuyingViewController.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/20/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "BuyingViewController.h"
#import "BuyingListingCell.h"
#import "ParseGetter.h"
#import "UserBuilder.h"
#import "BoughtDetailsViewController.h"
#import "LoadingPopupView.h"
#import "UIColor+AppColors.h"
#import "ErrorPopupViewController.h"

#pragma mark - Interface

@interface BuyingViewController ()
<UITableViewDelegate,
UITableViewDataSource,
ErrorPopupViewControllerDelegate>

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<BoughtListing *> *maskListings;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

#pragma mark - Implementation

@implementation BuyingViewController

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
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSLog(@"Successfully retrieved bought listings");
        }
        
        strongSelf.maskListings = objects;
        [strongSelf.tableView reloadData];
    }];
}

#pragma mark - Error Popup Delegate Methods

- (void)tryAgainAction
{
    [LoadingPopupView showLoadingPopupAddedTo:self.view
                                  withMessage:@"Loading..."];
    [self fetchBoughtListings];
}

#pragma mark - Tableview code

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    BuyingListingCell *const cell = [tableView dequeueReusableCellWithIdentifier:@"BuyingCell"];
    BoughtListing *const boughtListing = _maskListings[indexPath.row];
    [cell setUpCellWithBoughtListing:boughtListing];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return _maskListings.count;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    BoughtDetailsViewController *const viewController = [segue destinationViewController];
    UITableViewCell *const tappedCell = sender;
    NSIndexPath *const indexPath = [self.tableView indexPathForCell:tappedCell];
    BoughtListing *const boughtListing = _maskListings[indexPath.row];
    viewController.boughtListing = boughtListing; 
}

#pragma mark - Setup

- (void)setUpViews
{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self
                       action:@selector(fetchBoughtListings)
             forControlEvents:UIControlEventValueChanged];
    _refreshControl.tintColor = [UIColor primaryAppColor];
    _refreshControl.layer.zPosition = -1;
    [_tableView insertSubview:_refreshControl
                           atIndex:0];
}

@end
