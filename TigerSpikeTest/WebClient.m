//
//  WebClient.m
//  TigerSpikeTest
//
//  Created by Rafal Wesolowski on 19/03/2015.
//  Copyright (c) 2015 Raf. All rights reserved.
//

#import "WebClient.h"
#import "PersistancyManager.h"

@interface WebClient () {
    PersistancyManager *persistencyManager;
}

@end

@implementation WebClient

+ (WebClient *)clientSharedInstance {
    static WebClient *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [WebClient new];
    });
    return _sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        persistencyManager = [PersistancyManager new];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadImage:) name:@"DownloadFlickrImageNotification" object:nil];
    }
    return self;
}

- (NSArray*)getFlickers {
    return [persistencyManager getFlickrs];
}

- (void)downloadImage:(NSNotification*)notification {
    UIImageView *imageView = notification.userInfo[@"imageView"];
    NSString *coverUrl = notification.userInfo[@"imageURL"];
    
    NSURLSessionDownloadTask *getImageTask = [[NSURLSession sharedSession] downloadTaskWithURL:[NSURL URLWithString:coverUrl] completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            imageView.image = downloadedImage;
            [persistencyManager persistImage:downloadedImage withFilename:[coverUrl lastPathComponent]];
        });
    }];
    
    [getImageTask resume];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
