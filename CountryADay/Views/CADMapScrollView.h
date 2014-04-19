//
//  CADMapScroll.h
//  CountryADay
//
//  Created by Ryan Boland on 4/19/14.
//  Copyright (c) 2014 appcasts.io. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CADMapView.h"

@interface CADMapScrollView : UIScrollView

@property (nonatomic, strong) CADMapView *mapView;

- (void)setProperZoomScale;

@end
