//
//  PhotoViewModelTests.m
//  FlickrSearch
//
//  Created by Emiel van Liere on 28/06/16.
//  Copyright © 2016 EL. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BaseTests.h"
#import "PhotoViewModel.h"

@interface PhotoViewModelTests : BaseTests

@end

@implementation PhotoViewModelTests

- (void)testPhotoURL
{
    PhotoViewModel *viewModel = [[PhotoViewModel alloc] initWithPhoto:self.photoModel];
    NSURL *photoURL = [NSURL URLWithString:@"https://farm1.static.flickr.com/3/2_sekrit.jpg"];
    
    XCTAssertEqualObjects(viewModel.photoURL, photoURL, "Should have correct photo url");
}

@end
