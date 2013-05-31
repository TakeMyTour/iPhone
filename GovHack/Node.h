//
//  Node.h
//  GovHack
//
//  Created by Myles on 31/05/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

-(id)init;

-(id)init:(NSString*)name;


@property (copy, nonatomic) NSString* name;
@property (copy, nonatomic) NSString* description;
@property (retain, nonatomic) NSMutableArray* images;

@end
