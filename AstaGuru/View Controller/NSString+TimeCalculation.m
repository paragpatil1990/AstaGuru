//
//  NSString+TimeCalculation.m
//  FriendsnFans
//
//  Created by Rohan Pawar on 15/07/15.
//  Copyright (c) 2015 Rohan Pawar. All rights reserved.
//

#import "NSString+TimeCalculation.h"

@implementation NSString (TimeCalculation)

+(NSString*)calculatePostTimeForIndexPath:(NSString*)dateStr
{
    //calculate past time.
    
    NSString *timeLeft;
    
    NSDate *today10am =[NSDate date];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"yyyy-mm-dd HH:mm:ss"];
    
    NSString *dateString = [dateFormat stringFromDate:today10am];
    
    NSDate *ToDate = [dateFormat dateFromString:dateString];
    
    NSDate *date = [dateFormat dateFromString:dateStr];
    
    NSInteger seconds = [ToDate timeIntervalSinceDate:date];
    
    NSInteger days = (int) (floor(seconds / (3600 * 24)));
    if(days) seconds -= days * 3600 * 24;
    
    NSInteger hours = (int) (floor(seconds / 3600));
    if(hours) seconds -= hours * 3600;
    
    NSInteger minutes = (int) (floor(seconds / 60));
    if(minutes) seconds -= minutes * 60;
    
    if(days)
    {
        timeLeft = [NSString stringWithFormat:@"%ld days ago", (long)days*-1];
    }
    else if(hours)
    {
        timeLeft = [NSString stringWithFormat: @"%ld hrs ago", (long)hours*-1];
    }
    else if(minutes)
    {
        timeLeft = [NSString stringWithFormat: @"%ld mins ago", (long)minutes*-1];
    }
    else if(seconds)
        timeLeft = [NSString stringWithFormat: @"now"];

//        timeLeft = [NSString stringWithFormat: @"%ld seconds ago", (long)seconds*-1];
    
    NSString *stringWithoutSpaces = [timeLeft
                                     stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return stringWithoutSpaces;
}

+(NSString*)calculatePostTimeWithStartDate:(NSString*)startDate AndEndDate:(NSString *)endDate
{
    //calculate past time.
    
    NSString *timeLeft;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-mm-dd HH:mm:ss"];
    
    NSDate *sDate = [dateFormat dateFromString:startDate];
    NSDate *eDate = [dateFormat dateFromString:endDate];
    
    NSInteger seconds = [sDate timeIntervalSinceDate:eDate];
    NSInteger days = (int) (floor(seconds / (3600 * 24)));
    if(days) seconds -= days * 3600 * 24;
    
    NSInteger hours = (int) (floor(seconds / 3600));
    if(hours) seconds -= hours * 3600;
    
    NSInteger minutes = (int) (floor(seconds / 60));
    if(minutes) seconds -= minutes * 60;
    
    if(days)
    {
        timeLeft = [NSString stringWithFormat:@"%ld Days", (long)days*-1];
    }
    else if(hours)
    {
        timeLeft = [NSString stringWithFormat: @"%ld Hrs", (long)hours*-1];
    }
    else if(minutes)
    {
        timeLeft = [NSString stringWithFormat: @"%ld Mins", (long)minutes*-1];
    }
    else if(seconds)
        timeLeft = [NSString stringWithFormat: @"%ld Sens ", (long)seconds*-1];
    
    NSString *stringWithoutSpaces = [timeLeft
                                     stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return stringWithoutSpaces;
}

+(NSString *)StringFromDate:(NSString *)DateLocal
{
//    NSString *myString = @"2012-11-22 10:19:04";
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *yourDate = [dateFormatter dateFromString:DateLocal];
    dateFormatter.dateFormat = @"dd MMM yyyy";
//    NSLog(@"%@",[dateFormatter stringFromDate:yourDate]);
    return [dateFormatter stringFromDate:yourDate];
}


@end
