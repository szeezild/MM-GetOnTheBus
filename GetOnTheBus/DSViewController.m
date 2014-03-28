//
//  DSViewController.m
//  GetOnTheBus
//
//  Created by Dan Szeezil on 3/25/14.
//  Copyright (c) 2014 Dan Szeezil. All rights reserved.
//


#import "DSViewController.h"
#import "DetailViewController.h"
#import "BusStopAnnotation.h"




@interface DSViewController () <MKMapViewDelegate>
{
    
//    NSArray *busStops;
    
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property BOOL userLocationUpdated;


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
        NSArray *busStops = jsonData[@"row"];
       

        for (NSDictionary *stop in busStops) {
            
            NSString *lat = stop[@"latitude"];
            NSString *lng = stop[@"longitude"];
            
            CLLocationCoordinate2D stopCoord = CLLocationCoordinate2DMake([lat doubleValue], [lng doubleValue]);
//            MKCoordinateSpan coordSpan = MKCoordinateSpanMake(.4, .4);
//            
//            MKCoordinateRegion region = MKCoordinateRegionMake(stopCoord, coordSpan);
//
//            make map recenter on user
            
            
//            self.mapView.region = region;
            
            BusStopAnnotation *annotation = [[BusStopAnnotation alloc]init];
            annotation.coordinate = stopCoord;
            annotation.busStopAnnotDict = stop;
            
            annotation.title = stop[@"cta_stop_name"];
            annotation.subtitle = stop[@"routes"];
            
            
            [self.mapView addAnnotation:annotation];
            
            
        }
        
        
//        sets center as average of all bus stops
//        This DOESNT WORK BECAUSE OF BAD DATA POINT IN CTA DATA
//        CLLocationCoordinate2D avgCoordinate = CLLocationCoordinate2DMake(0, 0);
//        
//        for (NSDictionary*stop in busStops) {
//            double lat = [stop[@"latitude"] doubleValue];
//            double lng = [stop[@"longitude"] doubleValue];
//            
//            avgCoordinate.latitude += lat;
//            avgCoordinate.longitude += lng;
//        }
//        
//        avgCoordinate.latitude /= busStops.count;
//        avgCoordinate.longitude /= busStops.count;

        
        CLLocationCoordinate2D centerCoord = CLLocationCoordinate2DMake(41.893,-87.6353);
        MKCoordinateSpan coordSpan = MKCoordinateSpanMake(.4, .4);
        MKCoordinateRegion region = MKCoordinateRegionMake(centerCoord, coordSpan);
        self.mapView.region = region;

//        

//        MKCoordinateSpan coordSpan = MKCoordinateSpanMake(.4, .4);
//        MKCoordinateRegion region = MKCoordinateRegionMake(avgCoordinate, coordSpan);
        

//        [self.mapView reloadInputViews];
        
    }];
    
}

//  customize pin annotation method
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    pin.canShowCallout = YES;
    pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    
    return pin;
    
}

//  delegate method that shows when info pin was tapped
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    
    [self performSegueWithIdentifier:@"mySegue" sender:view];
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(MKAnnotationView *)sender {
    
    DetailViewController *vc = segue.destinationViewController;
    BusStopAnnotation *annotation = sender.annotation;
    
    vc.busStopDictionary = annotation.busStopAnnotDict;
    
}



//  Delegate method to center map on user location

//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
//    
//    [self.mapView setCenterCoordinate:userLocation.location.coordinate];
//    self.userLocationUpdated = YES;
//    
//    
//}



@end








