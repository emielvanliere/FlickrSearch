//
//  PhotoSearchResultViewController.m
//  FlickrSearch
//
//  Created by Emiel van Liere on 27/06/16.
//  Copyright © 2016 EVL. All rights reserved.
//

#import "PhotoSearchResultViewController.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoViewModel.h"
#import "SearchHistoryTableViewController.h"

@interface PhotoSearchResultViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, retain) PhotosSearchViewModel *searchViewModel;
@property (nonatomic, retain) UICollectionView *photosCollectionView;

@end

@implementation PhotoSearchResultViewController

static NSString *kPhotoCellIdentifier = @"PhotoCellId";

- (id)initWithViewModel:(PhotosSearchViewModel *)searchViewModel
{
    if (self = [super init]) {
        self.searchViewModel = searchViewModel;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat spacing = 0.5;
    CGFloat columns = 3.0;
    CGFloat dim = (UIScreen.mainScreen.bounds.size.width - columns * spacing) / columns;
    layout.itemSize = CGSizeMake(dim, dim);
    [layout setMinimumInteritemSpacing:spacing];
    [layout setMinimumLineSpacing:spacing];
    
    self.photosCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.photosCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.photosCollectionView.dataSource = self;
    self.photosCollectionView.delegate = self;
    [self.photosCollectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:kPhotoCellIdentifier];
    self.photosCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.photosCollectionView];
    
    NSDictionary *views = @{@"photosCollectionView": self.photosCollectionView};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[photosCollectionView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[photosCollectionView]|" options:0 metrics:nil views:views]];
}

- (void)newSearchWithQuery:(NSString *)searchQuery
{
    [self.searchViewModel cancelSearch];
    [self.photosCollectionView reloadData];
    
    self.searchViewModel.searchQuery = searchQuery;
    [self loadPhotos];
}

- (void)loadPhotos
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [self.searchViewModel searchPhotosWithCompletion:^(NSError *error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (error) {
            [self showError:error];
        } else {
            [self.photosCollectionView reloadData];
        }
    }];
}

- (void)showError:(NSError *)error
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Error", nil)
                                                                             message:[error localizedDescription]
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alertController addAction:defaultAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.searchViewModel.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPhotoCellIdentifier forIndexPath:indexPath];
    
    PhotoViewModel *photoViewModel = self.searchViewModel.photos[indexPath.row];
    [cell configureWithViewModel:photoViewModel];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchViewModel.canLoadMore && indexPath.row == self.searchViewModel.photos.count - 1) {
        [self loadPhotos];
    }
}

#pragma mark - SearchHistoryTableViewControllerDelegate
- (void)searchHistoryTableViewController:(SearchHistoryTableViewController *)searchHistoryTableViewController didSearchWithQuery:(NSString *)searchQuery
{
    [self newSearchWithQuery:searchQuery];
}

@end
