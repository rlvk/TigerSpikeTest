//
//  HorizontalScrollView.h
//  TigerSpikeTest
//
//  Created by Rafal Wesolowski on 19/03/2015.
//  Copyright (c) 2015 Raf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HorizontalScrollViewDelegate;

@interface HorizontalScrollView : UIView
@property (weak) id<HorizontalScrollViewDelegate> delegate;
- (void)reload;
@end

@protocol HorizontalScrollViewDelegate <NSObject>
@required
- (NSInteger)numberOfViewsForHorizontalScroller:(HorizontalScrollView *)scroller;
- (UIView*)horizontalScroller:(HorizontalScrollView *)scroller viewAtIndex:(int)index;
- (void)horizontalScroller:(HorizontalScrollView *)scroller clickedViewAtIndex:(int)index;
@end
