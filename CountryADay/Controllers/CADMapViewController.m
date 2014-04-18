//
//  CADMapViewController.m
//  CountryADay
//
//  Created by Ryan Boland on 4/16/14.
//  Copyright (c) 2014 appcasts.io. All rights reserved.
//

#import "CADMapViewController.h"
#import <UIKit/UIKit.h>
#import "shapefil.h"
#import "CADBoundaryImporter.h"

@interface CADMapViewController ()

@property (nonatomic, strong) NSMutableArray *countryBoundaries;

@end

@implementation CADMapViewController

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
    [self readShapeAttributes];
    self.countryBoundaries = [[CADBoundaryImporter sharedInstance] getBoundaries];
    
    for (CADCountryBoundary *boundary in self.countryBoundaries) {
        for (CADPolygon *polygon in boundary.polygons) {
            int count = [polygon.coordinates count];
            CLLocationCoordinate2D coords[count];
            
            for (int c = 0; c < count; c++) {
                NSValue *coordValue = polygon.coordinates[c];
                CLLocationCoordinate2D coord = [coordValue MKCoordinateValue];
                NSLog(@"NEW - lat: %f, lng: %f", coord.latitude, coord.longitude);
                coords[c] = coord;
            }
            MKPolygon *polygon = [MKPolygon polygonWithCoordinates:coords count:count];
            [self.mapView addOverlay:polygon];
        }
    }
    [super viewDidLoad];
}

- (void)readShapeAttributes {
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *dbfPath = [resourcePath stringByAppendingPathComponent:@"TM_WORLD_BORDERS_SIMPL.dbf"];
    
    const char *pszPath = [dbfPath cStringUsingEncoding:NSUTF8StringEncoding];
    DBFHandle dbf = DBFOpen(pszPath, "rb");
    
    int fieldCount = DBFGetFieldCount(dbf);
    for (int i = 0; i < fieldCount; i++) {
        char fieldName[12];
        int width;
        int numDecimals;
        DBFFieldType type = DBFGetFieldInfo(dbf, i, fieldName, &width, &numDecimals);
        NSString *typeString = [self descriptionForFieldType:type];
        
        NSLog(@"Column %d: %s (%@)", i, fieldName, typeString);
    }
    
    int recordCount = DBFGetRecordCount(dbf);
    for (int row = 0; row < recordCount; row++) {
        int nameIndex = DBFGetFieldIndex(dbf, "NAME");
        const char *_name = DBFReadStringAttribute(dbf, row, nameIndex);
        NSString *name = [[NSString alloc] initWithUTF8String:_name];
        
        int iso2Index = DBFGetFieldIndex(dbf, "ISO2");
        const char *_iso2 = DBFReadStringAttribute(dbf, row, iso2Index);
        NSString *iso2 = [[NSString alloc] initWithUTF8String:_iso2];
        
        NSLog(@"%d - %@, %@", row, iso2, name);
    }
    
    DBFClose(dbf);
}

- (NSString *)descriptionForFieldType:(DBFFieldType)fieldType {
    switch (fieldType) {
        case FTDouble:
            return @"double";
        case FTInteger:
            return @"integer";
        case FTString:
            return @"string";
        case FTLogical:
            return @"logical";
        case FTInvalid:
            return @"<invalid>";
        default:
            return @"<unknown>";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Mapview delegate

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
        MKPolygonRenderer *renderer = [[MKPolygonRenderer alloc] initWithPolygon:overlay];
        renderer.fillColor = [UIColor blueColor];
        NSLog(@"Made it!!");
        return renderer;
//        return renderer;
//        MKPolygonView *view = [[MKPolygonView alloc] initWithPolygon:overlay];
//        view.strokeColor = [UIColor blueColor];
//        view.lineWidth = 2;
//        view.lineCap = round;
//        view.fillColor = [UIColor redColor];
//        return view;
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
