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
#import "PersistancyManager.h"

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

-(void)viewWillAppear:(BOOL)animated {
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSuccess:) name:@"FlickrImagesSuccessResponse" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onError:) name:@"FlickrImagesError" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)reloadData {
    [self.flickrArray removeAllObjects];
    [webClient getLatestImages:[NSURL URLWithString:kFlickrURL]];
}

-(void)onSuccess:(NSNotification*)notification {
    NSArray *responseArray = notification.userInfo[@"response"];
    [PersistancyManager persistObject:responseArray forUrl:kFlickrURL];
    for (NSDictionary *dict in responseArray) {
        [self.flickrArray addObject:[[FlickrItem alloc] initWithDictionary:dict]];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [scrollView reload];
    });
}

-(void)onError:(NSNotification*)notification {
    NSArray *responseArray = [PersistancyManager readPersistedObjectForKey:kFlickrURL];
    for (NSDictionary *dict in responseArray) {
        [self.flickrArray addObject:[[FlickrItem alloc] initWithDictionary:dict]];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [AlertDialog showAlertDialogWithTitle:@"Error" message:@"Internet connection appears to be offline" cancelButtonTitle:@"OK"];
        [scrollView reload];
    });
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
