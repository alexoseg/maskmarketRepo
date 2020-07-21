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

#pragma mark - Interface

@interface BuyingViewController ()
<UITableViewDelegate,
UITableViewDataSource>

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<BoughtListing *> *maskListings;

@end

#pragma mark - Implementation

@implementation BuyingViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpViews];
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
        
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSLog(@"Successfully retrieved bought listings");
        }
        
        strongSelf.maskListings = objects;
        [strongSelf.tableView reloadData];
    }];
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
}

@end
