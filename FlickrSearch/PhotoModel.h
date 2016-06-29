//
//  PhotoModel.h
//  FlickrSearch
//
//  Created by Emiel van Liere on 27/06/16.
//  Copyright © 2016 EVL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface PhotoModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *photoId;
@property (nonatomic, copy, readonly) NSString *secret;
@property (nonatomic, copy, readonly) NSString *server;
@property (nonatomic, copy, readonly) NSNumber *farm;

@end
