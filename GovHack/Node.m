//
//  Node.m
//  GovHack
//
//  Created by Myles on 31/05/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "Node.h"
#import "project.h"

@interface Node()
{
    
}
-(void)setup;
@end



@implementation Node

@synthesize name = _name;
@synthesize description = _description;
@synthesize images = _images;

@synthesize longitude;
@synthesize latitude;
@synthesize address = _address;



-(void)setup
{
    NSMutableArray* images = [[NSMutableArray alloc] init];
    _images = images;
}

-(id)init
{
    if (self = [super init])
    {
        [self setup];
    }
    return self;
}

-(id)init:(NSString*)name
{
    if (self = [super init])
    {
        [self setup];
        self.name = name;
    }
    return self;
}

-(void)addToMap:(MKMapView*)map
{
    if (map==nil)
    {
        return;
    }
    {
        if (self.address!=nil)
        {
            NSString *location = self.address;
            CLGeocoder *geocoder = [[CLGeocoder alloc] init];
            [geocoder geocodeAddressString:location
                         completionHandler:^(NSArray* placemarks, NSError* error){
                             if (placemarks && placemarks.count > 0) {
                                 CLPlacemark *topResult = [placemarks objectAtIndex:0];
                                 MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                                 
                                 MKCoordinateRegion region = map.region;
                                 region.center = placemark.region.center;
                                 region.span.longitudeDelta = 0.02;
                                 region.span.latitudeDelta = 0.02;
                                 
                                 [map setRegion:region animated:YES];
                                 MKPointAnnotation* point = [[MKPointAnnotation alloc] init];
                                 point.coordinate = placemark.coordinate;
                                 point.title = self.name;
                                 [map addAnnotation:point];
                                 //[map addAnnotation:placemark];
                             }
                         }
             ];
        }
        else
        {
            CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(self.longitude, self.latitude);
            
            MKPlacemark* placemark = [[MKPlacemark alloc] initWithCoordinate:loc addressDictionary:nil];
            
            MKPointAnnotation* point = [[MKPointAnnotation alloc] init];
            point.coordinate = placemark.coordinate;
            point.title = self.name;
            
            MKCoordinateRegion region = map.region;
            // region.center = placemark.region.center;
            region.center = point.coordinate;
            region.span.longitudeDelta = 0.02;
            region.span.latitudeDelta = 0.02;
            [map setRegion:region];
            [map addAnnotation:point];
        }
    }
}

@end
