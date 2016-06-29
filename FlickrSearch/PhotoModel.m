//
//  PhotoModel.m
//  FlickrSearch
//
//  Created by Emiel van Liere on 27/06/16.
//  Copyright © 2016 EVL. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"photoId": @"id",
        @"secret": @"secret",
        @"server": @"server",
        @"farm": @"farm"
    };
}

@end
