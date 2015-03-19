//
//  FlickrView.m
//  TigerSpikeTest
//
//  Created by Rafal Wesolowski on 19/03/2015.
//  Copyright (c) 2015 Raf. All rights reserved.
//

#import "FlickrView.h"

@interface FlickrView() {
    UIImageView *flickrImage;
}
@end

@implementation FlickrView

- (id)initWithFrame:(CGRect)frame andImage:(NSString*)image {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        flickrImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:flickrImage];
    }
    return self;
}

@end

