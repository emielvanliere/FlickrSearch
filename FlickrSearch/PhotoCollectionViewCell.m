//
//  PhotoCollectionViewCell.m
//  FlickrSearch
//
//  Created by Emiel van Liere on 27/06/16.
//  Copyright © 2016 EVL. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import <WebImage/WebImage.h>

@interface PhotoCollectionViewCell ()

@property (nonatomic, retain) UIImageView *imageView;

@end

@implementation PhotoCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        self.imageView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.imageView];
        
        NSDictionary *views = @{@"imageView": self.imageView};
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView]|" options:0 metrics:nil views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]|" options:0 metrics:nil views:views]];
        
    }
    
    return self;
}

- (void)configureWithViewModel:(PhotoViewModel *)viewModel
{
    [self.imageView sd_setImageWithURL:viewModel.photoURL];
}

@end
