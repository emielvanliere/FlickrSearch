//
//  PhotosSearchViewModel.h
//  FlickrSearch
//
//  Created by Emiel van Liere on 27/06/16.
//  Copyright © 2016 EVL. All rights reserved.
//

#import "FlickrApiClient.h"
#import "PhotoViewModel.h"

@interface PhotosSearchViewModel : NSObject

// Designated initializer
- (id)initWithApiClient:(FlickrApiClient *)apiClient;

@property (nonatomic, readonly, retain) NSArray<PhotoViewModel *> *photos;
@property (nonatomic, readonly, retain) NSArray<NSString *> *searchQueryHistory;

@property (nonatomic, readonly, assign) BOOL canLoadMore;

// Query that will be used for searching
@property (nonatomic, retain) NSString *searchQuery;

// Search photos for the current searchQuery. Completion is always called on the main thread.
- (void)searchPhotosWithCompletion:(void (^)(NSError *))completion;

// Cancels the current search.
- (void)cancelSearch;

@end
