//
//  PersistancyManager.h
//  TigerSpikeTest
//
//  Created by Rafal Wesolowski on 19/03/2015.
//  Copyright (c) 2015 Raf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FlickrItem.h"

@interface PersistancyManager : NSObject
@property (nonatomic, strong) NSMutableArray *flickrs;

+ (void)persistObject:(NSArray *)response forUrl:(NSString *)URL;
+ (NSArray *)readPersistedObjectForKey:(NSString *)URL;

- (id)initWithFlickrsArray:(NSArray *)array;
- (void)persistImage:(UIImage *)image withFilename:(NSString *)filename;
- (UIImage *)getImage:(NSString *)filename;
-(NSArray *)sortFlickrsByDateTaken;

@end
