//
//  User.h
//  GovHack
//
//  Created by Myles on 2/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BaseObject.h"

@class Tour;

@interface User : BaseObject

@property (nonatomic, retain) NSSet *tours;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addToursObject:(Tour *)value;
- (void)removeToursObject:(Tour *)value;
- (void)addTours:(NSSet *)values;
- (void)removeTours:(NSSet *)values;

@end
