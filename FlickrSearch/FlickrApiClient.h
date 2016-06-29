//
//  FlickrApiClient.h
//  FlickrSearch
//
//  Created by Emiel van Liere on 27/06/16.
//  Copyright © 2016 EVL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickrApiClient : NSObject

@property (nonatomic, assign) NSInteger page;

// Given a query, will search the Flickr API and report results back in the completion block
- (NSURLSessionTask *)searchPhotosWithQuery:(NSString *)query onPage:(NSInteger)page pageSize:(NSInteger)pageSize completion:(void (^)(NSArray *, NSError *))completion;

@end
