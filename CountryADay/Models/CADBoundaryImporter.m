//
//  CADBoundaryImporter.m
//  CountryADay
//
//  Created by Ryan Boland on 4/18/14.
//  Copyright (c) 2014 appcasts.io. All rights reserved.
//

#import "CADBoundaryImporter.h"

@implementation CADBoundaryImporter

+ (CADBoundaryImporter *)sharedInstance {
    static dispatch_once_t predicate = 0;
    __strong static id sharedObject = nil;
    dispatch_once(&predicate, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

- (NSMutableArray *)getBoundaries {
    if (self.boundaries != NULL) {
        NSLog(@"boundaries already loaded");
        return self.boundaries;
    }
    NSLog(@"loading boundaries ...");
    
    NSString *dataSet = @"ne_110m_admin_0_countries";
//    NSString *dataSet = @"TM_WORLD_BORDERS";
//    NSString *dataSet = @"TM_WORLD_BORDERS";
    
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *shpPath = [resourcePath stringByAppendingPathComponent:dataSet];

    const char *pszPath = [shpPath cStringUsingEncoding:NSUTF8StringEncoding];
    SHPHandle shp = SHPOpen(pszPath, "rb");

    int numCountries;
    int shapeType;
    SHPGetInfo(shp, &numCountries, &shapeType, NULL, NULL);

    self.boundaries = [NSMutableArray arrayWithCapacity:numCountries];

//    for (int i = 208; i < 209; i++) {
    for (int i = 0; i < numCountries; i++) {
        SHPObject *shpObject = SHPReadObject(shp, i);
        CADCountryBoundary *countryBoundary = [[CADCountryBoundary alloc] initWithShapeObject:shpObject];
        [self.boundaries addObject:countryBoundary];
    }

    SHPClose(shp);
    
    return self.boundaries;
}


@end
