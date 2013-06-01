//
//  Image.m
//  GovHack
//
//  Created by Myles on 1/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "Image.h"
#import "Node.h"
#import "project.h"

@implementation Image

+(Image*)createLocal
{
    NSManagedObjectContext *moc = [DataManager mainContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Image" inManagedObjectContext:moc];
    Image* toRet = [[Image alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:moc];
    return toRet;
}




@dynamic desc;
@dynamic url;
@dynamic images_node_inv;

@end
