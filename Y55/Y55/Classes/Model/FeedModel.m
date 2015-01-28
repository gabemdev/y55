//
//  FeedModel.m
//  Y55
//
//  Created by Rockstar. on 1/26/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "FeedModel.h"

static NSString *const kPersistKey = @"Y55.Y55FeedKey";

@interface FeedModel ()
@property (nonatomic) NSDictionary *attributes;
- (void)setAttributes:(NSDictionary *)attributes;

- (NSDictionary *)load;
- (BOOL)persist;

@end

@implementation FeedModel

+ (FeedModel *)sharedInstance {
    static dispatch_once_t once;
    static FeedModel *instance;
    dispatch_once(&once, ^{
        instance = [[FeedModel alloc] init];
        [instance load];
    });
    return instance;
}

#pragma mark - Attributes
@synthesize attributes = _attributes;

- (void)setAttributes:(NSDictionary *)attributes {
    if (![_attributes isEqualToDictionary:attributes]) {
        _attributes = attributes;
        
        if (attributes) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSDictionary *info = [attributes objectForKey:@"info"];
                self.cellImage = [NSString stringWithFormat:@"%@", info[@"cellImage"]];
                self.notificationIcon = [NSString stringWithFormat:@"%@", info[@"icon"]];
                self.userImage = [NSString stringWithFormat:@"%@", info[@"user"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.fromTitle = info[@"from"];
                    self.notificationTitle = [NSString stringWithFormat:@"%@", info[@"notification"]];
                    self.notificationColor = [NSString stringWithFormat:@"%@", info[@"notColor"]];
                    self.time = [NSString stringWithFormat:@"%@", info[@"time"]];
                });
            });
        }
    }
}

- (NSDictionary *)load {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = (NSData *)[userDefaults objectForKey:kPersistKey];
    self.attributes = (NSDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    return self.attributes;
}

- (BOOL)persist {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = (NSData *)[NSKeyedArchiver archivedDataWithRootObject:self.attributes];
    [userDefaults setObject:data forKey:kPersistKey];
    BOOL retVal = [userDefaults synchronize];
    if (retVal) {
        NSLog(@"Success");
    } else {
        NSLog(@"Failure");
    }
    return retVal;
}

#pragma mark - init
- (void)initWithDictionary:(NSDictionary *)dictionary {
    self.attributes = dictionary;
    [self persist];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Init With Dict" object:nil];
}

- (void)initWithTitle:(NSString *)fromTitle cellImage:(NSString *)cellImage notificationIcon:(NSString *)notificationIcon notificationTitle:(NSString *)notificationTitle notificationColor:(NSString *)notificationColor andTime:(NSString *)time {
    self.fromTitle = fromTitle;
    self.cellImage = cellImage;
    self.notificationIcon = notificationIcon;
    self.notificationTitle = notificationTitle;
    self.notificationColor = notificationColor;
    self.time = time;
}

- (instancetype)initWithDetailView:(NSString *)plistName {
    if ((self = [super init])) {
        NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        self.tableArray = [NSMutableArray arrayWithContentsOfFile:path];
        self.titleCount = [self.tableArray count];
    }
    return self;
}

@end
