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
    UIColor *blue = [UIColor colorWithRed:120.0/255 green:204.0/255 blue:246.0/255 alpha:1.0];
    [self setBackgroundColor:blue];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSLog(@"drawing!!");
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *lightGreen = [UIColor colorWithRed:166.0/255 green:212.0/255 blue:76.0/255 alpha:1.0];
    UIColor *darkGreen = [UIColor colorWithRed:124.0/255 green:161.0/255 blue:50.0/255 alpha:1.0];
    UIColor *blue = [UIColor colorWithRed:120.0/255 green:204.0/255 blue:246.0/255 alpha:1.0];
    
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextSetStrokeColorWithColor(context, [blue CGColor]);
    CGContextSetLineWidth(context, 1);
    CGContextSetLineCap(context, kCGLineCapSquare);
    
    float mapHeight = self.bounds.size.height;
    float mapWidth = self.bounds.size.width;
    
    self.countryBoundaries = [[CADBoundaryImporter sharedInstance] getBoundaries];
    
    for (CADCountryBoundary *boundary in self.countryBoundaries) {
        for (CADPolygon *polygon in boundary.polygons) {
            int count = [polygon.coordinates count];
            
            CGMutablePathRef path = CGPathCreateMutable();
            
            for (int c = 0; c < count; c++) {
                NSValue *coordValue = polygon.coordinates[c];
                CLLocationCoordinate2D coord = [coordValue MKCoordinateValue];
                
                if (c == 0) {
                    CGPathMoveToPoint(path, NULL, (coord.longitude + 180.0f) * (mapWidth / 360), mapHeight - (coord.latitude + 90.0f) * (mapHeight / 180));
                } else {
                    CGPathAddLineToPoint(path, NULL, (coord.longitude + 180.0f) * (mapWidth / 360), mapHeight - (coord.latitude + 90.0f) * (mapHeight / 180));
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
