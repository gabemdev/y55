//
//  Y55APIClient.h
//  Y55
//
//  Created by Rockstar. on 12/9/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Y55APIClient : NSObject

+ (Y55APIClient *)sharedInstance;

- (void)setAccessToken:(NSString *)accessToken secret:(NSString *)secret;

@end
