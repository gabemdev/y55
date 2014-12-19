//
//  Y55Defines.m
//  Y55
//
//  Created by Rockstar. on 11/26/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "Y55Defines.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

NSString *const kY55AutomaticallyRefresh = @"Y55AutomaticallyRefresh";
NSString *const kY55RoundTableDidChangeNotificationName = @"Y55RoundTableDidChangeNotificationName";
NSString *const kY55DisableSleepKey = @"Y55DisableSleep";


#pragma mark - Parse Constants
extern NSString *const Y55_PARSE_APPLICATION_ID;
extern NSString *const Y55_PARSE_CLIENT_KEY;

#pragma mark - Twitter Constants
NSString *const Y55_TWITTER_CONSUMER_KEY = @"liY7ntvqfryrLqnjcOeaXINwR";
NSString *const Y55_TWITTER_CONSUMER_SECRET = @"hnOGkbdboo6Sdoyk4N6LgJAxYdnT4MlMxH0bJMMZ0aEbLIvqSx";