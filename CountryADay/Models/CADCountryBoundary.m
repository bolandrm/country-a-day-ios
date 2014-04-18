//
//  CADCountryBoundary.m
//  CountryADay
//
//  Created by Ryan Boland on 4/16/14.
//  Copyright (c) 2014 appcasts.io. All rights reserved.
//

#import "CADCountryBoundary.h"
#import <MapKit/MapKit.h>

@implementation CADCountryBoundary


- (id)initWithShapeObject:(SHPObject *)shape {
    self = [super init];
    if (self) {
        int numParts = shape->nParts;
        int totalVertexCount = shape->nVertices;
        
        self.minLat = shape->dfYMin;
        self.maxLat = shape->dfYMax;
        self.minLong = shape->dfXMin;
        self.minLong = shape->dfXMax;
        
        self.color = [[UIColor redColor] colorWithAlphaComponent:0.7];
        
        NSMutableArray *polygons = [NSMutableArray arrayWithCapacity:numParts];
        
        for (int i = 0; i < numParts; i++) {
            int startVertex = shape->panPartStart[i];
            int partVertexCount = (i == numParts - 1) ? totalVertexCount - startVertex : shape->panPartStart[i+1] - startVertex;
            
            CADPolygon *polygon = [[CADPolygon alloc] init];
            NSMutableArray *coordinates = [NSMutableArray arrayWithCapacity:partVertexCount];
            
            int endIndex = startVertex + partVertexCount;
            for (int pv = startVertex; pv < endIndex; pv++) {
                CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(shape->padfY[pv], shape->padfX[pv]);

                [coordinates addObject:[NSValue valueWithMKCoordinate:coord]];
                polygon.coordinates = coordinates;
            }
            [polygons addObject:polygon];
        }
        self.polygons = polygons;
    }
    return self;
}

@end