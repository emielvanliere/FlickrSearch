//
//  FlickrApiClient.m
//  FlickrSearch
//
//  Created by Emiel van Liere on 27/06/16.
//  Copyright © 2016 EVL. All rights reserved.
//

#import "FlickrApiClient.h"
#import "PhotoModel.h"

#import <Mantle/Mantle.h>


@interface FlickrApiClient ()

@property (nonatomic, retain) NSString *endpoint;

@end

@implementation FlickrApiClient

- (id)init
{
    if (self = [super init]) {
        self.endpoint = @"https://api.flickr.com/services/rest/";
    }
    
    return self;
}

- (NSURLSessionTask *)searchPhotosWithQuery:(NSString *)query onPage:(NSInteger)page pageSize:(NSInteger)pageSize completion:(void (^)(NSArray *, NSError *))completion
{
    NSDictionary *params = @{
        @"method": @"flickr.photos.search",
        @"api_key": @"3e7cc266ae2b0e0d78e279ce8e361736",
        @"format": @"json",
        @"nojsoncallback": @"1",
        @"per_page": [@(pageSize) stringValue],
        @"page": [@(page) stringValue],
        @"text": query
    };
    
    NSURL *url = [self urlFromQueryParameters:params];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
            return;
        } else if (!response) {
            NSError *responseError = [NSError errorWithDomain:@"nl.emielvanliere.FlickrSearch"
                                                         code:-1
                                                     userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"Invalid response from server.", nil)}];
            completion(nil, responseError);
            return;
        }
        
        NSError *jsonError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            completion (nil, jsonError);
        } else {
            NSArray *photos = [MTLJSONAdapter modelsOfClass:PhotoModel.class
                                              fromJSONArray:[[json objectForKey:@"photos"] objectForKey:@"photo"]
                                                      error:&jsonError];
            if (jsonError) {
                completion(nil, jsonError);
            } else {
                completion(photos, jsonError);
            }
        }
    }];
    
    [downloadTask resume];
    
    return downloadTask;
}
                          
- (NSURL *)urlFromQueryParameters:(NSDictionary *)queryParameters
{
    NSURLComponents *components = [NSURLComponents componentsWithString:self.endpoint];
    NSMutableArray *queryItems = [[NSMutableArray alloc] init];
    for (NSString *key in queryParameters) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:queryParameters[key]]];
    }
    
    components.queryItems = queryItems;
    
    return components.URL;
}

@end
