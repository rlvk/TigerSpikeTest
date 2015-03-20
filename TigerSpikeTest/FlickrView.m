//
//  FlickrView.m
//  TigerSpikeTest
//
//  Created by Rafal Wesolowski on 19/03/2015.
//  Copyright (c) 2015 Raf. All rights reserved.
//
/*
 * View representing single ImageView taken from the Flickr gallery
 */
#import "FlickrView.h"

@interface FlickrView() {
    UIImageView *flickrImage;
    UIActivityIndicatorView *indicator;
}
@end

@implementation FlickrView

- (id)initWithFrame:(CGRect)frame andImage:(NSString*)image {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        flickrImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:flickrImage];
        indicator = [UIActivityIndicatorView new];
        indicator.center = self.center;
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [indicator startAnimating];
        [self addSubview:indicator];
        
        [flickrImage addObserver:self forKeyPath:@"image" options:0 context:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DownloadFlickrImageNotification"
                                                            object:self
                                                          userInfo:@{@"imageView":flickrImage, @"imageURL":image}];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"image"]) {
        [indicator stopAnimating];
    }
}

- (void)dealloc {
    [flickrImage removeObserver:self forKeyPath:@"image"];
}


@end

