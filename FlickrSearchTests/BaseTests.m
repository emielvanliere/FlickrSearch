//
//  BaseTests.m
//  FlickrSearch
//
//  Created by Emiel van Liere on 28/06/16.
//  Copyright © 2016 EL. All rights reserved.
//

#import "BaseTests.h"

#import <XCTest/XCTest.h>
#import <Mantle/Mantle.h>

@implementation BaseTests

- (void)setUp
{
    [super setUp];
    
    NSDictionary *mockPhoto = @{
                                @"farm": @(1),
                                @"id": @"2",
                                @"secret": @"sekrit",
                                @"server": @"3"
                                };
    
    NSError *error;
    self.photoModel = [MTLJSONAdapter modelOfClass:PhotoModel.class fromJSONDictionary:mockPhoto error:&error];
    XCTAssertNil(error);
    
}

@end
