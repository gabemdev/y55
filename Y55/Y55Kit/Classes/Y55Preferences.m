//
//  Y55Preferences.m
//  Y55
//
//  Created by Rockstar. on 11/26/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "Y55Preferences.h"
#import "NSUserDefaults+Y55.h"

@interface Y55Preferences ()
@property (nonatomic) NSDictionary *defaults;
@end

@implementation Y55Preferences

#pragma mark - Accessors

@synthesize defaults = _defaults;

- (void)registerDefaults:(NSDictionary *)defaults {
    self.defaults = defaults;
}

- (id)objectForKey:(NSString *)key {
    id value = [[self defaultsStore] objectForKey:key];
    if (!value) {
        value = self.defaults[key];
    }
    return value;
}

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key {
    [[self defaultsStore] setObject:object forKey:key];
    [[self iCloudStore] removeObjectForKey:key];
}

- (void)removeObjectForKey:(NSString *)key {
    [[self defaultsStore] removeObjectForKey:key];
    [[self iCloudStore] removeObjectForKey:key];
}

- (void)synchronize {
    [[self iCloudStore] synchronize];
    [[self defaultsStore] synchronize];
}

#pragma mark - Singleton

+ (instancetype)sharedPreferences {
    static Y55Preferences *preferences;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        preferences = [[self alloc] init];
    });
    return preferences;
}

#pragma mark - NSObject

- (instancetype)init {
    if ((self = [super init])) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(iCloudStoreDidChange:)
                                                     name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Private
- (NSUserDefaults *)defaultsStore {
    return [NSUserDefaults y55_sharedDefaults];
}

- (NSUbiquitousKeyValueStore *)iCloudStore {
    return [NSUbiquitousKeyValueStore defaultStore];
}

- (void)iCloudStoreDidChange:(NSNotification *)notification {
    NSDictionary *iCloud = [[self iCloudStore] dictionaryRepresentation];
    for (NSString *key in iCloud) {
        [[self defaultsStore] setObject:iCloud[key] forKey:key];
    }
}

@end
