//
//  ViewController.m
//  TigerSpikeTest
//
//  Created by Rafal Wesolowski on 19/03/2015.
//  Copyright (c) 2015 Raf. All rights reserved.
//

#import "ViewController.h"
#import "AlertDialog.h"
#import "HorizontalScrollView.h"

#define kFlickrURL @"http://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"

@interface ViewController () <HorizontalScrollViewDelegate> {
    NSURLSession *session;
    HorizontalScrollView *scrollView;
}
@property (nonatomic, strong) NSMutableArray *flickrArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    session = [NSURLSession sharedSession];
    
    self.flickrArray = [NSMutableArray new];
    scrollView = [[HorizontalScrollView alloc] initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, 220)];
    scrollView.backgroundColor = [UIColor blueColor];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:kFlickrURL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSLog(@"Response %@", json);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error == nil) {
                NSLog(@"Response %@", json);
                [scrollView reload];
            } else {
                NSLog(@"Error %@", error);
                [AlertDialog showAlertDialogWithTitle:@"Error" message:error.localizedDescription cancelButtonTitle:@"OK"];
            }
        });
    }];
    [dataTask resume];

}

- (NSInteger)numberOfViewsForHorizontalScroller:(HorizontalScrollView*)scroller {
    return 5;
}

- (UIView*)horizontalScroller:(HorizontalScrollView*)scroller viewAtIndex:(int)index {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 100)];
    view.backgroundColor = [UIColor redColor];
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
