//
//  PersistancyManager.m
//  TigerSpikeTest
//
//  Created by Rafal Wesolowski on 19/03/2015.
//  Copyright (c) 2015 Raf. All rights reserved.
//

#import "PersistancyManager.h"

@interface PersistancyManager () {
    NSMutableArray *flickrs;
}
@end

@implementation PersistancyManager

- (id)initWithFlickrsArray:(NSArray *)array {
    self = [super init];
    if (self) {
        flickrs = [NSMutableArray arrayWithArray:array];
    }
    return self;
}

- (NSArray*)getFlickrs {
    return flickrs;
}

@end
