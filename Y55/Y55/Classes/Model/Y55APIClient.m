//
//  Y55APIClient.m
//  Y55
//
//  Created by Rockstar. on 12/9/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import "Y55APIClient.h"

@interface Y55APIClient ()
@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) NSString *accessTokenSecret;
@end

@implementation Y55APIClient

+ (Y55APIClient *)sharedInstance {
    static dispatch_once_t once;
    static Y55APIClient *instance;
    dispatch_once(&once, ^{
        instance = [[Y55APIClient alloc] init];
    });
    return instance;
}

- (void)setAccessToken:(NSString *)accessToken secret:(NSString *)secret
{
    self.accessToken = [accessToken copy];
    self.accessTokenSecret = [secret copy];
}


@end
