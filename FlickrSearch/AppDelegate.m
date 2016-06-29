//
//  AppDelegate.m
//  FlickrSearch
//
//  Created by Emiel van Liere on 27/06/16.
//  Copyright © 2016 EL. All rights reserved.
//

#import "AppDelegate.h"
#import "SearchHistoryTableViewController.h"
#import "FlickrApiClient.h"
#import "PhotosSearchViewModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    FlickrApiClient *apiClient = [[FlickrApiClient alloc] init];
    PhotosSearchViewModel *searchViewModel = [[PhotosSearchViewModel alloc] initWithApiClient:apiClient];
    SearchHistoryTableViewController *searchHistoryTableViewController = [[SearchHistoryTableViewController alloc] initWithSearchViewModel:searchViewModel];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:searchHistoryTableViewController];
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = nc;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
