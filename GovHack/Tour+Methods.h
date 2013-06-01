//
//  Tour.h
//  GovHack
//
//  Created by Myles on 31/05/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Tour.h"

typedef enum
{
    TourTypeBasic,
    TourTypeProgressive
} TourType;


@interface Tour (Methods)

+(Tour*)createLocal;
+(Tour*)newObjectFromDictionary:(NSDictionary*)data;

-(void)setupFromDictionary:(NSDictionary*)data;

-(void)setup;
-(id)init;
-(id)init:(NSString*)name tour_type:(int)type;
-(id)initFromDictionary:(NSDictionary*)dictionary;
-(void)addToMap:(MKMapView*)map;

@end
