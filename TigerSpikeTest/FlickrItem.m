//
//  FlickrItem.m
//  TigerSpikeTest
//
//  Created by Rafal Wesolowski on 19/03/2015.
//  Copyright (c) 2015 Raf. All rights reserved.
//

#import "FlickrItem.h"

@implementation FlickrItem

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self == [super init]) {
        _title = [dictionary objectForKey:@"title"];
        _link = [dictionary objectForKey:@"link"];
        _mediaLink = [[dictionary objectForKey:@"media"] objectForKey:@"m"];
        _dateTaken = [dictionary objectForKey:@"date_taken"];
        _desc = [dictionary objectForKey:@"description"];
        _author = [dictionary objectForKey:@"author"];
    }
    return self;
}

@end
