//
//  SearchHistoryTableViewController.m
//  FlickrSearch
//
//  Created by Emiel van Liere on 28/06/16.
//  Copyright © 2016 EL. All rights reserved.
//

#import "SearchHistoryTableViewController.h"
#import "PhotoSearchResultViewController.h"

@interface SearchHistoryTableViewController () <UISearchBarDelegate>

@property (nonatomic, retain) PhotosSearchViewModel *searchViewModel;
@property (nonatomic, retain) PhotoSearchResultViewController *searchResultsController;
@property (nonatomic, retain) UISearchController *searchController;

@end

@implementation SearchHistoryTableViewController

static NSString *kSearchHistoryCellId = @"SearchHistoryCellId";

- (id)initWithSearchViewModel:(PhotosSearchViewModel *)searchViewModel
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.searchViewModel = searchViewModel;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    self.searchResultsController = [[PhotoSearchResultViewController alloc] initWithViewModel:self.searchViewModel];
    self.searchDelegate = self.searchResultsController;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultsController];
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.searchBar.placeholder = NSLocalizedString(@"Search on Flickr", nil);
    self.searchController.searchBar.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    self.definesPresentationContext = YES;
    self.navigationItem.titleView = self.searchController.searchBar;
}

- (void)searchWithQuery:(NSString *)searchQuery
{
    if (self.searchDelegate && searchQuery.length > 0) {
        [self.searchDelegate searchHistoryTableViewController:self didSearchWithQuery:searchQuery];
    }
    
    [self.tableView reloadData];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self searchWithQuery:searchBar.text];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchViewModel.searchQueryHistory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSearchHistoryCellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSearchHistoryCellId];
    }
    
    cell.textLabel.text = self.searchViewModel.searchQueryHistory[indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.searchViewModel.searchQueryHistory.count == 0) {
        return NSLocalizedString(@"No Recent Searches", nil);
    } else {
        return NSLocalizedString(@"Recent Searches", nil);
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.searchController.searchBar resignFirstResponder];
    self.searchController.active = YES;
    self.searchController.searchBar.text = self.searchViewModel.searchQueryHistory[indexPath.row];
    
    [self searchWithQuery:self.searchViewModel.searchQueryHistory[indexPath.row]];
}

@end
