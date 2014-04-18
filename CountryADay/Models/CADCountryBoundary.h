//
//  CADCountryBoundary.h
//  CountryADay
//
//  Created by Ryan Boland on 4/16/14.
//  Copyright (c) 2014 appcasts.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "shapefil.h"
#import "CADPolygon.h"

@interface CADCountryBoundary : NSObject

@property (nonatomic, strong) NSArray *polygons;
@property (nonatomic, strong) UIColor *color;

@property (nonatomic, assign) double minLat;
@property (nonatomic, assign) double maxLat;
@property (nonatomic, assign) double minLong;
@property (nonatomic, assign) double maxLong;

- (id)initWithShapeObject:(SHPObject *)shape;

@end
