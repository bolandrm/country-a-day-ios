//
//  CADBoundaryImporter.h
//  CountryADay
//
//  Created by Ryan Boland on 4/18/14.
//  Copyright (c) 2014 appcasts.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CADCountryBoundary.h"
#import "shapefil.h"

@interface CADBoundaryImporter : NSObject

+ (CADBoundaryImporter *)sharedInstance;
- (NSMutableArray *)getBoundaries;

@property (nonatomic, strong) NSMutableArray *boundaries;

@end
