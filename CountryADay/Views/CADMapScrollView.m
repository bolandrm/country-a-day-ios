//
//  CADMapScroll.m
//  CountryADay
//
//  Created by Ryan Boland on 4/19/14.
//  Copyright (c) 2014 appcasts.io. All rights reserved.
//

#import "CADMapScrollView.h"

@implementation CADMapScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setProperZoomScale {
    if (self.mapView == NULL) {
        self.mapView = self.subviews[0];
    }
    float mapHeight = self.mapView.bounds.size.height;
    float mapWidth = self.mapView.bounds.size.width;
    // We use the width here because the orientation has not yet changed.
    float scrollerHeight = self.bounds.size.width;
    
    NSLog(@"vc - MapH: %f", mapHeight);
    NSLog(@"vc - SVH: %f", scrollerHeight);
    [self setMinimumZoomScale: scrollerHeight/mapHeight];
//    [self setZoomScale:1];
//    [self setContentSize:self.mapView];
}

@end
