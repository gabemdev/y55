//
//  TwitterAdapter.h
//  Y55
//
//  Created by Rockstar. on 11/29/14.
//  Copyright (c) 2014 Gabe Morales. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwitterAdapter : NSObject

@property (nonatomic) TWTRSession *mainSession;
@property (nonatomic) TWTRUser *mainUser;

- (void)getTwitterProfileWithCompletion:(void (^)(NSDictionary* jsonResponse))completion;
- (void)accessTwitterAccountWithUser: (TWTRUser *)user;

@end
