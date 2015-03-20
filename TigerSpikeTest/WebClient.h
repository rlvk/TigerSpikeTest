//
//  WebClient.h
//  TigerSpikeTest
//
//  Created by Rafal Wesolowski on 19/03/2015.
//  Copyright (c) 2015 Raf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PersistancyManager.h"

@interface WebClient : NSObject
@property (nonatomic, strong) PersistancyManager *persistencyManager;
//Singletion for API instance
+ (WebClient *)clientSharedInstance;
-(void)getLatestImages:(NSURL *)URL;
@end
