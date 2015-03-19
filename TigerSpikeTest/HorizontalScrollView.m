//
//  HorizontalScrollView.m
//  TigerSpikeTest
//
//  Created by Rafal Wesolowski on 19/03/2015.
//  Copyright (c) 2015 Raf. All rights reserved.
//

#import "HorizontalScrollView.h"

#define ITEM_SIZE 200
#define ITEM_OFFSET 150
#define ITEM_PADDING 10

@interface HorizontalScrollView () <UIScrollViewDelegate> {
    UIScrollView *scrollView;
}
@end

@implementation HorizontalScrollView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scrollView.delegate = self;
        [self addSubview:scrollView];
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
        [scrollView addGestureRecognizer:tapRecognizer];
    }
    return self;
}

- (void)imageTapped:(UITapGestureRecognizer*)gesture {
    CGPoint location = [gesture locationInView:gesture.view];
    for (int index=0; index<[self.delegate numberOfViewsForHorizontalScroller:self]; index++) {
        UIView *view = scrollView.subviews[index];
        if (CGRectContainsPoint(view.frame, location)) {
            [self.delegate horizontalScroller:self clickedViewAtIndex:index];
            break;
        }
    }
}

- (void)reload {
    if (self.delegate == nil) {
        return;
    }
    
    [scrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    
    CGFloat xValue = ITEM_OFFSET;
    for (int index = 0; index < [self.delegate numberOfViewsForHorizontalScroller:self]; index++)  {
        xValue += ITEM_PADDING;
        UIView *view = [self.delegate horizontalScroller:self viewAtIndex:index];
        view.frame = CGRectMake(xValue, ITEM_PADDING, ITEM_SIZE, ITEM_SIZE);
        [scrollView addSubview:view];
        xValue += ITEM_SIZE + ITEM_PADDING;
    }
    
    [scrollView setContentSize:CGSizeMake(xValue + ITEM_OFFSET, self.frame.size.height)];
}

@end
