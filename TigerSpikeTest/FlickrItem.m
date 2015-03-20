//
//  FlickrItem.m
//  TigerSpikeTest
//
//  Created by Rafal Wesolowski on 19/03/2015.
//  Copyright (c) 2015 Raf. All rights reserved.
//

#import "FlickrItem.h"
#import "NSString+DateConverter.h"
#import <ImageIO/ImageIO.h>

@implementation FlickrItem

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self == [super init]) {
        _title = [dictionary objectForKey:@"title"];
        _link = [dictionary objectForKey:@"link"];
        _mediaLink = [[dictionary objectForKey:@"media"] objectForKey:@"m"];
        _dateTaken = [NSString convertDateFromString:[dictionary objectForKey:@"date_taken"]];
        _desc = [dictionary objectForKey:@"description"];
        _author = [dictionary objectForKey:@"author"];
        _tag = [dictionary objectForKey:@"tags"];
        //Meta data calculation needs to be performed in the background
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            CGImageSourceRef source = CGImageSourceCreateWithURL( (CFURLRef) [NSURL URLWithString:_mediaLink], NULL);
            _metaData = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(source, 0, NULL));
        });
    }
    return self;
}

@end
