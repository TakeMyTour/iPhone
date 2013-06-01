//
//  Options.m
//  GovHack
//
//  Created by Myles on 1/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "Options+Methods.h"
#import "project.h"

@implementation Options (Methods)


+(Options*)createLocal
{
    NSManagedObjectContext *moc = [DataManager mainContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Options" inManagedObjectContext:moc];
    Options* toRet = [[Options alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:moc];
    return toRet;
}

+(Options*)newObjectForID:(int)idValue
{
    NSManagedObjectContext *moc = [DataManager mainContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Options" inManagedObjectContext:moc];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"id = %d", idValue];
    [request setPredicate:predicate];
    NSError* error = nil;
    
    
    NSArray *array = [moc executeFetchRequest:request error:&error];
    if (array.count==0)
    {
        // make one
        Options* toRet = [Options createLocal];
        toRet.id = [NSNumber numberWithInt:idValue];
        return toRet;
    }
    else
    {
        return [[array lastObject] retain];
    }
}


+(Options*)sharedInstance
{
    static Options* __options = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        __options = [Options newObjectForID:1];
        
        // This is where we may choose to load options from a file
        __options.baseURL = @"http://unleashed.oeg.com.au";
        
    });
    return __options;
}


-(void)setBaseURL:(NSString *)baseURL
{
    [self setPrimitiveValue:[baseURL copy] forKey:@"baseURL"];
    [ClientManager clearCurrentClient];
}







@end
