//
//  Tour.m
//  GovHack
//
//  Created by Myles on 31/05/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "Tour.h"


@interface Tour()
{
    
}

-(void)setup;

@end

@implementation Tour

@synthesize name = _name;
@synthesize tour_type = _tour_type;
@synthesize nodes = _nodes;

-(void)setup
{
    _nodes = [[NSMutableArray alloc] init];
}

-(id)init
{
    self = [super init];
    if (self)
    {
        [self setup];
    }
    return self;
}

-(id)init:(NSString*)name tour_type:(int)tour_type
{
    if (self==[super init])
    {
        [self setup];
        _name = name;
        _tour_type = tour_type;
    }
    return self;
}


@end
