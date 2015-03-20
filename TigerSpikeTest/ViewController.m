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
/*
 * Main ViewController containing horizontal scroll view filled with the images from Flickr API
 */
@interface ViewController () <HorizontalScrollViewDelegate, UIActionSheetDelegate, UISearchBarDelegate> {
    WebClient *webClient;
    HorizontalScrollView *scrollView;
    NSInteger selectedIndex;
    UISearchBar *searchBarView;
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
    searchBarView = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 60)];
    searchBarView.placeholder = @"Enter keyword";
    searchBarView.delegate = self;
    [self.view addSubview:searchBarView];
    
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

#pragma mark - API(Notifications) callback methods

-(void)onSuccess:(NSNotification*)notification {
    NSArray *responseArray = notification.userInfo[@"response"];
    NSLog(@"Response %@", responseArray);
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

#pragma mark - UIActionSheet delegate methods

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    FlickrItem *selectedItem = [self.flickrArray objectAtIndex:selectedIndex];
    switch (buttonIndex) {
        case 0:
            [AlertDialog showAlertViewWithInfo:[NSString stringWithFormat:@"%@", selectedItem.metaData]];
            break;
        default:
            break;
    }
}

#pragma mark - Horizontal ScrollView delegate methods

- (NSInteger)numberOfViewsForHorizontalScroller:(HorizontalScrollView*)scroller {
    return self.flickrArray.count;
}

- (void)horizontalScroller:(HorizontalScrollView *)scroller clickedViewAtIndex:(int)index {
    selectedIndex = index;
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"More" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Metadata", nil];
    [actionSheet showInView:self.view];
}

- (UIView*)horizontalScroller:(HorizontalScrollView*)scroller viewAtIndex:(int)index {
    FlickrItem *flickr = (FlickrItem *)[self.flickrArray objectAtIndex:index];
    FlickrView *view = [[FlickrView alloc] initWithFrame:CGRectMake(0, 0, 200, 200) andImage:flickr.mediaLink];
    return view;
}

#pragma mark - UISearchBar delegate methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self handleSearch:searchBar];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self handleSearch:searchBar];
}

- (void)handleSearch:(UISearchBar *)searchBar {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Search for first occurence
        for (FlickrItem *flickr in self.flickrArray) {
            if ([flickr.tag rangeOfString:searchBar.text].location == NSNotFound) {
                
            } else {
                 dispatch_async(dispatch_get_main_queue(), ^{
                    [scrollView scrollToViewAtIndex:[self.flickrArray indexOfObject:flickr]];
                     return;
                 });
            }
        }
    });
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    [searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
