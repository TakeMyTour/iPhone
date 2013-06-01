//
//  Tour.h
//  GovHack
//
//  Created by Myles on 31/05/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef enum
{
    TourTypeBasic,
    TourTypeProgressive
} TourType;


@interface Tour : NSObject

-(id)init;
-(id)init:(NSString*)name tour_type:(int)type;
-(void)addToMap:(MKMapView*)map;

@property (copy, nonatomic) NSString* name;
@property (assign, nonatomic) int tour_type;
@property (retain, nonatomic) NSMutableArray* nodes;
@end
