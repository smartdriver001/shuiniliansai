//
//  BLAFAppAPIClient.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-19.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLAFAppAPIClient.h"
#import "AFJSONRequestOperation.h"

@implementation BLAFAppAPIClient


+ (BLAFAppAPIClient *)sharedClient {
    static BLAFAppAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[BLAFAppAPIClient alloc] initWithBaseURL:[NSURL URLWithString:base_url]];
    });
    
    return _sharedClient;
}


- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
//	[self setDefaultHeader:@"Accept" value:@"application/json"];
    [self setDefaultHeader:@"Accept" value:@"text/xml"];

    return self;
}

+ (BLAFAppAPIClient *)sharedClientAPI {
    static BLAFAppAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[BLAFAppAPIClient alloc] initWithBaseURLAPI:[NSURL URLWithString:newAPI]];
    });
    
    return _sharedClient;
}


- (id)initWithBaseURLAPI:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
    //	[self setDefaultHeader:@"Accept" value:@"application/json"];
    [self setDefaultHeader:@"Accept" value:@"text/xml"];
    
    return self;
}
@end
