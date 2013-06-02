//
//  Node.h
//  GovHack
//
//  Created by Myles on 2/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BaseObject.h"

@class Image, Tour;

@interface Node : BaseObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * description_text;
@property (nonatomic, retain) NSNumber * gps_latitude;
@property (nonatomic, retain) NSNumber * gps_longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * hasBeenSeen;
@property (nonatomic, retain) NSString * hint_image;
@property (nonatomic, retain) NSString * hint_desc;
@property (nonatomic, retain) NSOrderedSet *images;
@property (nonatomic, retain) Tour *nodes_inverse;
@end

@interface Node (CoreDataGeneratedAccessors)

- (void)insertObject:(Image *)value inImagesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromImagesAtIndex:(NSUInteger)idx;
- (void)insertImages:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeImagesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInImagesAtIndex:(NSUInteger)idx withObject:(Image *)value;
- (void)replaceImagesAtIndexes:(NSIndexSet *)indexes withImages:(NSArray *)values;
- (void)addImagesObject:(Image *)value;
- (void)removeImagesObject:(Image *)value;
- (void)addImages:(NSOrderedSet *)values;
- (void)removeImages:(NSOrderedSet *)values;
@end
