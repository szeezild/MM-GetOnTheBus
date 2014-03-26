//
//  DSViewController.m
//  GetOnTheBus
//
//  Created by Dan Szeezil on 3/25/14.
//  Copyright (c) 2014 Dan Szeezil. All rights reserved.
//

#import "DSViewController.h"

@interface DSViewController () <MKMapViewDelegate>
{
    
    NSArray *busStops;
    
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end

@implementation DSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView.showsUserLocation = YES;
	
    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/bus.json"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSError *error;
        
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        // set meetings array to data
        busStops = jsonData[@"row"];
        
        
        for (int i=0; i < busStops.count; i++) {
        
            NSDictionary *stop = busStops[i];
        
            NSString *lat = stop[@"latitude"];
            NSString *lng = stop[@"longitude"];
        
            CLLocationCoordinate2D stopCoord = CLLocationCoordinate2DMake([lat doubleValue], [lng doubleValue]);
            MKCoordinateSpan coordSpan = MKCoordinateSpanMake(.4, .4);
            MKCoordinateRegion region = MKCoordinateRegionMake(stopCoord, coordSpan);
            self.mapView.region = region;
        
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
        
            annotation.coordinate = stopCoord;
            annotation.title = @"bus stop";
            [self.mapView addAnnotation:annotation];
        }
        
//        self.mapView.delegate = self;
        
        CLLocationCoordinate2D centerCoord = CLLocationCoordinate2DMake(41.893,-87.6353);
        MKCoordinateSpan coordSpan = MKCoordinateSpanMake(.4, .4);
        MKCoordinateRegion region = MKCoordinateRegionMake(centerCoord, coordSpan);
        self.mapView.region = region;
        
        
//        [self.mapView reloadInputViews];
        
    }];
    
}

//- (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation {
//    MKCoordinateRegion region;
//    MKCoordinateSpan span;
//    span.latitudeDelta = 0.005;
//    span.longitudeDelta = 0.005;
//    CLLocationCoordinate2D location;
//    location.latitude = aUserLocation.coordinate.latitude;
//    location.longitude = aUserLocation.coordinate.longitude;
//    region.span = span;
//    region.center = location;
//    [aMapView setRegion:region animated:YES];
//}



@end
