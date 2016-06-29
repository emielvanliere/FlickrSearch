//
//  TestFlickrApiClient.m
//  FlickrSearch
//
//  Created by Emiel van Liere on 28/06/16.
//  Copyright © 2016 EL. All rights reserved.
//

#import "TestFlickrApiClient.h"

@implementation TestFlickrApiClient

- (id)init
{
    if (self = [super init]) {
        self.mockSearchResults = @[];
    }
    
    return self;
}

- (NSURLSessionTask *)searchPhotosWithQuery:(NSString *)query onPage:(NSInteger)page pageSize:(NSInteger)pageSize completion:(void (^)(NSArray *, NSError *))completion
{
    completion(self.mockSearchResults, nil);
    
    return nil;
}

@end
