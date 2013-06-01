//
//  Tour.m
//  GovHack
//
//  Created by Myles on 31/05/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "Tour+Methods.h"
#import "project.h"



@implementation Tour(Methods)

+(Tour*)createLocal
{
    NSManagedObjectContext *moc = [DataManager mainContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Tour" inManagedObjectContext:moc];
    Tour* toRet = [[Tour alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:moc];
    return toRet;
}

+(Tour*)newObjectFromID:(int)idValue
{
    NSManagedObjectContext *moc = [DataManager mainContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Tour" inManagedObjectContext:moc];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"id = %d", idValue];
    [request setPredicate:predicate];
    NSError* error = nil;
    
    
    NSArray *array = [moc executeFetchRequest:request error:&error];
    if (array.count==0)
    {
        // make one
        Tour* toRet = [[Tour alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:moc];
        toRet.id = [NSNumber numberWithInt:idValue];
        return toRet;
    }
    else
    {
        return [[array lastObject] retain];
    }
}

+(Tour*)newObjectFromDictionary:(NSDictionary*)data
{
    Tour* item = [self newObjectFromID:[[data objectForKey:@"id"] intValue]];
    item.name = [data objectForKey:@"name"];
    NSString* type = [data objectForKey:@"type"];
    if ([type isEqualToString:@"p"])
    {
        item.tour_type = [NSNumber numberWithInt:TourTypeProgressive];
    }
    else
    {
        item.tour_type = [NSNumber numberWithInt:TourTypeBasic];
    }
    
    return item;
}

-(void)setupFromDictionary:(NSDictionary*)data
{
    // this is for pulling down extended data like nodes of the path, etc.
    //self.name = [data objectForKey:@"name"];
    NSArray* nodes = [data objectForKey:@"nodes"];
    if (nodes)
    {
        NSMutableArray* new_node_list = [[NSMutableArray alloc] initWithCapacity:nodes.count];
        for (NSDictionary* node_data in nodes)
        {
            Node* node = [Node newObjectFromDictionary:node_data];
            [new_node_list addObject:node];
        }
        self.nodes = [NSOrderedSet orderedSetWithArray:new_node_list];
        [new_node_list release];
    }
}

-(void)setup
{
    
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
        self.name = name;
        self.tour_type = [NSNumber numberWithInt:tour_type];
    }
    return self;
}


-(id)initFromDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self)
    {
        [super initFromDictionary:dictionary];
        self.name = [dictionary objectForKey:@"name"];
    }
    return self;
}

-(void)addToMap:(MKMapView*)map
{
    for (Node* node in self.nodes)
    {
        [node addToMap:map];
    }
}

@end
