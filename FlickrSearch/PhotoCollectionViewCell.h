//
//  PhotoCollectionViewCell.h
//  FlickrSearch
//
//  Created by Emiel van Liere on 27/06/16.
//  Copyright © 2016 EVL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoViewModel.h"

@interface PhotoCollectionViewCell : UICollectionViewCell

- (void)configureWithViewModel:(PhotoViewModel *)viewModel;

@end
