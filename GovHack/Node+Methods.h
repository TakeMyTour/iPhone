//
//  Node.h
//  GovHack
//
//  Created by Myles on 31/05/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Node.h"
@interface Node (Methods)

+(Node*)createLocal;

-(void)setup;
-(id)init;

-(id)init:(NSString*)name;

-(void)addToMap:(MKMapView*)map;

@end
