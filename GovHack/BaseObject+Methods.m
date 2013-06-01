//
//  BaseObject+initFromDictionary.m
//  GovHack
//
//  Created by Myles on 1/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "BaseObject+Methods.h"

@implementation BaseObject (Methods)

-(void)initFromDictionary:(NSDictionary*)dictionary
{
    self.id = [dictionary objectForKey:@"id"];
}


@end
