//
//  ClientManager.h
//  GovHack
//
//  Created by Myles on 1/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface ClientManager : NSObject

+(AFHTTPClient*)sharedClient;


+(void)clearCurrentClient;


+(NSMutableURLRequest*)requestWithMethod:(NSString*)method path:(NSString*)path parameters:(NSDictionary*)params;
@end
