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

#pragma mark - Interface

@interface BuyersViewController ()
<UITableViewDelegate,
UITableViewDataSource>

#pragma mark - Properties

@property (nonatomic, strong) NSArray<BoughtListing *> *listings;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

#pragma mark - Implementation

@implementation BuyersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpViews];
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
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSLog(@"Fetched Data");
            strongSelf.listings = [BoughtListingBuilder buildBoughtListingArrayFromArray:objects
                                                 associatedListing:strongSelf.maskListing];
            [strongSelf.tableView reloadData];
        }
    }];
}

#pragma mark - Setup

-(void)setUpViews
{
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

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

@end
