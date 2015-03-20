//
//  WebClient.m
//  TigerSpikeTest
//
//  Created by Rafal Wesolowski on 19/03/2015.
//  Copyright (c) 2015 Raf. All rights reserved.
//

#import "WebClient.h"

@interface WebClient ()

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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadImage:) name:@"DownloadFlickrImageNotification" object:nil];
    }
    return self;
}

//We download the feed of flickrs and pass the result to the view controller using NSNotificationCenter
-(void)getLatestImages:(NSURL *)URL {
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error == nil) {
            NSArray *array = [json objectForKey:@"items"];
            self.persistencyManager = [[PersistancyManager alloc] initWithFlickrsArray:array];
            NSArray *sortedArray = [self.persistencyManager sortFlickrsByDateTaken];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"FlickrImagesSuccessResponse"
                                                                object:self
                                                              userInfo:@{@"response":sortedArray}];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"FlickrImagesError"
                                                                object:self
                                                              userInfo:@{@"error":error}];
        }
    }];
    [dataTask resume];
}

//Downloading image from remote URL address
- (void)downloadImage:(NSNotification*)notification {
    UIImageView *imageView = notification.userInfo[@"imageView"];
    NSString *imageURL = notification.userInfo[@"imageURL"];
    
    NSURLSessionDownloadTask *getImageTask = [[NSURLSession sharedSession] downloadTaskWithURL:[NSURL URLWithString:imageURL] completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            imageView.image = downloadedImage;
            [self.persistencyManager persistImage:downloadedImage withFilename:[imageURL lastPathComponent]];
        });
    }];
    
    [getImageTask resume];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
