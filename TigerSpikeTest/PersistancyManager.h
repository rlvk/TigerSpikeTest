//
//  PersistancyManager.h
//  TigerSpikeTest
//
//  Created by Rafal Wesolowski on 19/03/2015.
//  Copyright (c) 2015 Raf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersistancyManager : NSObject
- (id)initWithFlickrsArray:(NSArray *)array;
- (NSArray *)getFlickrs;
- (void)persistImage:(UIImage*)image withFilename:(NSString*)filename;
- (UIImage*)getImage:(NSString*)filename;
@end
