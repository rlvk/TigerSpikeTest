//
//  WebClient.m
//  TigerSpikeTest
//
//  Created by Rafal Wesolowski on 19/03/2015.
//  Copyright (c) 2015 Raf. All rights reserved.
//

#import "WebClient.h"

@implementation WebClient

+ (WebClient *)clientSharedInstance {
    static WebClient *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [WebClient new];
    });
    return _sharedInstance;
}

@end
