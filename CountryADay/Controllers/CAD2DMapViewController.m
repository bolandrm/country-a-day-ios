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

- (void)loadView {
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    CADMapScrollView *scroller = [[CADMapScrollView alloc] initWithFrame:frame];
    scroller.maximumZoomScale = 3.0;
    scroller.minimumZoomScale = 0.33;
    scroller.delegate = self;
    
    CADMapView *mapView = [[CADMapView alloc] initWithFrame:CGRectMake(0, 0, 12*360, 12*180)];
    
    scroller.contentSize = mapView.bounds.size;
    [scroller addSubview:mapView];
    self.view = scroller;
    
    self.scroller = scroller;
    self.mapView = mapView;
    
    [self performSelector:@selector(initialZoom) withObject:nil afterDelay:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.scroller setZoomScale:0.5];
//    NSLog(@"GOT HERE");
}

- (void)initialZoom {
        NSLog(@"GOT HERE");
    [self.scroller setZoomScale:1.0 animated:NO];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.mapView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    //[self.mapView setNeedsDisplay];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self.scroller setProperZoomScale];
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
