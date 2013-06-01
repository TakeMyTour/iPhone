//
//  User+Methods.m
//  GovHack
//
//  Created by Myles on 1/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "User+Methods.h"
#import "project.h"
@implementation User (Methods)


+(User*)sharedInstance
{
    static User* __user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __user = [User newObjectForID:1];
    });
    return __user;
}

+(User*)createLocal
{
    NSManagedObjectContext *moc = [DataManager mainContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"User" inManagedObjectContext:moc];
    User* toRet = [[User alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:moc];
    return toRet;
}

+(User*)newObjectForID:(int)idValue
{
    NSManagedObjectContext *moc = [DataManager mainContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"User" inManagedObjectContext:moc];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"id = %d", idValue];
    [request setPredicate:predicate];
    NSError* error = nil;
    
    
    NSArray *array = [moc executeFetchRequest:request error:&error];
    if (array.count==0)
    {
        // make one
        User* toRet = [[User alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:moc];
        toRet.id = [NSNumber numberWithInt:idValue];
        return toRet;
    }
    else
    {
        return [[array lastObject] retain];
    }
}








@end
