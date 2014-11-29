//
//  Y55Defines.h
//  Y55
//
//  Created by Rockstar. on 11/26/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#ifndef Y55DEFINES
#define Y55DEFINES 1
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@import Foundation;

extern NSString *const kY55AutomaticallyRefresh;

extern NSString *const kY55RoundTableDidChangeNotificationName;



#endif


#pragma mark - Parse Constants
extern NSString *const Y55_PARSE_APPLICATION_ID;
extern NSString *const Y55_PARSE_CLIENT_KEY;

#pragma mark - Twitter Constants
extern NSString *const Y55_TWITTER_CONSUMER_KEY;
extern NSString *const Y55_TWITTER_CONSUMER_SECRET;