//
//  Options.m
//  GovHack
//
//  Created by Myles on 1/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "Options.h"
#import "project.h"

@implementation Options



@synthesize baseURL = _baseURL;

+(Options*)sharedInstance
{
    static Options* __options = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __options = [[Options alloc] init];
        
        // This is where we may choose to load options from a file
        __options.baseURL = @"http://unleashed.oeg.com.au";
        
    });
    return __options;
}




-(void)setBaseURL:(NSString *)baseURL
{
    _baseURL = [baseURL copy];
    [ClientManager clearCurrentClient];
}







@end
