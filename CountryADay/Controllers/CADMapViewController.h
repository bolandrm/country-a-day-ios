//
//  CADMapViewController.h
//  CountryADay
//
//  Created by Ryan Boland on 4/16/14.
//  Copyright (c) 2014 appcasts.io. All rights reserved.
//


#import "CADCountryBoundary.h"
#import <MapKit/MapKit.h>

@interface CADMapViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
