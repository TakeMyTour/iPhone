//
//  Tour.h
//  GovHack
//
//  Created by Myles on 2/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BaseObject.h"

@class Node, User;

@interface Tour : BaseObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * tour_type;
@property (nonatomic, retain) NSOrderedSet *nodes;
@property (nonatomic, retain) User *tours_user_inverse;
@end

@interface Tour (CoreDataGeneratedAccessors)

- (void)insertObject:(Node *)value inNodesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromNodesAtIndex:(NSUInteger)idx;
- (void)insertNodes:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeNodesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInNodesAtIndex:(NSUInteger)idx withObject:(Node *)value;
- (void)replaceNodesAtIndexes:(NSIndexSet *)indexes withNodes:(NSArray *)values;
- (void)addNodesObject:(Node *)value;
- (void)removeNodesObject:(Node *)value;
- (void)addNodes:(NSOrderedSet *)values;
- (void)removeNodes:(NSOrderedSet *)values;
@end
