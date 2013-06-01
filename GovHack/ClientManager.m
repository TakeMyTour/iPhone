//
//  ClientManager.m
//  GovHack
//
//  Created by Myles on 1/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "ClientManager.h"
#import "project.h"

@implementation ClientManager

static AFHTTPClient* client__ = nil;

+(AFHTTPClient*)sharedClient
{
    if (client__==nil)
    {
        client__ = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:[Options sharedInstance].baseURL]];
    }
    return client__;
}

+(void)clearCurrentClient
{
    if (client__)
    {
        [client__ release];
        client__ = nil;
    }
}

+(NSMutableURLRequest*)requestWithMethod:(NSString*)method path:(NSString*)path parameters:(NSDictionary*)params
{
    AFHTTPClient* client = [self sharedClient];
    NSMutableURLRequest* request = [client requestWithMethod:method path:path parameters:params];
    return request;
}



@end
