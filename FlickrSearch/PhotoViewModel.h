//
//  PhotoViewModel.h
//  FlickrSearch
//
//  Created by Emiel van Liere on 27/06/16.
//  Copyright © 2016 EVL. All rights reserved.
//

#import "PhotoModel.h"

@interface PhotoViewModel : NSObject

// Designated initializer
- (id)initWithPhoto:(PhotoModel *)photo;

@property (nonatomic, readonly, retain) NSURL *photoURL;

@end