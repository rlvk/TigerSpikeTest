//
//  FlickrItem.h
//  TigerSpikeTest
//
//  Created by Rafal Wesolowski on 19/03/2015.
//  Copyright (c) 2015 Raf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrItem : NSObject

@property (strong, readonly) NSString *title;
@property (strong, readonly) NSString *link;
@property (strong, readonly) NSString *mediaLink;
@property (strong, readonly) NSString *desc;
@property (strong, readonly) NSDate *dateTaken;
@property (strong, readonly) NSDate *datePublished;
@property (strong, readonly) NSString *author;
@property (strong, readonly) NSDictionary *metaData;

-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
