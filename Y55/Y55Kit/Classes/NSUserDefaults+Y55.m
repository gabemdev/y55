//
//  NSUserDefaults+Y55.m
//  Y55
//
//  Created by Rockstar. on 11/26/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "NSUserDefaults+Y55.h"

@implementation NSUserDefaults (Y55)

+ (instancetype)y55_sharedDefaults {
    static NSUserDefaults *defaults;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaults = [[self alloc] initWithSuiteName:@"group.com.gabemdev.y55"];
    });
    return defaults;
}

@end
