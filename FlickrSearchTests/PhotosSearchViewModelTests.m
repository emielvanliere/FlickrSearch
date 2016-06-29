//
//  PhotosSearchViewModelTests.m
//  FlickrSearch
//
//  Created by Emiel van Liere on 28/06/16.
//  Copyright © 2016 EL. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BaseTests.h"
#import "PhotosSearchViewModel.h"
#import "TestFlickrApiClient.h"

@interface PhotosSearchViewModelTests : BaseTests

@end

@implementation PhotosSearchViewModelTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPhotosSearch
{
    TestFlickrApiClient *testApiClient = [[TestFlickrApiClient alloc] init];
    PhotosSearchViewModel *viewModel = [[PhotosSearchViewModel alloc] initWithApiClient:testApiClient];
    
    XCTAssertEqual(viewModel.photos.count, 0, @"Should have no photos when initialized");
    testApiClient.mockSearchResults = @[self.photoModel];
    
    viewModel.searchQuery = @"Amsterdam";
    [viewModel searchPhotosWithCompletion:nil];
    
    XCTAssertEqual(viewModel.photos.count, 1, @"Should have one photo after searching");
    
    [viewModel cancelSearch];
    
    XCTAssertEqualObjects(viewModel.searchQuery, @"", @"Should have no photos after cancellation");
}

- (void)testSearchQuery
{
    TestFlickrApiClient *testApiClient = [[TestFlickrApiClient alloc] init];
    PhotosSearchViewModel *viewModel = [[PhotosSearchViewModel alloc] initWithApiClient:testApiClient];
    XCTAssertEqualObjects(viewModel.searchQuery, @"", @"Should have empty search query when initialized");
    
    NSString *searchQuery = @"Amsterdam";
    viewModel.searchQuery = searchQuery;
    
    XCTAssertEqualObjects(viewModel.searchQuery, searchQuery, @"Should have correct search query");
    
    [viewModel cancelSearch];
    
    XCTAssertEqualObjects(viewModel.searchQuery, @"", @"Should have empty search query after cancellation");
}

- (void)testSearchHistory
{
    TestFlickrApiClient *testApiClient = [[TestFlickrApiClient alloc] init];
    PhotosSearchViewModel *viewModel = [[PhotosSearchViewModel alloc] initWithApiClient:testApiClient];

    XCTAssertEqual(viewModel.searchQueryHistory.count, 0, @"Should have empty search history when initialized");
    
    NSString *searchQuery = @"Amsterdam";
    viewModel.searchQuery = searchQuery;
    [viewModel searchPhotosWithCompletion:nil];
    
    XCTAssertEqual(viewModel.searchQueryHistory.count, 1, @"Should have one search history item");
    XCTAssertEqualObjects(viewModel.searchQueryHistory[0], searchQuery, @"Should have correct search history item");
}

@end
