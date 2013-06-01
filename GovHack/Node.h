//
//  Node.h
//  GovHack
//
//  Created by Myles on 31/05/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface Node : NSObject

-(id)init;

-(id)init:(NSString*)name;

-(void)addToMap:(MKMapView*)map;

@property (copy, nonatomic) NSString* name;
@property (copy, nonatomic) NSString* description;
@property (retain, nonatomic) NSMutableArray* images;
@property (assign, nonatomic) double longitude;
@property (assign, nonatomic) double latitude;
@property (copy, nonatomic) NSString* address;

@end
