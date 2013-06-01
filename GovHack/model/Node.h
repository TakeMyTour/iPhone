//
//  Node.h
//  GovHack
//
//  Created by Myles on 1/06/13.
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
@property (nonatomic, retain) Tour *nodes_inverse;
@property (nonatomic, retain) NSSet *images;
@end

@interface Node (CoreDataGeneratedAccessors)

- (void)addImagesObject:(Image *)value;
- (void)removeImagesObject:(Image *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

@end
