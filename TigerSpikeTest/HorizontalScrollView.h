//
//  HorizontalScrollView.h
//  TigerSpikeTest
//
//  Created by Rafal Wesolowski on 19/03/2015.
//  Copyright (c) 2015 Raf. All rights reserved.
//
/*
 * Container class for horizontall view of downloaded images
 */
#import <UIKit/UIKit.h>

@protocol HorizontalScrollViewDelegate;

@interface HorizontalScrollView : UIView
@property (weak) id<HorizontalScrollViewDelegate> delegate;
- (void)reload;
@end

@protocol HorizontalScrollViewDelegate <NSObject>
@required
//Calculates how many items(images) we have in the horizontal scroller
- (NSInteger)numberOfViewsForHorizontalScroller:(HorizontalScrollView *)scroller;
//Determines which view we currently process
- (UIView*)horizontalScroller:(HorizontalScrollView *)scroller viewAtIndex:(int)index;
//Indicates which item has been clicked
- (void)horizontalScroller:(HorizontalScrollView *)scroller clickedViewAtIndex:(int)index;
@end
