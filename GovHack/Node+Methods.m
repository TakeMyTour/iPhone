//
//  Node.m
//  GovHack
//
//  Created by Myles on 31/05/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "Node+Methods.h"
#import "project.h"


@implementation Node(Methods)



+(Node*)createLocal
{
    NSManagedObjectContext *moc = [DataManager mainContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Node" inManagedObjectContext:moc];
    Node* toRet = [[Node alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:moc];
    return toRet;
}

+(Node*)newObjectForID:(int)idValue
{
    NSManagedObjectContext *moc = [DataManager mainContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Node" inManagedObjectContext:moc];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"id = %d", idValue];
    [request setPredicate:predicate];
    NSError* error = nil;
    
    
    NSArray *array = [moc executeFetchRequest:request error:&error];
    if (array.count==0)
    {
        // make one
        Node* toRet = [[Node alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:moc];
        toRet.id = [NSNumber numberWithInt:idValue];
        return toRet;
    }
    else
    {
        return [[array lastObject] retain];
    }
}

+(NSArray*)imagesFromImageList:(NSArray*)image_list
{
    NSMutableArray* toRet = [[NSMutableArray alloc] init];
    for (NSDictionary* data in image_list)
    {
        Image* image = [Image createLocal];
        image.url = [data objectForKey:@"url"];
        image.desc = [data objectForKey:@"description"];
        
        [toRet addObject:image];
    }
    return toRet;
}

+(Node*)newObjectFromDictionary:(NSDictionary*)data
{
    Node* item = [self newObjectForID:[[data objectForKey:@"id"] intValue]];
    if ([data objectForKey:@"hint"] && [data objectForKey:@"hint"]!=[NSNull null])
    {
        item.hint_desc = [data objectForKey:@"hint"];
    }
    if ([[data objectForKey:@"hint_image"] isKindOfClass:[NSString class]])
    {
        item.hint_image = [data objectForKey:@"hint_image"];
    }
    item.nodes_inverse = [Tour newObjectFromID:[[data objectForKey:@"tour_id"] intValue]];
    item.name = [data objectForKey:@"name"];
    item.address = [data objectForKey:@"address"];
    item.description_text = [data objectForKey:@"desc"];
    item.images = [NSOrderedSet orderedSetWithArray:[self imagesFromImageList:[data objectForKey:@"images"]]];
    return item;
}


-(void)refreshData:(void(^)())success
{
    NSString* path = [NSString stringWithFormat:@"/tour/%d", [self.id intValue]];
    NSDictionary* params = [[NSDictionary alloc] init];
    NSMutableURLRequest* request = [ClientManager requestWithMethod:@"GET" path:path parameters:nil];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    AFJSONRequestOperation* operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success_:^(AFJSONRequestOperation*operation) {
       // NSLog(@"Success! %@", operation.responseJSON);
        [self setupFromDictionary:operation.responseJSON];
       // [_tableview reloadData];
        success();
    } failure_:^(AFJSONRequestOperation*operation) {
        NSString* response = [operation responseJSON] ? [operation responseJSON] : [operation responseString];
        NSLog(@"Failure: %@", response);
        NSLog(@"error: %@", [[operation error] description]);
    }];
    
    [params release];
    [operation start];
}

-(void)setup
{
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
            CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(self.gps_longitude.doubleValue, self.gps_latitude.doubleValue);
            
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
