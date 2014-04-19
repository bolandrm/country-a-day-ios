//
//  CADMapView2DControllerViewController.h
//  CountryADay
//
//  Created by Ryan Boland on 4/18/14.
//  Copyright (c) 2014 appcasts.io. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CADMapView.h"
#import "CADMapScrollView.h"

@interface CAD2DMapViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet CADMapScrollView *scroller;
@property (weak, nonatomic) IBOutlet CADMapView *mapView;

@end
