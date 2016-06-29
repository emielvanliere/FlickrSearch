//
//  PhotoSearchResultViewController.m
//  FlickrSearch
//
//  Created by Emiel van Liere on 27/06/16.
//  Copyright © 2016 EVL. All rights reserved.
//

@import UIKit;

#import "PhotosSearchViewModel.h"
#import "SearchHistoryTableViewController.h"

@interface PhotoSearchResultViewController : UIViewController <SearchHistoryTableViewControllerDelegate>

// Designated initializer
- (id)initWithViewModel:(PhotosSearchViewModel *)searchViewModel;

@end