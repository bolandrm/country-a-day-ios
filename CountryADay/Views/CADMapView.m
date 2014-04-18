//
//  CADMapView.m
//  CountryADay
//
//  Created by Ryan Boland on 4/18/14.
//  Copyright (c) 2014 appcasts.io. All rights reserved.
//

#import "CADMapView.h"
#import "CADBoundaryImporter.h"
#import <MapKit/MapKit.h>


@interface CADMapView ()

@property (nonatomic, strong) NSMutableArray *countryBoundaries;

@end


@implementation CADMapView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}


- (void)commonInit {
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    NSLog(@"Width: %f, Height: %f", self.bounds.size.width, self.bounds.size.height);
    
    self.countryBoundaries = [[CADBoundaryImporter sharedInstance] getBoundaries];
    
    for (CADCountryBoundary *boundary in self.countryBoundaries) {
        for (CADPolygon *polygon in boundary.polygons) {
            int count = [polygon.coordinates count];
            
            CGMutablePathRef path = CGPathCreateMutable();
            
            for (int c = 0; c < count; c++) {
                NSValue *coordValue = polygon.coordinates[c];
                CLLocationCoordinate2D coord = [coordValue MKCoordinateValue];
                
                if (c == 0) {
                    CGPathMoveToPoint(path, NULL, (coord.longitude + 180.0f) * (self.bounds.size.width / 360), self.bounds.size.height - (coord.latitude + 90.0f) * (self.bounds.size.height / 180));
                } else {
                    CGPathAddLineToPoint(path, NULL, (coord.longitude + 180.0f) * (self.bounds.size.width / 360), self.bounds.size.height - (coord.latitude + 90.0f) * (self.bounds.size.height / 180));
                }
                
            }
            CGPathCloseSubpath(path);
            CGContextAddPath(context, path);
            CGContextFillPath(context);
            CGContextAddPath(context, path);
            CGContextStrokePath(context);
            CFRelease(path);
        }
    }
    
    

}


@end
