//
//  LocalyticsUtilities.m
//  Localytics
//
//  Created by Rockstar. on 11/26/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "LocalyticsUtilities.h"

void LLStartSession(NSString *key) {
#if ANALYTICS_ENABLED
	[[LocalyticsSession sharedLocalyticsSession] LocalyticsSession:(key)];
#endif
}


void LLTagEvent(NSString *name) {
#if ANALYTICS_ENABLED
	[[LocalyticsSession sharedLocalyticsSession] tagEvent:name];
#endif
}


void LLTagEventWithAttributes(NSString *name, NSDictionary *attributes) {
#if ANALYTICS_ENABLED
	[[LocalyticsSession sharedLocalyticsSession] tagEvent:name attributes:attributes];
#endif
}


void LLTagScreen(NSString *screen) {
#if ANALYTICS_ENABLED
	[[LocalyticsSession sharedLocalyticsSession] tagScreen:screen];
#endif
}
