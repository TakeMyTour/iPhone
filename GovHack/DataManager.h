//
//  DataManager.h
//  GovHack
//
//  Created by Myles on 1/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

+(void)save;
+(void)setup;
+(NSManagedObjectContext*)mainContext;
+(NSPersistentStoreCoordinator*)persistentStoreCoordinator;
+(NSManagedObjectModel*)managedObjectModel;


@end
