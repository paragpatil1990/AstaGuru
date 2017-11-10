//
//  NSString+TimeCalculation.h
//  FriendsnFans
//
//  Created by Rohan Pawar on 15/07/15.
//  Copyright (c) 2015 Rohan Pawar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TimeCalculation)
+(NSString*)calculatePostTimeForIndexPath:(NSString*)dateStr;
+(NSString*)calculatePostTimeWithStartDate:(NSString*)startDate AndEndDate:(NSString *)endDate;
+(NSString *)StringFromDate:(NSString *)DateLocal;

@end
