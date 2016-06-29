//
//  PhotosSearchViewModel.m
//  FlickrSearch
//
//  Created by Emiel van Liere on 27/06/16.
//  Copyright © 2016 EVL. All rights reserved.
//

#import "PhotosSearchViewModel.h"
#import "PhotoModel.h"

@interface PhotosSearchViewModel ()

@property (nonatomic, retain) FlickrApiClient *apiClient;
@property (nonatomic, retain) NSURLSessionTask *downloadTask;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, retain) NSString *currentSearchQuery;
@property (nonatomic, retain) NSMutableArray *mSearchQueryHistory;

@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) NSInteger pageSize;

@end

@implementation PhotosSearchViewModel

- (id)initWithApiClient:(FlickrApiClient *)apiClient
{
    if (self = [super init]) {
        self.apiClient = apiClient;
        self.mSearchQueryHistory = [[NSMutableArray alloc] init];
        self.searchQuery = @"";
        self.pageSize = 30;
        
        [self resetSearch];
    }
    
    return self;
}

- (NSArray *)searchQueryHistory
{
    return (NSArray *) self.mSearchQueryHistory;
}

- (void)addToSearchQueryHistory:(NSString *)searchQuery
{
    // Keep the history sorted by time
    [self.mSearchQueryHistory removeObject:searchQuery];
    [self.mSearchQueryHistory insertObject:searchQuery atIndex:0];
}

#pragma mark - Searching
- (void)resetSearch
{
    if (self.downloadTask) {
        [self.downloadTask cancel];
    }

    self.currentPage = 1;
    self.currentSearchQuery = @"";
    self.isLoading = NO;
    _photos = @[];
}

- (void)cancelSearch
{
    [self resetSearch];
    self.searchQuery = @"";
}

- (BOOL)canLoadMore
{
    return !self.isLoading && self.photos.count % self.pageSize == 0;
}

- (void)searchPhotosWithCompletion:(void (^)(NSError *))completion
{
    if (_isLoading) {
        if (completion) {
            completion(nil);
        }
        return;
    }
    
    if ([self.searchQuery isEqualToString:self.currentSearchQuery]) {
        ++self.currentPage;
    } else {
        [self resetSearch];
        self.currentSearchQuery = self.searchQuery;
        [self addToSearchQueryHistory:self.searchQuery];
    }
    
    _isLoading = YES;
    
    self.downloadTask = [self.apiClient searchPhotosWithQuery:self.searchQuery onPage:self.currentPage pageSize:self.pageSize completion:^(NSArray *photos, NSError *error) {
        NSMutableArray *mPhotos = [[NSMutableArray alloc] init];
        for (PhotoModel *photo in photos) {
            PhotoViewModel *photoViewModel = [[PhotoViewModel alloc] initWithPhoto:photo];
            [mPhotos addObject:photoViewModel];
        }
        
        _photos = [_photos arrayByAddingObjectsFromArray:mPhotos];
        _isLoading = NO;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(error);
            }
        });
    }];
}

@end
