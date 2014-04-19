//
//  CADMapView2DControllerViewController.m
//  CountryADay
//
//  Created by Ryan Boland on 4/18/14.
//  Copyright (c) 2014 appcasts.io. All rights reserved.
//

#import "CAD2DMapViewController.h"

@interface CAD2DMapViewController ()

@end

@implementation CAD2DMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear {
//    [self.scroller setZoomScale:1.0];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.mapView;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    [self.scroller setProperZoomScale];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float zoomedMapHeight = self.scroller.zoomScale * self.mapView.bounds.size.height;
    float bottomMapViewDisplay = self.scroller.contentOffset.y + self.scroller.bounds.size.height;
    
    [self.scroller setContentSize:self.mapView.bounds.size];
    if (zoomedMapHeight < bottomMapViewDisplay) {
        NSLog(@"offset: %f", self.scroller.contentOffset.y);
        NSLog(@"GO BACK!! content offset: %f", bottomMapViewDisplay - zoomedMapHeight);
        
        //[self.scroller setContentOffset:CGPointMake(self.scroller.contentOffset.x, self.scroller.contentOffset.y - bottomMapViewDisplay - zoomedMapHeight)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
