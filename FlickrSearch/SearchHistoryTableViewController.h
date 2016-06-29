//
//  SearchHistoryTableViewController.h
//  FlickrSearch
//
//  Created by Emiel van Liere on 28/06/16.
//  Copyright © 2016 EL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotosSearchViewModel.h"

@protocol SearchHistoryTableViewControllerDelegate;

@interface SearchHistoryTableViewController : UITableViewController

// Designated initializer
- (id)initWithSearchViewModel:(PhotosSearchViewModel *)searchViewModel;

@property (nonatomic, weak) id<SearchHistoryTableViewControllerDelegate> searchDelegate;

@end

@protocol SearchHistoryTableViewControllerDelegate <NSObject>

- (void)searchHistoryTableViewController:(SearchHistoryTableViewController *)searchHistoryTableViewController didSearchWithQuery:(NSString *)searchQuery;

@end