//
//  NSString+DateConverter.h
//  TigerSpikeTest
//
//  Created by Rafal Wesolowski on 19/03/2015.
//  Copyright (c) 2015 Raf. All rights reserved.
//
/*
 * Category on NSString used for converting date to string purposes
 */
#import <Foundation/Foundation.h>

@interface NSString (DateConverter)
+(NSDate *)convertDateFromString:(NSString *)stringDate;
@end
