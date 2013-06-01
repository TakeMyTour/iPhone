//
//  Image.h
//  GovHack
//
//  Created by Myles on 1/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Node;

@interface Image : NSManagedObject


+(Image*)createLocal;

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) Node *images_node_inv;

@end
