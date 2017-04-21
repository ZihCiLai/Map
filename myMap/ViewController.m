//
//  ViewController.m
//  myMap
//
//  Created by Lai Zih Ci on 2016/12/1.
//  Copyright © 2016年 ZihCi. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>
{
    CLLocationManager *locationManager;
    BOOL firstLocationReceived;
}
@property (weak, nonatomic) IBOutlet MKMapView *mkMymap;
@end

@implementation ViewController
- (IBAction)segmanted:(UISegmentedControl *)sender {
    NSInteger targerIndex = [sender selectedSegmentIndex];
    switch (targerIndex) {
        case 0:
            _mkMymap.mapType = MKMapTypeStandard;
            break;
        case 1:
            _mkMymap.mapType = MKMapTypeSatellite;
            break;
        case 2:
            _mkMymap.mapType = MKMapTypeHybrid;
            break;
        case 3:
            _mkMymap.mapType = MKMapTypeHybridFlyover;
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(40.7484405, -73.9856644);
            MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:coordinate fromDistance:800 pitch:65 heading:0];
            _mkMymap.camera = camera;
            
            break;
       // default:
           // break;
    }
}
- (IBAction)segmentedModeChange:(UISegmentedControl *)sender {
    NSInteger targerIndex = [sender selectedSegmentIndex];
    switch (targerIndex) {
        case 0:
            _mkMymap.userTrackingMode = MKUserTrackingModeNone;
            break;
        case 1:
            _mkMymap.userTrackingMode = MKUserTrackingModeFollow;
            break;
        case 2:
            _mkMymap.userTrackingMode = MKUserTrackingModeFollowWithHeading;
            break;
        
    }
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation * currentLocation = locations.lastObject;
    CLLocationCoordinate2D coordinate = currentLocation.coordinate;
    NSLog(@"Current Location:%.6f,%.6f",coordinate.latitude,coordinate.longitude);
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
        MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
        [_mkMymap setRegion:region animated:YES];
        region = _mkMymap.region;
        
        //自訂一個座標資料
        CLLocationCoordinate2D storeCoordinate = coordinate;
        storeCoordinate.latitude += 0.0005;
        storeCoordinate.longitude += 0.0005;
        MKPointAnnotation * annotation = [MKPointAnnotation new];
        annotation.coordinate = storeCoordinate;
        annotation.title = @"kent";
        annotation.subtitle = @"齁甲";
        
        [_mkMymap addAnnotation:annotation];
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [CLLocationManager new];
    [locationManager requestWhenInUseAuthorization];
    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    locationManager.delegate = self;
    
    [locationManager startUpdatingLocation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - MKMapViewDelegate
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    MKCoordinateRegion region = _mkMymap.region;
}

//修改大頭針
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if(annotation == mapView.userLocation) {
        return nil;
    }
    NSString*storeID = @"store";
//    MKPinAnnotationView *result = (MKPinAnnotationView*) [mapView dequeueReusableAnnotationViewWithIdentifier:storeID];
    MKAnnotationView *result = (MKPinAnnotationView*) [mapView dequeueReusableAnnotationViewWithIdentifier:storeID];
    if (result ==nil) {
//        result = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:storeID];
        result = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:storeID];
    } else {
        result.annotation = annotation;
    }
    result.canShowCallout = YES;
//    result.animatesDrop = YES;
    //result.pinColor = MKPinAnnotationColorGreen;
//    result.pinTintColor = [UIColor blueColor];
    
    //左邊
    UIImage* image = [UIImage imageNamed:@"star"];
    result.leftCalloutAccessoryView = [[UIImageView alloc] initWithImage:image];
    //右邊
    UIButton* button=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    result.rightCalloutAccessoryView = button;
    
    //use our own image
    result.image = image;
    return result;
}

-(void)buttonTapped:(id)sender{
    UIAlertController*alert = [UIAlertController alertControllerWithTitle:nil message:@"Button Tapped." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok= [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
