//
//  ViewController.m
//  TigerSpikeTest
//
//  Created by Rafal Wesolowski on 19/03/2015.
//  Copyright (c) 2015 Raf. All rights reserved.
//

#import "ViewController.h"
#import "AlertDialog.h"

#define kFlickrURL @"http://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"

@interface ViewController () {
    NSURLSession *session;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:kFlickrURL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSLog(@"Response %@", json);
        if (error == nil) {
            NSLog(@"Response %@", json);
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"Error %@", error);
                [AlertDialog showAlertDialogWithTitle:@"Error" message:error.localizedDescription cancelButtonTitle:@"OK"];
            });
        }
    }];
    [dataTask resume];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
