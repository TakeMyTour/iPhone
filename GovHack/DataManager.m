
//
//  DataManager.m
//  GovHack
//
//  Created by Myles on 1/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "DataManager.h"
#import "project.h"

@implementation DataManager

+(void)save
{
    NSError* error = nil;
    [[self mainContext] save:&error];
    if (error)
    {
        NSLog(@"Error saving context: %@", error);
    }
}

+(void)setup
{
    NSURL* url = [[NSFileManager defaultManager] URLForDirectory:NSLibraryDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
    NSManagedObjectContext* context = [self mainContext];
    [context setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
    [[NSPersistentStore alloc] initWithPersistentStoreCoordinator:[self persistentStoreCoordinator] configurationName:@"" URL:url options:nil];
    
    NSError* err = nil;
    [[self persistentStoreCoordinator] addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[url URLByAppendingPathComponent:@"currentStore.sql"] options:nil error:&err];
    if (err)
    {
        NSLog(@"%@", err);
    }
}

+(NSManagedObjectContext*)mainContext
{
    static NSManagedObjectContext* context = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    });
    return context;
}

+(NSManagedObjectModel*)managedObjectModel
{
    static NSManagedObjectModel* instance_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL* url = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
        instance_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    });
    return instance_;
}

+(NSPersistentStoreCoordinator*)persistentStoreCoordinator
{
    static NSPersistentStoreCoordinator* instance_;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    });
    return instance_;
}



@end
