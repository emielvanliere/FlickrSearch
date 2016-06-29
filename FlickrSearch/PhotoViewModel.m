//
//  PhotoViewModel.m
//  FlickrSearch
//
//  Created by Emiel van Liere on 27/06/16.
//  Copyright © 2016 EVL. All rights reserved.
//

#import "PhotoViewModel.h"

@implementation PhotoViewModel

- (id)initWithPhoto:(PhotoModel *)photo
{
    if (self = [super init]) {
        _photoURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://farm%@.static.flickr.com/%@/%@_%@.jpg", photo.farm, photo.server, photo.photoId, photo.secret]];
    }
    
    return self;
}

@end
