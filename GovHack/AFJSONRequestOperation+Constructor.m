//
//  AFJSONRequestOperation+Constructor.m
//  GovHack
//
//  Created by Myles on 1/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "AFJSONRequestOperation+Constructor.h"

@implementation AFJSONRequestOperation (Constructor)

+ (AFJSONRequestOperation*)JSONRequestOperationWithRequest:(NSURLRequest*)urlRequest
                                                  success_:(void(^)(AFJSONRequestOperation*))success
                                                  failure_:(void(^)(AFJSONRequestOperation*))failure
{
    AFJSONRequestOperation *requestOperation = [[AFJSONRequestOperation alloc] initWithRequest:urlRequest];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success)
        {
            success((AFJSONRequestOperation*)operation);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure)
        {
            failure((AFJSONRequestOperation*)operation);
        }
    }];
    
    return requestOperation;
}


@end
