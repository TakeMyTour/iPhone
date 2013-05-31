//
//  Node.m
//  GovHack
//
//  Created by Myles on 31/05/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "Node.h"

@interface Node()
{
    
}
-(void)setup;
@end



@implementation Node

@synthesize name = _name;
@synthesize description = _description;
@synthesize images = _images;

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

@end
