//
//  NSString+DateConverter.m
//  TigerSpikeTest
//
//  Created by Rafal Wesolowski on 19/03/2015.
//  Copyright (c) 2015 Raf. All rights reserved.
//

#import "NSString+DateConverter.h"

@implementation NSString (DateConverter)

+(NSDate *)convertDateFromString:(NSString *)stringDate {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *dateFromString = [NSDate new];
    dateFromString = [dateFormatter dateFromString:stringDate];
    return dateFromString;
}

@end
