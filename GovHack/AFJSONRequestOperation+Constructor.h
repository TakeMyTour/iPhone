//
//  AFJSONRequestOperation+Constructor.h
//  GovHack
//
//  Created by Myles on 1/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "AFJSONRequestOperation.h"

@interface AFJSONRequestOperation (Constructor)
+ (AFJSONRequestOperation*)JSONRequestOperationWithRequest:(NSURLRequest*)urlRequest
                                                  success_:(void(^)(AFJSONRequestOperation*))success
                                                  failure_:(void(^)(AFJSONRequestOperation*))failure;
@end
