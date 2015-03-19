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
#import "FlickrItem.h"
#import "FlickrView.h"
#import "WebClient.h"

#define kFlickrURL @"http://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"

@interface ViewController () <HorizontalScrollViewDelegate> {
    WebClient *webClient;
    HorizontalScrollView *scrollView;
}
@property (nonatomic, strong) NSMutableArray *flickrArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    webClient = [WebClient clientSharedInstance];
    self.flickrArray = [NSMutableArray new];
    scrollView = [[HorizontalScrollView alloc] initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, 220)];
    scrollView.backgroundColor = [UIColor blueColor];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    [self reloadData];
}

-(void)reloadData {
    [self.flickrArray removeAllObjects];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:kFlickrURL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error == nil) {
            NSLog(@"Response %@", json);
            NSArray *responseArray = [json objectForKey:@"items"];
            for (NSDictionary *dict in responseArray) {
                [self.flickrArray addObject:[[FlickrItem alloc] initWithDictionary:dict]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [scrollView reload];
            });
        } else {
            NSLog(@"Error %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                [AlertDialog showAlertDialogWithTitle:@"Error" message:error.localizedDescription cancelButtonTitle:@"OK"];
            });
        }
    }];
    [dataTask resume];
}

- (void)horizontalScroller:(HorizontalScrollView *)scroller clickedViewAtIndex:(int)index {
    NSLog(@"Item clicked %d", index);
}

- (NSInteger)numberOfViewsForHorizontalScroller:(HorizontalScrollView*)scroller {
    return self.flickrArray.count;
}

- (UIView*)horizontalScroller:(HorizontalScrollView*)scroller viewAtIndex:(int)index {
    FlickrItem *flickr = (FlickrItem *)[self.flickrArray objectAtIndex:index];
    FlickrView *view = [[FlickrView alloc] initWithFrame:CGRectMake(0, 0, 200, 200) andImage:flickr.mediaLink];
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
