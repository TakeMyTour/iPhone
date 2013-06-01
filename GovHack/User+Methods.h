//
//  User+Methods.h
//  GovHack
//
//  Created by Myles on 1/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "User.h"

@interface User (Methods)

+(User*)sharedInstance;

+(User*)createLocal; // note.. not really public.. dont use this one.. this is meant to be a singleton.


+(User*)newObjectForID:(int)idValue;

@end
