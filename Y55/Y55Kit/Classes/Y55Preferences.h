//
//  Y55Preferences.h
//  Y55
//
//  Created by Rockstar. on 11/26/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Y55Preferences : NSObject

+ (instancetype)sharedPreferences;

- (void)registerDefaults:(NSDictionary *)defaults;
- (id)objectForKey:(NSString *)key;
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key;

- (void)synchronize;

@end
