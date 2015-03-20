//
//  PersistancyManager.m
//  TigerSpikeTest
//
//  Created by Rafal Wesolowski on 19/03/2015.
//  Copyright (c) 2015 Raf. All rights reserved.
//

#import "PersistancyManager.h"

@interface PersistancyManager ()

@end

@implementation PersistancyManager

+ (void)persistObject:(NSArray *)response forUrl:(NSString *)url {
    [[NSUserDefaults standardUserDefaults] setObject:response forKey:url];
}

+ (NSArray *)readPersistedObjectForKey:(NSString *)url {
    return (NSArray *)[[NSUserDefaults standardUserDefaults] objectForKey:url];
}

- (id)initWithFlickrsArray:(NSArray *)array {
    self = [super init];
    if (self) {
        self.flickrs = [NSMutableArray arrayWithArray:array];
        [self sortFlickrsByDateTaken];
    }
    return self;
}

-(NSArray *)sortFlickrsByDateTaken {
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"dateTaken" ascending:NO];
    NSArray *sortDescriptor = [NSArray arrayWithObjects:descriptor, nil];
    [self.flickrs sortUsingDescriptors:sortDescriptor];
    return self.flickrs;
}

- (void)persistImage:(UIImage*)image withFilename:(NSString*)filename {
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Images/%@", filename];
    NSData *data = UIImagePNGRepresentation(image);
    [data writeToFile:filename atomically:YES];
}

- (UIImage*)getImage:(NSString*)filename {
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Images/%@", filename];
    NSData *data = [NSData dataWithContentsOfFile:filename];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

@end
