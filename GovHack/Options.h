//
//  Options.h
//  GovHack
//
//  Created by Myles on 1/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Options : NSObject

+(Options*)sharedInstance;

@property (copy, nonatomic) NSString* baseURL;




@end
